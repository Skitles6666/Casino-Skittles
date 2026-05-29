extends Control

@export_dir var symbols_dir := "res://assets/symbols"
@export var math_paytable_path := "res://assets/math/temple_of_ice_paytable.json"
@export var math_reels_path := "res://assets/math/temple_of_ice_reels.json"
@export var starting_credits := 1000
@export var bet_amount := 30 # total bet; fixed 30 lines => 1 coin/line by default
@export var min_bet := 30
@export var max_bet := 30000
@export var bet_step := 30
@export var spin_steps := .05
@export var base_step_time := 0.05
@export var rows := 4
@export var cols := 5
@export var active_lines := 30
@export var cell_size := Vector2(150, 150)
@export var auto_spin_delay := 0.05
@export var bonus_symbol := "B" # scatter that triggers free games on reels 1/3/5
@export var bonus_trigger_count := 3
@export var bonus_free_games := 12 # initial pick default; actual pick chosen at runtime
@export var feature_symbol := "FEATURE"
@export var feature_trigger_count := 4
@export var feature_lock_spins := 10
@export var feature_lock_delay := 2

# logging
@export var win_log_path := "user://win"

# visual spin feel
@export var scroll_steps := 9
@export var scroll_step_time := 0.01

@export var wild_symbol := "W"
@export var wild_multiplier := 1
@export var scatter_symbol := "NONE" # unused; scatter win disabled
@export var scatter_payouts := {} # no scatter pays for Temple of Ice
@export var free_spin_pick_weights := Vector3(0.6, 0.3, 0.1) # 12@1x, 8@2x, 5@3x
@export var paytable := {} # loaded from math json
@export var default_paytable := {} # unused

@export var paylines := [
	[0, 0, 0, 0, 0],
	[1, 1, 1, 1, 1],
	[2, 2, 2, 2, 2],
	[0, 1, 2, 1, 0],
	[2, 1, 0, 1, 2],
	[0, 0, 1, 2, 2],
	[2, 2, 1, 0, 0],
	[0, 1, 1, 1, 0],
	[2, 1, 1, 1, 2],
	[1, 0, 1, 2, 1],
	[1, 2, 1, 0, 1],
	[0, 1, 0, 1, 0],
	[2, 1, 2, 1, 2],
	[0, 0, 0, 1, 2],
	[2, 2, 2, 1, 0],
	[1, 1, 0, 1, 2],
	[1, 1, 2, 1, 0],
	[0, 1, 2, 2, 1],
	[2, 1, 0, 0, 1],
	[0, 2, 1, 0, 2],
	[2, 0, 1, 2, 0],
	[0, 2, 2, 2, 0],
	[2, 0, 0, 0, 2],
	[1, 0, 2, 0, 1],
	[1, 2, 0, 2, 1],
	[1, 1, 1, 0, 0],
	[1, 1, 1, 2, 2],
	[0, 0, 1, 1, 2],
	[2, 2, 1, 1, 0],
	[0, 2, 0, 2, 0],
]

var credits: int
var spinning := false
var spin_count: int = 0
var symbol_defs: Array = [] # [{texture: Texture2D, name: String}]
var symbol_textures: Dictionary = {} # name -> Texture2D
var auto_spin := false
var auto_spin_task_running := false
var free_games := 0 # remaining free spins
var free_spin_multiplier := 1.0
var free_spin_package := 12
var free_spins_awarded_total := 0
var current_result: Array = [] # [col][row] of symbol names currently displayed
var base_reels: Array = [] # [col][stop]
var free_reels: Array = [] # [col][stop]
var feature_active := false
var feature_locked: Array = [] # [col][row] bools
var feature_spins_done := 0
var feature_prev_auto := false
var feature_running_total := 0

const FREE_SPIN_OPTIONS := [
	{"spins": 12, "mult": 1.0},
	{"spins": 8, "mult": 2.0},
	{"spins": 5, "mult": 3.0},
]
const REEL_BONUS_COLUMNS := [0, 2, 4] # reels 1,3,5 zero-indexed
const REEL_SYMBOL_TO_PAYTABLE := {
	"W": "ICE_GODDESS",
	"L": "FROZEN_CREST",
	"H1": "DAGGER",
	"H2": "MASK",
	"H3": "CHALICE",
	"H4": "AMULET",
	"A": "A",
	"K": "K",
	"Q": "Q",
	"J": "J",
	"T": "T",
	"B": "BONUS",
}

# reel_rects is shaped as [col][row]
@onready var reel_rects: Array = _collect_reel_rects()
@onready var spin_button := $MarginContainer/VBox/Controls/SpinButton
@onready var auto_spin_button := $MarginContainer/VBox/Controls/AutoSpin
@onready var bet_minus_button := $MarginContainer/VBox/Controls/BetMinus
@onready var bet_plus_button := $MarginContainer/VBox/Controls/BetPlus
@onready var credits_label := $MarginContainer/VBox/Controls/Credits
@onready var bet_label := $MarginContainer/VBox/Controls/Bet
@onready var free_games_label := $MarginContainer/VBox/Controls/FreeGames
@onready var spins_label := $MarginContainer/VBox/Controls/Spins
@onready var message_label := $MarginContainer/VBox/Message
@onready var feature_overlay := $FeatureResultOverlay
@onready var feature_win_label := $FeatureResultOverlay/Center/VBox/FeatureWinLabel
@onready var feature_continue_button := $FeatureResultOverlay/Center/VBox/FeatureContinueButton

func _ready():
	credits = starting_credits
	bet_amount = clampi(bet_amount, min_bet, max_bet)
	_load_math()
	_setup_reel_cells()
	_load_symbols()
	_update_ui()
	_ensure_controls_visible()
	_connect_controls()
	if auto_spin_button:
		auto_spin_button.toggle_mode = true
	_randomize_reels()
	if feature_overlay:
		feature_overlay.visible = false

func _ensure_controls_visible():
	var need_overlay := (spin_button == null or bet_minus_button == null or bet_plus_button == null or credits_label == null or bet_label == null)
	if not need_overlay and spin_button:
		var sz: Vector2 = spin_button.get_combined_minimum_size()
		need_overlay = (sz.x < 4 or sz.y < 4 or not spin_button.visible)
	if need_overlay:
		_create_overlay_controls()

func _create_overlay_controls():
	var overlay := HBoxContainer.new()
	overlay.name = "ControlsFallback"
	overlay.z_index = 50
	overlay.anchor_left = 0.5
	overlay.anchor_right = 0.5
	overlay.anchor_top = 0.0
	overlay.anchor_bottom = 0.0
	overlay.offset_left = -340
	overlay.offset_right = 340
	overlay.offset_top = 0
	overlay.offset_bottom = 60
	overlay.add_theme_constant_override("separation", 12)
	overlay.mouse_filter = Control.MOUSE_FILTER_PASS

	var spin := Button.new()
	spin.text = "Spin"
	spin.custom_minimum_size = Vector2(180, 60)
	overlay.add_child(spin)

	var auto_spin_btn := Button.new()
	auto_spin_btn.text = "Auto Spin"
	auto_spin_btn.custom_minimum_size = Vector2(150, 60)
	auto_spin_btn.toggle_mode = true
	overlay.add_child(auto_spin_btn)

	var minus := Button.new()
	minus.text = "- Bet"
	minus.custom_minimum_size = Vector2(90, 60)
	overlay.add_child(minus)

	var plus := Button.new()
	plus.text = "+ Bet"
	plus.custom_minimum_size = Vector2(90, 60)
	overlay.add_child(plus)

	var credits_lbl := Label.new()
	credits_lbl.text = "Credits: " + str(credits)
	overlay.add_child(credits_lbl)

	var bet_lbl := Label.new()
	bet_lbl.text = "Bet: " + str(bet_amount)
	overlay.add_child(bet_lbl)

	var fg_lbl := Label.new()
	fg_lbl.text = "Free Games: " + str(free_games)
	overlay.add_child(fg_lbl)

	var spins_lbl := Label.new()
	spins_lbl.text = "Spins: " + str(spin_count)
	overlay.add_child(spins_lbl)

	add_child(overlay)
	overlay.move_to_front()
	spin_button = spin
	auto_spin_button = auto_spin_btn
	bet_minus_button = minus
	bet_plus_button = plus
	credits_label = credits_lbl
	bet_label = bet_lbl
	free_games_label = fg_lbl
	spins_label = spins_lbl

func _connect_controls():
	if spin_button and not spin_button.pressed.is_connected(_on_spin_pressed):
		spin_button.pressed.connect(_on_spin_pressed)
	if auto_spin_button and not auto_spin_button.toggled.is_connected(_on_auto_spin_toggled):
		auto_spin_button.toggled.connect(_on_auto_spin_toggled)
	if bet_minus_button and not bet_minus_button.pressed.is_connected(_on_bet_minus):
		bet_minus_button.pressed.connect(_on_bet_minus)
	if bet_plus_button and not bet_plus_button.pressed.is_connected(_on_bet_plus):
		bet_plus_button.pressed.connect(_on_bet_plus)

func _on_bet_minus():
	_change_bet(-bet_step)

func _on_bet_plus():
	_change_bet(bet_step)

func _on_auto_spin_toggled(pressed: bool):
	auto_spin = pressed
	_update_auto_spin_button()
	if auto_spin and not auto_spin_task_running:
		_auto_spin_loop()

func _setup_reel_cells():
	var reels_container = $MarginContainer/VBox/Reels
	if reels_container is GridContainer:
		reels_container.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		reels_container.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		reels_container.custom_minimum_size = Vector2(
			cell_size.x * float(cols) + 12.0 * float(max(0, cols - 1)),
			cell_size.y * float(rows) + 12.0 * float(max(0, rows - 1))
		)

	for col in reel_rects:
		for rect in col:
			rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			rect.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
			rect.size_flags_vertical = Control.SIZE_SHRINK_CENTER
			rect.custom_minimum_size = cell_size
			rect.size = cell_size

func _collect_reel_rects() -> Array:
	var reels: Array = []
	var reels_container = $MarginContainer/VBox/Reels
	if not reels_container:
		push_warning("Reels container missing")
		return reels
	for col in range(cols):
		var column_rects: Array = []
		for row in range(rows):
			var idx := row * cols + col
			if idx < reels_container.get_child_count():
				var tex_rect = reels_container.get_child(idx)
				if tex_rect is TextureRect:
					column_rects.append(tex_rect)
				else:
					push_warning("Child at index %d is not a TextureRect" % idx)
			else:
				var missing := TextureRect.new()
				reels_container.add_child(missing)
				column_rects.append(missing)
				push_warning("Auto-added TextureRect for col %d row %d" % [col, row])
		reels.append(column_rects)
	return reels

func _load_math():
	# load paytable JSON
	var pf = FileAccess.open(math_paytable_path, FileAccess.READ)
	if pf:
		var parsed = JSON.parse_string(pf.get_as_text())
		if parsed is Dictionary and parsed.has("symbols"):
			_build_paytable_from_json(parsed["symbols"])
		else:
			push_warning("Paytable JSON missing symbols key")
	else:
		push_warning("Unable to open paytable file: %s" % math_paytable_path)

	# load reel strips
	var rf = FileAccess.open(math_reels_path, FileAccess.READ)
	if rf:
		var parsed_reels = JSON.parse_string(rf.get_as_text())
		if parsed_reels is Dictionary:
			base_reels = parsed_reels.get("base_game", [])
			free_reels = parsed_reels.get("free_spins", [])
			cols = base_reels.size()
		else:
			push_warning("Reels JSON invalid format")
	else:
		push_warning("Unable to open reels file: %s" % math_reels_path)

func _build_paytable_from_json(symbols_dict: Dictionary):
	paytable.clear()
	for reel_sym in REEL_SYMBOL_TO_PAYTABLE.keys():
		var pay_key = REEL_SYMBOL_TO_PAYTABLE[reel_sym]
		if not symbols_dict.has(pay_key):
			continue
		var sym_info: Dictionary = symbols_dict[pay_key]
		var pays = sym_info.get("pays", {})
		var converted := {}
		for k in pays.keys():
			var key_int := int(str(k))
			converted[key_int] = float(pays[k])
		paytable[reel_sym] = converted

func _load_symbols():
	symbol_defs.clear()
	symbol_textures.clear()
	var texture_lookup: Dictionary = {}
	var texture_sources: Dictionary = {}
	var all_loaded: Array = []
	var files = DirAccess.get_files_at(symbols_dir)
	for file in files:
		if not file.to_lower().ends_with(".png") and not file.to_lower().ends_with(".webp"):
			continue
		var path = symbols_dir.path_join(file)
		var tex := _load_symbol_texture(path)
		if tex and tex is Texture2D:
			var name = file.get_basename()
			texture_lookup[name.to_upper()] = tex
			texture_lookup[name] = tex
			texture_sources[tex] = name
			all_loaded.append(tex)

	var texture_alias := {
		"H3": "52",
		"T": "53",
		"L": "58",
		"W": "59",
		"H2": "61",
		"K": "62",
		"Q": "63",
		"H4": "64",
		"A": "66",
		"H1": "69",
		"J": "70",
		"B": "BONUS",
	}

	var needed_syms := _collect_needed_symbols()
	var unresolved: Array = []
	var used_textures: Array = []

	for sym in needed_syms:
		var key := str(sym)
		var tex: Texture2D = null
		if texture_lookup.has(key):
			tex = texture_lookup[key]
		elif texture_lookup.has(key.to_upper()):
			tex = texture_lookup[key.to_upper()]
		elif texture_alias.has(key) and texture_lookup.has(texture_alias[key]):
			tex = texture_lookup[texture_alias[key]]
		symbol_textures[key] = tex
		if tex:
			used_textures.append(tex)
		else:
			unresolved.append(key)

	# Build a fallback pool from any textures we loaded but did not match by name.
	var fallback_pool: Array = []
	for tex in all_loaded:
		if not used_textures.has(tex):
			fallback_pool.append(tex)

	var color_idx := 0
	var pool_idx := 0
	for key in unresolved:
		var tex: Texture2D = null
		if fallback_pool.size() > 0:
			tex = fallback_pool[pool_idx % fallback_pool.size()]
			pool_idx += 1
			var src: String = texture_sources.get(tex, "unknown")
			push_warning("Mapped symbol %s to texture %s (name mismatch)." % [key, src])
		else:
			tex = _make_placeholder_texture(color_idx, key)
			color_idx += 1
		symbol_textures[key] = tex

	for sym in needed_syms:
		var key := str(sym)
		symbol_defs.append({"texture": symbol_textures[key], "name": key})

	if symbol_defs.is_empty():
		# absolute fallback
		for i in range(5):
			var name := "SYM" + str(i)
			var tex := _make_placeholder_texture(i, name)
			symbol_textures[name] = tex
			symbol_defs.append({"texture": tex, "name": name})

func _load_symbol_texture(path: String) -> Texture2D:
	var resource = load(path)
	if resource is Texture2D:
		return resource

	var image := Image.new()
	var err := image.load(path)
	if err == OK:
		return ImageTexture.create_from_image(image)
	return null

func _collect_needed_symbols() -> Array:
	var set_syms: Array = []
	var seen := {}
	for col in base_reels:
		for sym in col:
			if not seen.has(sym):
				seen[sym] = true
				set_syms.append(sym)
	for col in free_reels:
		for sym in col:
			if not seen.has(sym):
				seen[sym] = true
				set_syms.append(sym)
	return set_syms

func _make_placeholder_texture(idx: int, label: String) -> Texture2D:
	var tex := GradientTexture1D.new()
	var grad := Gradient.new()
	var base := float(idx % 6) / 6.0
	grad.colors = [Color(base, 0.6, 0.9), Color(base + 0.2, 0.3, 1.0)]
	tex.gradient = grad
	tex.width = 256
	return tex

func _on_spin_pressed():
	await _do_spin()

func _do_spin():
	if spinning or feature_active:
		return
	if credits < bet_amount and free_games <= 0:
		message_label.text = "Not enough credits."
		auto_spin = false
		_update_auto_spin_button()
		return

	spin_count += 1
	var using_free_game := free_games > 0
	if using_free_game:
		free_games -= 1
	else:
		credits -= bet_amount

	spinning = true
	spin_button.disabled = true
	message_label.text = "Free game!" if using_free_game else "Spinning..."
	_update_ui()

	var raw_result = await _spin_reels(using_free_game)
	var bonus_awarded := _check_bonus_scatter(raw_result)
	var transformed = _apply_wild_behaviour(raw_result, using_free_game)
	current_result = _clone_result(transformed)
	_apply_result_textures(transformed)

	var applied_multiplier := free_spin_multiplier if using_free_game else 1.0
	var payout = _payout(transformed, applied_multiplier)
	credits += payout.total_win

	if bonus_awarded:
		_on_bonus_trigger(using_free_game)

	var feature_triggered := false # feature unused in this math

	if payout.total_win > 0:
		message_label.text = "Win: " + str(payout.total_win) + " (lines " + str(payout.line_win) + ", scatter " + str(payout.scatter_win) + ")"
		_log_win(spin_count, payout, transformed, using_free_game)
	else:
		message_label.text = "No win. Try again."

	_update_ui()
	if feature_triggered:
		await _start_feature()
	else:
		spinning = false
		spin_button.disabled = false
		if free_games <= 0:
			free_spin_multiplier = 1.0
			free_spins_awarded_total = 0

func _check_feature(result: Array) -> bool:
	return _count_symbol(result, feature_symbol) >= feature_trigger_count

func _clone_result(arr: Array) -> Array:
	var out: Array = []
	for col in arr:
		var col_copy: Array = []
		for v in col:
			col_copy.append(v)
		out.append(col_copy)
	return out

func _start_feature():
	feature_active = true
	feature_prev_auto = auto_spin
	auto_spin = false
	_update_auto_spin_button()
	feature_locked.clear()
	feature_running_total = 0
	for col in range(cols):
		var col_lock: Array = []
		for row in range(rows):
			var locked := false
			if col < current_result.size() and row < current_result[col].size():
				locked = current_result[col][row].to_lower() == feature_symbol.to_lower()
			col_lock.append(locked)
		feature_locked.append(col_lock)
	feature_spins_done = 0
	message_label.text = "Feature! Collect feature symbols."
	_update_ui()
	await _feature_spin_loop()

func _spin_reels(is_free_game: bool) -> Array:
	var use_free := is_free_game and free_reels.size() == cols and free_reels.size() > 0
	var strips: Array = free_reels if use_free else base_reels
	if strips.is_empty():
		# fallback to random symbols if strips missing
		var fallback: Array = []
		for col in range(cols):
			var column: Array = []
			for row in range(rows):
				column.append(symbol_defs[randi() % symbol_defs.size()].name)
			fallback.append(column)
		return fallback

	# spin feel
	for col in range(reel_rects.size()):
		var column_rects: Array = reel_rects[col]
		for step in range(scroll_steps):
			_scroll_column(column_rects)
			await get_tree().create_timer(base_step_time + scroll_step_time + col * 0.02).timeout

	var result: Array = []
	for col in range(cols):
		var strip: Array = strips[col]
		var start := randi() % strip.size()
		var column_result: Array = []
		for row in range(rows):
			column_result.append(strip[(start + row) % strip.size()])
		result.append(column_result)
	return result

func _apply_result_textures(result: Array):
	for col in range(min(cols, reel_rects.size())):
		var column_rects: Array = reel_rects[col]
		if col >= result.size():
			continue
		for row in range(min(rows, column_rects.size())):
			if row >= result[col].size():
				continue
			var sym_name: String = str(result[col][row])
			var tex: Texture2D = symbol_textures.get(sym_name, null)
			if tex == null and symbol_defs.size() > 0:
				tex = symbol_defs[0].texture
			column_rects[row].texture = tex

func _feature_spin_loop():
	while feature_spins_done < feature_lock_spins:
		feature_spins_done += 1
		await _spin_feature_once()
		var current_with_wilds := _apply_feature_wilds(current_result)
		var spin_payout := _payout(current_with_wilds)
		feature_running_total += spin_payout.total_win
		message_label.text = "Feature spin %d/%d win: %d  Total: %d" % [feature_spins_done, feature_lock_spins, spin_payout.total_win, feature_running_total]
		if spin_payout.total_win > 0:
			_log_win(spin_count, spin_payout, current_with_wilds, false, true)
		_update_ui()
		if feature_spins_done < feature_lock_spins:
			await get_tree().create_timer(feature_lock_delay).timeout

	# feature ends, award total
	credits += feature_running_total
	message_label.text = "Feature total: %d" % feature_running_total
	_update_ui()
	await _show_feature_result_overlay(feature_running_total)
	await _end_feature_and_resume()

func _payout(result: Array, multiplier: float = 1.0) -> Dictionary:
	var line_win := 0.0
	var scatter_win := 0.0
	var total_bet := float(bet_amount)
	var line_bet := total_bet / float(active_lines)

	# Line wins
	for i in range(min(active_lines, paylines.size())):
		var line = paylines[i]
		if line.size() != cols:
			continue
		var lw = _line_win(result, line, line_bet)
		line_win += lw

	# Scatter wins (disabled for Temple of Ice but kept for future use)
	var scatter_count := _count_symbol(result, scatter_symbol)
	if scatter_count >= 3:
		var scatter_mult = scatter_payouts.get(scatter_count, 0.0)
		if scatter_mult == 0.0:
			for k in scatter_payouts.keys():
				if scatter_count >= k:
					scatter_mult = max(scatter_mult, scatter_payouts[k])
		scatter_win = scatter_mult * total_bet

	line_win *= multiplier
	scatter_win *= multiplier
	var total_win := line_win + scatter_win
	return {
		"line_win": int(round(line_win)),
		"scatter_win": int(round(scatter_win)),
		"total_win": int(round(total_win)),
	}

func _line_win(result: Array, line: Array, line_bet: float) -> float:
	# determine base symbol (skip scatters, allow wilds to stand in)
	var first_symbol = result[0][line[0]]
	if _is_scatter(first_symbol):
		return 0.0
	var base_symbol = first_symbol
	if _is_wild(base_symbol):
		for col in range(1, cols):
			var probe = result[col][line[col]]
			if not _is_wild(probe) and not _is_scatter(probe):
				base_symbol = probe
				break
	# count consecutive matches from reel 1
	var match_count := 0
	var wild_used := false
	for col in range(cols):
		var sym = result[col][line[col]]
		if _is_scatter(sym):
			break
		if sym == base_symbol or _is_wild(sym):
			match_count += 1
			if _is_wild(sym):
				wild_used = true
		else:
			break
	if match_count < 3:
		return 0.0
	var multiplier := _get_symbol_multiplier(base_symbol, match_count)
	if multiplier == 0.0:
		return 0.0
	if wild_used:
		multiplier *= wild_multiplier
	return multiplier * line_bet

func _apply_wild_behaviour(result: Array, is_free_game: bool) -> Array:
	var grid := _clone_result(result)
	# expand Ice Goddess upward
	for col in range(grid.size()):
		for row in range(grid[col].size()):
			if grid[col][row] == wild_symbol or _is_wild(grid[col][row]):
				for r in range(row, -1, -1):
					grid[col][r] = wild_symbol

	# free-spin guaranteed full-reel wild
	if is_free_game:
		var reel_choice := randi() % cols
		for row in range(rows):
			grid[reel_choice][row] = wild_symbol

	# ignite adjacent Logos repeatedly (orthogonal)
	var changed := true
	while changed:
		changed = false
		for col in range(cols):
			for row in range(rows):
				if grid[col][row] == wild_symbol or _is_wild(grid[col][row]):
					for dir in [[1, 0], [-1, 0], [0, 1], [0, -1]]:
						var cc: int = col + dir[0]
						var rr: int = row + dir[1]
						if cc < 0 or cc >= cols or rr < 0 or rr >= rows:
							continue
						if grid[cc][rr] == "L":
							grid[cc][rr] = wild_symbol
							changed = true
	return grid

func _check_bonus_scatter(result: Array) -> bool:
	for c in REEL_BONUS_COLUMNS:
		var found := false
		for row in range(rows):
			if result[c][row] == bonus_symbol:
				found = true
				break
		if not found:
			return false
	return true

func _on_bonus_trigger(already_in_free_game: bool):
	if already_in_free_game and free_spin_package <= 0:
		return
	if free_spins_awarded_total >= 600:
		return
	if not already_in_free_game:
		var pick = _pick_free_spin_package()
		free_spin_package = pick.spins
		free_spin_multiplier = pick.mult
		free_spins_awarded_total = 0
	free_spins_awarded_total = min(600, free_spins_awarded_total + free_spin_package)
	free_games = min(600, free_games + free_spin_package)
	message_label.text += " +" + str(free_spin_package) + " free spins x" + str(free_spin_multiplier)

func _pick_free_spin_package() -> Dictionary:
	var total_weight := free_spin_pick_weights.x + free_spin_pick_weights.y + free_spin_pick_weights.z
	var roll := randf() * total_weight
	if roll < free_spin_pick_weights.x:
		return FREE_SPIN_OPTIONS[0]
	elif roll < free_spin_pick_weights.x + free_spin_pick_weights.y:
		return FREE_SPIN_OPTIONS[1]
	return FREE_SPIN_OPTIONS[2]

func _get_symbol_multiplier(symbol: String, count: int) -> float:
	var table = paytable.get(symbol, default_paytable)
	var best_key := 0
	for k in table.keys():
		if count >= k and k > best_key:
			best_key = k
	return table.get(best_key, 0.0)

func _is_wild(sym: String) -> bool:
	return sym == wild_symbol or sym.to_lower().find("wild") != -1

func _is_scatter(sym: String) -> bool:
	return sym == scatter_symbol or sym.to_lower().find("scatter") != -1

func _count_symbol(result: Array, sym_name: String) -> int:
	var count := 0
	for col in result:
		for row_val in col:
			if row_val.to_lower() == sym_name.to_lower():
				count += 1
	return count

func _spin_feature_once():
	for col in range(cols):
		if col >= reel_rects.size():
			continue
		var column_rects: Array = reel_rects[col]
		for row in range(rows):
			if row >= column_rects.size():
				continue
			if feature_locked[col][row]:
				continue
			var sym = _random_symbol()
			column_rects[row].texture = sym.texture
			if col >= current_result.size():
				current_result.append([])
			while current_result[col].size() <= row:
				current_result[col].append(sym.name)
			current_result[col][row] = sym.name

	# lock any new feature symbols
	for col in range(cols):
		for row in range(rows):
			if feature_locked[col][row]:
				continue
			if current_result[col][row].to_lower() == feature_symbol.to_lower():
				feature_locked[col][row] = true

func _count_feature_locked() -> int:
	var count := 0
	for col in feature_locked:
		for locked in col:
			if locked:
				count += 1
	return count

func _apply_feature_wilds(result: Array) -> Array:
	var out: Array = []
	for col in range(result.size()):
		var col_copy: Array = []
		for row in range(result[col].size()):
			if feature_locked.size() > col and feature_locked[col].size() > row and feature_locked[col][row]:
				col_copy.append(wild_symbol)
			else:
				col_copy.append(result[col][row])
		out.append(col_copy)
	return out

func _show_feature_result_overlay(win_amount: int):
	if not feature_overlay or not feature_win_label or not feature_continue_button:
		return
	feature_win_label.text = "Feature Win: %d" % win_amount
	feature_overlay.visible = true
	feature_overlay.move_to_front()
	feature_continue_button.disabled = false
	feature_continue_button.grab_focus()
	await feature_continue_button.pressed
	feature_overlay.visible = false

func _end_feature_and_resume():
	feature_active = false
	feature_locked.clear()
	feature_spins_done = 0
	spinning = false
	spin_button.disabled = false

	auto_spin = feature_prev_auto
	feature_prev_auto = false
	_update_auto_spin_button()
	_update_ui()

	# start a fresh regular spin automatically; resume auto-spin if it was on
	if auto_spin:
		if not auto_spin_task_running:
			_auto_spin_loop()
	else:
		await get_tree().create_timer(0.2).timeout
		await _do_spin()

func _update_ui():
	if credits_label:
		credits_label.text = "Credits: " + str(credits)
	if bet_label:
		bet_label.text = "Bet: " + str(bet_amount)
	if free_games_label:
		var fg_text := "Free Games: " + str(free_games)
		if free_games > 0:
			fg_text += " x" + str(free_spin_multiplier)
		free_games_label.text = fg_text
	if spins_label:
		spins_label.text = "Spins: " + str(spin_count)
	var bet_locked := feature_active or free_games > 0
	if bet_minus_button:
		bet_minus_button.disabled = bet_locked
	if bet_plus_button:
		bet_plus_button.disabled = bet_locked
	_update_auto_spin_button()

func _update_auto_spin_button():
	if not auto_spin_button:
		return
	auto_spin_button.text = "Stop Auto" if auto_spin else "Auto Spin"
	auto_spin_button.button_pressed = auto_spin
	auto_spin_button.disabled = feature_active

func _change_bet(delta: int):
	if feature_active:
		message_label.text = "Bet locked during feature."
		return
	bet_amount = clampi(bet_amount + delta, min_bet, max_bet)
	_update_ui()

func _random_symbol() -> Dictionary:
	return symbol_defs[randi() % symbol_defs.size()]

func _scroll_column(column_rects: Array) -> void:
	if column_rects.is_empty():
		return
	# shift textures downward to imitate reel movement, top fills with new symbol
	for i in range(column_rects.size() - 1, 0, -1):
		column_rects[i].texture = column_rects[i - 1].texture
	var new_sym := _random_symbol()
	column_rects[0].texture = new_sym.texture

func _randomize_reels():
	for col in reel_rects:
		for rect in col:
			rect.texture = _random_symbol().texture

func _auto_spin_loop():
	if auto_spin_task_running:
		return
	auto_spin_task_running = true
	while auto_spin:
		await _do_spin()
		if not auto_spin:
			break
		await get_tree().create_timer(auto_spin_delay).timeout
	auto_spin_task_running = false

func _log_win(spin_no: int, payout: Dictionary, result: Array, used_free_game: bool, is_feature_spin := false):
	var f = FileAccess.open(win_log_path, FileAccess.READ_WRITE)
	if f == null:
		push_warning("Cannot open win log: " + str(FileAccess.get_open_error()))
		return
	f.seek(f.get_length())
	var header := "Spin %d | win %d (line %d, scatter %d) | bet %d | credits %d | free_game %s | feature_spin %s" % [
		spin_no,
		payout.get("total_win", 0),
		payout.get("line_win", 0),
		payout.get("scatter_win", 0),
		bet_amount,
		credits,
		str(used_free_game),
		str(is_feature_spin)
	]
	f.store_string(header + "\n")
	f.store_string(_format_grid(result) + "\n---\n")

func _format_grid(result: Array) -> String:
	var lines: Array = []
	for row in range(rows):
		var row_syms: Array = []
		for col in range(cols):
			if col < result.size() and row < result[col].size():
				row_syms.append(str(result[col][row]))
			else:
				row_syms.append("")
		lines.append(" | ".join(row_syms))
	return "\n".join(lines)
