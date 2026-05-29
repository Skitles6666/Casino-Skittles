from __future__ import annotations

import itertools
import math
import random
from dataclasses import dataclass
from pathlib import Path


@dataclass(frozen=True)
class WheelConfig:
    name: str
    grid_side: int
    card_sizes: tuple[int, ...]
    seed: int


@dataclass
class Wheel:
    config: WheelConfig
    cards: list[tuple[int, tuple[int, ...]]]
    metrics: list[str]


CONFIGS = [
    WheelConfig("3x3 4-Spot / 20 Cards", 3, (4,) * 20, 104),
    WheelConfig("4x4 4-Spot / 20 Cards", 4, (4,) * 20, 404),
    WheelConfig("4x4 5-Spot / 20 Cards", 4, (5,) * 20, 405),
    WheelConfig("4x4 Mixed / 10 Four-Spots + 10 Five-Spots", 4, (4,) * 10 + (5,) * 10, 445),
]


def combinations(n: int, k: int) -> list[int]:
    masks = []
    for combo in itertools.combinations(range(n), k):
        mask = 0
        for bit in combo:
            mask |= 1 << bit
        masks.append(mask)
    return masks


def mask_to_positions(mask: int, n: int) -> tuple[int, ...]:
    return tuple(i + 1 for i in range(n) if mask & (1 << i))


def cluster_masks(n: int, low: int, high: int) -> dict[int, list[int]]:
    return {size: combinations(n, size) for size in range(low, high + 1)}


def build_candidate_data(n: int, sizes: tuple[int, ...]):
    min_size = min(sizes)
    max_size = max(sizes)
    max_cluster = min(n, max_size + 4)
    clusters = cluster_masks(n, min_size, max_cluster)
    candidates: list[tuple[int, int]] = []
    by_size: dict[int, list[int]] = {}

    for size in sorted(set(sizes)):
        by_size[size] = []
        for mask in combinations(n, size):
            by_size[size].append(len(candidates))
            candidates.append((size, mask))

    exact_cover: dict[tuple[int, int], list[int]] = {}
    near_cover: dict[tuple[int, int], list[int]] = {}
    for cand_index, (card_size, card_mask) in enumerate(candidates):
        for cluster_size, cluster_list in clusters.items():
            exact = 0
            near = 0
            for i, cluster in enumerate(cluster_list):
                hit_count = (card_mask & cluster).bit_count()
                if card_size <= cluster_size and hit_count == card_size:
                    exact |= 1 << i
                if hit_count == card_size - 1:
                    near |= 1 << i
            exact_cover[(cand_index, cluster_size)] = exact
            near_cover[(cand_index, cluster_size)] = near
    return candidates, by_size, clusters, exact_cover, near_cover


def position_counts(selection: list[int], candidates: list[tuple[int, int]], n: int) -> list[int]:
    counts = [0] * n
    for cand_index in selection:
        _, mask = candidates[cand_index]
        for i in range(n):
            if mask & (1 << i):
                counts[i] += 1
    return counts


def pair_counts(selection: list[int], candidates: list[tuple[int, int]], n: int) -> list[int]:
    counts = []
    pairs = list(itertools.combinations(range(n), 2))
    for a, b in pairs:
        count = 0
        pair_mask = (1 << a) | (1 << b)
        for cand_index in selection:
            _, mask = candidates[cand_index]
            if mask & pair_mask == pair_mask:
                count += 1
        counts.append(count)
    return counts


def wheel_score(
    selection: list[int],
    candidates: list[tuple[int, int]],
    clusters: dict[int, list[int]],
    exact_cover: dict[tuple[int, int], int],
    near_cover: dict[tuple[int, int], int],
    card_sizes: tuple[int, ...],
    n: int,
) -> float:
    score = 0.0
    min_size = min(card_sizes)
    max_size = max(card_sizes)
    selected = set(selection)

    for cluster_size, cluster_list in clusters.items():
        exact = 0
        near = 0
        for cand_index in selected:
            exact |= exact_cover[(cand_index, cluster_size)]
            near |= near_cover[(cand_index, cluster_size)]

        exact_hits = exact.bit_count()
        near_hits = near.bit_count()
        total = len(cluster_list)

        distance = cluster_size - min_size
        exact_weight = {
            0: 65_000,
            1: 1_000_000,
            2: 300_000,
            3: 90_000,
            4: 25_000,
        }.get(distance, 5_000)
        near_weight = {
            0: 35_000,
            1: 18_000,
            2: 7_000,
            3: 2_000,
        }.get(distance, 300)

        if cluster_size >= max_size:
            score += exact_hits * exact_weight
        score += near_hits * near_weight
        score += (exact_hits / total) * exact_weight * 2

    counts = position_counts(selection, candidates, n)
    target = sum(card_sizes) / n
    position_var = sum((count - target) ** 2 for count in counts)
    score -= position_var * 35_000
    score -= (max(counts) - min(counts)) * 50_000

    pairs = pair_counts(selection, candidates, n)
    if pairs:
        pair_target = sum(size * (size - 1) // 2 for size in card_sizes) / len(pairs)
        pair_var = sum((count - pair_target) ** 2 for count in pairs)
        score -= pair_var * 2_000

    return score


def initial_selection(card_sizes: tuple[int, ...], by_size: dict[int, list[int]], rng: random.Random) -> list[int]:
    selection = []
    used: set[int] = set()
    for size in card_sizes:
        pool = [idx for idx in by_size[size] if idx not in used]
        choice = rng.choice(pool)
        selection.append(choice)
        used.add(choice)
    return selection


def optimize(config: WheelConfig, seconds_hint: float = 2.0) -> Wheel:
    n = config.grid_side * config.grid_side
    candidates, by_size, clusters, exact_cover, near_cover = build_candidate_data(n, config.card_sizes)
    rng = random.Random(config.seed)

    best = initial_selection(config.card_sizes, by_size, rng)
    best_score = wheel_score(best, candidates, clusters, exact_cover, near_cover, config.card_sizes, n)
    current = best[:]
    current_score = best_score

    iterations = 14_000 if n <= 9 else 28_000
    temperature = 60_000.0

    for _ in range(iterations):
        slot = rng.randrange(len(current))
        size_needed = config.card_sizes[slot]
        used = set(current)
        used.remove(current[slot])
        replacement = rng.choice(by_size[size_needed])
        for _attempt in range(20):
            if replacement not in used:
                break
            replacement = rng.choice(by_size[size_needed])
        if replacement in used:
            continue

        trial = current[:]
        trial[slot] = replacement
        trial_score = wheel_score(trial, candidates, clusters, exact_cover, near_cover, config.card_sizes, n)
        delta = trial_score - current_score
        if delta > 0 or rng.random() < math.exp(delta / max(temperature, 1.0)):
            current = trial
            current_score = trial_score
            if trial_score > best_score:
                best = trial[:]
                best_score = trial_score
        temperature *= 0.99955

    cards = []
    for slot, cand_index in enumerate(best):
        size, mask = candidates[cand_index]
        cards.append((size, mask_to_positions(mask, n)))

    return Wheel(config=config, cards=cards, metrics=metric_lines(cards, config.grid_side))


def metric_lines(cards: list[tuple[int, tuple[int, ...]]], grid_side: int) -> list[str]:
    n = grid_side * grid_side
    lines = []
    min_size = min(size for size, _ in cards)
    max_size = max(size for size, _ in cards)
    card_sets = [(size, set(nums)) for size, nums in cards]

    counts = [0] * n
    for _size, nums in cards:
        for num in nums:
            counts[num - 1] += 1
    lines.append(f"Square stack range: {min(counts)} to {max(counts)} uses.")

    for cluster_size in range(min_size, min(n, max_size + 4) + 1):
        clusters = [set(combo) for combo in itertools.combinations(range(1, n + 1), cluster_size)]
        exact_counts = []
        near_counts = []
        for cluster in clusters:
            exact_counts.append(sum(1 for size, nums in card_sets if size <= cluster_size and nums <= cluster))
            near_counts.append(sum(1 for size, nums in card_sets if len(nums & cluster) == size - 1))

        covered = sum(1 for count in exact_counts if count > 0)
        total = len(clusters)
        if cluster_size >= max_size:
            lines.append(
                f"{cluster_size} in box: exact hits on {covered}/{total} cluster shapes; "
                f"range {min(exact_counts)}-{max(exact_counts)} exact cards."
            )
        else:
            lines.append(
                f"{cluster_size} in box: {covered}/{total} exact 4-spot shapes covered; "
                f"range {min(exact_counts)}-{max(exact_counts)} exact cards."
            )
        lines.append(
            f"{cluster_size} in box: near-miss backup range {min(near_counts)}-{max(near_counts)} cards."
        )
    return lines


def label_for(index: int) -> str:
    alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    if index < len(alphabet):
        return alphabet[index]
    return f"C{index + 1}"


def grid_text(nums: tuple[int, ...], side: int) -> list[str]:
    selected = set(nums)
    rows = []
    for row in range(side):
        values = []
        for col in range(side):
            pos = row * side + col + 1
            values.append("X" if pos in selected else ".")
        rows.append(" ".join(values))
    return rows


def render_txt(wheels: list[Wheel]) -> str:
    parts = ["KENO VARIABLE COVERAGE WHEELS", ""]
    parts.append("These layouts stack coverage inside a chosen box. They do not make the box itself more likely to hit.")
    parts.append("")

    for wheel in wheels:
        side = wheel.config.grid_side
        parts.append("=" * 72)
        parts.append(wheel.config.name.upper())
        parts.append("")
        parts.append("Position template:")
        pos = 1
        for _row in range(side):
            parts.append(" ".join(f"{pos + col:>2}" for col in range(side)))
            pos += side
        parts.append("")
        parts.append("Cards:")
        for i, (size, nums) in enumerate(wheel.cards):
            parts.append(f"{label_for(i)} ({size}-spot): " + ",".join(str(num) for num in nums))
        parts.append("")
        parts.append("Mini grids:")
        for i, (size, nums) in enumerate(wheel.cards):
            parts.append(f"{label_for(i)} ({size}-spot)")
            parts.extend(grid_text(nums, side))
            parts.append("")
        parts.append("Coverage notes:")
        parts.extend("- " + line for line in wheel.metrics)
        parts.append("")
    return "\n".join(parts)


def pdf_escape(value: str) -> str:
    return str(value).replace("\\", "\\\\").replace("(", "\\(").replace(")", "\\)")


class SimplePDF:
    def __init__(self):
        self.objects = [
            b"",
            b"",
            b"<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>",
            b"<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica-Bold >>",
        ]
        self.pages: list[int] = []

    def add_obj(self, data: bytes) -> int:
        self.objects.append(data)
        return len(self.objects)

    def stream_obj(self, content: str) -> int:
        encoded = content.encode("latin-1")
        return self.add_obj(b"<< /Length %d >>\nstream\n" % len(encoded) + encoded + b"\nendstream")

    def add_page(self, commands: list[str]) -> None:
        content_id = self.stream_obj("\n".join(commands))
        page = (
            f"<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] "
            f"/Resources << /Font << /F1 3 0 R /F2 4 0 R >> >> /Contents {content_id} 0 R >>"
        )
        self.pages.append(self.add_obj(page.encode("latin-1")))

    def save(self, path: Path) -> None:
        kids = " ".join(f"{page} 0 R" for page in self.pages)
        self.objects[1] = f"<< /Type /Pages /Kids [{kids}] /Count {len(self.pages)} >>".encode("latin-1")
        self.objects[0] = b"<< /Type /Catalog /Pages 2 0 R >>"

        data = bytearray(b"%PDF-1.4\n%\xe2\xe3\xcf\xd3\n")
        offsets = [0]
        for index, obj in enumerate(self.objects, 1):
            offsets.append(len(data))
            data += f"{index} 0 obj\n".encode("latin-1") + obj + b"\nendobj\n"

        xref = len(data)
        data += f"xref\n0 {len(self.objects) + 1}\n0000000000 65535 f \n".encode("latin-1")
        for offset in offsets[1:]:
            data += f"{offset:010d} 00000 n \n".encode("latin-1")
        data += f"trailer << /Size {len(self.objects) + 1} /Root 1 0 R >>\nstartxref\n{xref}\n%%EOF\n".encode("latin-1")
        path.write_bytes(data)


def pdf_text(commands: list[str], x: float, y: float, value: str, size: int = 9, bold: bool = False) -> None:
    font = "F2" if bold else "F1"
    commands.append(f"BT /{font} {size} Tf {x:.1f} {y:.1f} Td ({pdf_escape(value)}) Tj ET")


def pdf_rect(commands: list[str], x: float, y: float, w: float, h: float, fill: float | None = None) -> None:
    if fill is not None:
        commands.append(f"{fill:.2f} g {x:.1f} {y:.1f} {w:.1f} {h:.1f} re f 0 g")
    commands.append(f"{x:.1f} {y:.1f} {w:.1f} {h:.1f} re S")


def pdf_grid(commands: list[str], x: float, y: float, side: int, nums: tuple[int, ...], cell: float = 12.0) -> None:
    selected = set(nums)
    for pos in range(1, side * side + 1):
        row = (pos - 1) // side
        col = (pos - 1) % side
        xx = x + col * cell
        yy = y + (side - 1 - row) * cell
        pdf_rect(commands, xx, yy, cell, cell, 0.84 if pos in selected else None)
        pdf_text(commands, xx + 3, yy + 4, str(pos), 5, pos in selected)


def make_pdf(wheels: list[Wheel], path: Path) -> None:
    pdf = SimplePDF()

    for wheel in wheels:
        side = wheel.config.grid_side
        commands = ["0.7 w", "0 g"]
        pdf_text(commands, 36, 760, wheel.config.name, 16, True)
        pdf_text(commands, 36, 742, "Pick one box, map its positions left to right, then copy these cards.", 8)

        pdf_text(commands, 36, 718, "Position Template", 10, True)
        pdf_grid(commands, 38, 666, side, tuple(), 16 if side == 3 else 13)

        start_x = 36
        start_y = 590 if side == 3 else 600
        col_count = 4
        col_w = 142
        row_h = 74 if side == 3 else 80
        cell = 13 if side == 3 else 10
        for index, (size, nums) in enumerate(wheel.cards):
            col = index % col_count
            row = index // col_count
            x = start_x + col * col_w
            y = start_y - row * row_h
            pdf_text(commands, x, y + side * cell + 8, f"{label_for(index)} {size}-spot: " + ",".join(map(str, nums)), 7, True)
            pdf_grid(commands, x, y, side, nums, cell)

        metric_y = 128
        pdf_text(commands, 36, metric_y, "Coverage Notes", 10, True)
        metric_y -= 15
        for line in wheel.metrics[:8]:
            pdf_text(commands, 44, metric_y, "- " + line[:105], 7)
            metric_y -= 12
        pdf.add_page(commands)

    pdf.save(path)


def main() -> None:
    wheels = [optimize(config) for config in CONFIGS]
    Path("Keno_Variable_Coverage_Wheels.txt").write_text(render_txt(wheels), encoding="utf-8")
    make_pdf(wheels, Path("Keno_Variable_Coverage_Wheels.pdf"))
    print("Generated Keno_Variable_Coverage_Wheels.txt")
    print("Generated Keno_Variable_Coverage_Wheels.pdf")


if __name__ == "__main__":
    main()
