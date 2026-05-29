extends Control

const GAME_KENO := "keno"
const GAME_POKER := "poker"
const GAME_BLACKJACK := "blackjack"
const GAME_THREE_CARD := "three_card"
const GAME_CRISS_CROSS := "criss_cross"
const GAME_PAI_GOW := "pai_gow"
const GAME_BACCARAT := "baccarat"
const GAME_CRAPS := "craps"
const GAME_ROULETTE := "roulette"
const GAME_SLOTS := "slots"
const SHOW_CASINO_GAME_TABS := true
const CARD_COUNT := 20
const NUMBER_MAX := 80
const DRAW_COUNT := 20
const MAX_PICKS_PER_CARD := 10
const KENO_STARTING_CREDITS := 1000.0
const SAVED_KENO_PATTERN_COUNT := 12
const SAVED_KENO_PATTERNS_PATH := "user://keno_pick_patterns.cfg"
const SAVED_KENO_GROUP_COUNT := 50
const SAVED_KENO_GROUPS_PATH := "user://keno_card_groups.cfg"
const KENO_RUN_LOG_PATH := "user://keno_run_log.csv"
const KENO_CHEAT_SHEET_PATH := "user://keno_best_group_cheat_sheet.txt"
const KENO_DEFAULT_BATCH_RUN_COUNT := 1000
const KENO_MAX_BATCH_RUN_COUNT := 100000
const KENO_DEFAULT_OPTIMIZER_PICK_COUNT := 5
const RECENT_RUN_LIMIT := 500
const CARD_PANEL_WIDTH := 460
const STATS_PANEL_WIDTH := 560
const NUMBER_PANEL_WIDTH := 960
const CARD_BUTTON_SIZE := Vector2(205, 108)
const NUMBER_BUTTON_SIZE := Vector2(74, 56)
const NUMBER_BUTTON_FONT_SIZE := 16
const CARD_BUTTON_FONT_SIZE := 13
const KENO_BALL_STAGE_HEIGHT := 172
const KENO_BALL_SIZE := 42
const KENO_BALL_SPACING := 8
const KENO_BALL_DIR := "res://assets/keno_balls"
const KENO_BOARD_IMAGE := "res://assets/keno_card.png"
const KENO_BOARD_REFERENCE_SIZE := Vector2(4401.0, 2741.0)
const KENO_BOARD_DISPLAY_SIZE := Vector2(1600.0, 996.0)
const KENO_BOARD_COL_EDGES := [
	1340.0, 1640.0, 1940.0, 2240.0, 2540.0,
	2840.0, 3140.0, 3440.0, 3740.0, 4040.0, 4340.0,
]
const KENO_BOARD_ROW_TOPS := [
	480.0, 697.0, 898.0, 1100.0,
	1440.0, 1641.0, 1842.0, 2043.0,
]
const KENO_BOARD_ROW_BOTTOMS := [
	688.0, 889.0, 1091.0, 1292.0,
	1632.0, 1832.0, 2033.0, 2234.0,
]
const KENO_CURRENT_VALUE_RECT := Rect2(760.0, 80.0, 280.0, 110.0)
const KENO_PATTERN_VALUE_RECT := Rect2(2120.0, 1315.0, 1600.0, 90.0)
const KENO_BOTTOM_WIN_RECT := Rect2(1275.0, 2392.0, 600.0, 135.0)
const KENO_BOTTOM_CARDS_PLAYED_RECT := Rect2(1910.0, 2392.0, 600.0, 135.0)
const KENO_BOTTOM_BET_RECT := Rect2(2575.0, 2392.0, 500.0, 135.0)
const KENO_BOTTOM_CREDIT_RECT := Rect2(3440.0, 2392.0, 790.0, 135.0)
const KENO_SUMMARY_ROW_START_Y := 342.0
const KENO_SUMMARY_ROW_STEP_Y := 86.5
const KENO_SUMMARY_BET_X := 325.0
const KENO_SUMMARY_MARKED_X := 594.0
const KENO_SUMMARY_HIT_X := 858.0
const KENO_SUMMARY_PAY_X := 1152.0
const CARD_LABELS := [
	"A", "B", "C", "D", "E",
	"F", "G", "H", "I", "J",
	"K", "L", "M", "N", "O",
	"P", "Q", "R", "S", "T",
]

const CARD_COLORS := [
	Color("#ff0000"), Color("#800000"), Color("#ffb700"), Color("#7d5e00"), Color("#99ff00"),
	Color("#298100"), Color("#00ffb3"), Color("#00627d"), Color("#0048ff"), Color("#190072"),
	Color("#fb00ff"), Color("#cb20ff"), Color("#ff7878"), Color("#863c3c"), Color("#78ff81"),
	Color("#457990"), Color("#964385"), Color("#86ffb0"), Color("#5d3e82"), Color("#49488d"),
]

const KENO_WHEEL_AUTO := 0
const KENO_WHEEL_3X3_5 := 1
const KENO_WHEEL_3X3_4 := 2
const KENO_WHEEL_4X4_4 := 3
const KENO_WHEEL_4X4_5 := 4
const KENO_WHEEL_4X4_MIXED := 5

const KENO_3X3_5_SPOT_COVERAGE_PATTERNS := [
	[0, 1, 2, 3, 7],
	[0, 1, 2, 4, 5],
	[0, 1, 2, 5, 8],
	[0, 1, 3, 6, 8],
	[0, 1, 4, 6, 7],
	[0, 1, 4, 7, 8],
	[0, 2, 3, 4, 6],
	[0, 2, 3, 4, 8],
	[0, 2, 6, 7, 8],
	[0, 3, 4, 5, 7],
	[0, 3, 5, 6, 7],
	[0, 4, 5, 6, 8],
	[1, 2, 3, 4, 7],
	[1, 2, 3, 5, 6],
	[1, 2, 4, 6, 8],
	[1, 3, 4, 5, 8],
	[1, 5, 6, 7, 8],
	[2, 3, 5, 7, 8],
	[2, 4, 5, 6, 7],
	[3, 4, 6, 7, 8],
]

const KENO_3X3_4_SPOT_COVERAGE_PATTERNS := [
	[0, 3, 4, 8],
	[1, 4, 7, 8],
	[3, 4, 5, 7],
	[0, 2, 3, 6],
	[0, 2, 4, 7],
	[0, 5, 7, 8],
	[2, 3, 5, 6],
	[1, 2, 3, 4],
	[0, 1, 2, 5],
	[1, 3, 5, 8],
	[0, 1, 3, 7],
	[0, 1, 6, 8],
	[0, 1, 4, 6],
	[2, 3, 7, 8],
	[1, 2, 6, 7],
	[0, 5, 6, 7],
	[3, 6, 7, 8],
	[2, 4, 6, 8],
	[2, 4, 5, 8],
	[1, 4, 5, 6],
]

const KENO_4X4_4_SPOT_COVERAGE_PATTERNS := [
	[6, 9, 11, 14],
	[1, 2, 8, 11],
	[0, 2, 8, 14],
	[5, 8, 10, 13],
	[2, 7, 10, 14],
	[0, 7, 11, 13],
	[7, 8, 9, 15],
	[0, 3, 6, 15],
	[5, 10, 11, 15],
	[6, 10, 12, 13],
	[1, 4, 13, 14],
	[3, 5, 12, 14],
	[3, 4, 7, 12],
	[0, 1, 9, 12],
	[4, 6, 8, 11],
	[2, 3, 9, 13],
	[0, 5, 6, 7],
	[1, 4, 5, 9],
	[2, 4, 12, 15],
	[1, 3, 10, 15],
]

const KENO_4X4_5_SPOT_COVERAGE_PATTERNS := [
	[2, 3, 4, 10, 13],
	[0, 1, 2, 5, 7],
	[4, 8, 11, 12, 14],
	[0, 2, 4, 8, 15],
	[0, 3, 7, 14, 15],
	[3, 5, 8, 12, 15],
	[5, 7, 11, 13, 14],
	[1, 4, 5, 6, 10],
	[1, 4, 7, 11, 15],
	[0, 3, 6, 10, 12],
	[0, 4, 9, 12, 13],
	[9, 10, 11, 13, 15],
	[2, 6, 12, 13, 15],
	[3, 5, 6, 9, 11],
	[0, 1, 6, 8, 14],
	[2, 4, 6, 7, 9],
	[5, 8, 9, 10, 14],
	[1, 2, 3, 8, 11],
	[1, 7, 9, 10, 12],
	[1, 3, 9, 13, 14],
]

const KENO_4X4_MIXED_COVERAGE_PATTERNS := [
	[4, 9, 10, 12],
	[2, 3, 9, 13],
	[0, 3, 14, 15],
	[0, 6, 12, 13],
	[1, 10, 13, 14],
	[0, 1, 4, 11],
	[1, 7, 12, 15],
	[7, 8, 10, 11],
	[0, 5, 7, 9],
	[5, 6, 11, 15],
	[2, 6, 9, 11, 14],
	[1, 3, 6, 8, 9],
	[4, 5, 8, 13, 15],
	[1, 2, 5, 8, 14],
	[2, 3, 4, 6, 8],
	[6, 7, 8, 13, 14],
	[2, 3, 5, 11, 12],
	[1, 3, 5, 6, 10],
	[0, 2, 8, 10, 15],
	[2, 4, 7, 14, 15],
]

const PAYOUT_TABLE := {
	1: {1: 3},
	2: {2: 12},
	3: {2: 1, 3: 42},
	4: {2: 1, 3: 8, 4: 100},
	5: {2: 1, 3: 4, 4: 20, 5: 450},
	6: {3: 2, 4: 10, 5: 100, 6: 1600},
	7: {3: 2, 4: 6, 5: 25, 6: 400, 7: 7000},
	8: {3: 1, 4: 4, 5: 15, 6: 50, 7: 1000, 8: 10000},
	9: {4: 3, 5: 8, 6: 30, 7: 200, 8: 4000, 9: 10000},
	10: {0: 2,  4: 2, 5: 5, 6: 20, 7: 80, 8: 500, 9: 5000, 10: 10000},
}
const POKER_HAND_SIZE := 5
const POKER_STARTING_CREDITS := 100.0
const POKER_SUITS := ["S", "H", "D", "C"]
const POKER_RANKS := [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
const POKER_CARD_DIR := "res://cards"
const POKER_CARD_DISPLAY_SIZE := Vector2(230, 345)
const POKER_CARD_ROTATIONS := [-4.0, -1.8, 0.0, 1.8, 4.0]
const SPIN_POKER_ROWS := 3
const SPIN_POKER_CENTER_ROW := 1
const SPIN_POKER_LINE_PATTERNS := [
	[1, 1, 1, 1, 1],
	[0, 0, 0, 0, 0],
	[2, 2, 2, 2, 2],
	[0, 1, 2, 1, 0],
	[2, 1, 0, 1, 2],
	[0, 0, 1, 2, 2],
	[2, 2, 1, 0, 0],
	[1, 0, 1, 2, 1],
	[1, 2, 1, 0, 1],
]
const POKER_PAYOUTS := {
	"Royal Flush": 250,
	"Straight Flush": 50,
	"Four of a Kind": 25,
	"Full House": 9,
	"Flush": 6,
	"Straight": 4,
	"Three of a Kind": 3,
	"Two Pair": 2,
	"Jacks or Better": 1,
	"Nothing": 0,
}
const BLACKJACK_STARTING_CREDITS := 100.0
const BLACKJACK_CARD_DISPLAY_SIZE := Vector2(150, 225)
const BLACKJACK_CARD_ROTATIONS := [-3.0, -1.2, 0.8, 2.2, 3.4, -2.0, 1.4]
const THREE_CARD_STARTING_CREDITS := 100.0
const THREE_CARD_DISPLAY_SIZE := Vector2(170, 255)
const THREE_CARD_ROTATIONS := [-2.4, 0.0, 2.4]
const THREE_CARD_PAIR_PLUS_PAYOUTS := {
	"Straight Flush": 40,
	"Three of a Kind": 30,
	"Straight": 6,
	"Flush": 3,
	"Pair": 1,
}
const THREE_CARD_ANTE_BONUS := {
	"Straight Flush": 5,
	"Three of a Kind": 4,
	"Straight": 1,
}
const CRISS_CROSS_STARTING_CREDITS := 200.0
const CRISS_CROSS_CARD_DISPLAY_SIZE := Vector2(120, 180)
const CRISS_CROSS_STAGE_READY := "ready"
const CRISS_CROSS_STAGE_ACROSS := "across"
const CRISS_CROSS_STAGE_DOWN := "down"
const CRISS_CROSS_STAGE_MIDDLE := "middle"
const CRISS_CROSS_STAGE_COMPLETE := "complete"
const CRISS_CROSS_MAIN_PAYOUTS := {
	"Royal Flush": 500,
	"Straight Flush": 100,
	"Four of a Kind": 40,
	"Full House": 12,
	"Flush": 8,
	"Straight": 5,
	"Three of a Kind": 3,
	"Two Pair": 2,
	"Jacks or Better": 1,
}
const CRISS_CROSS_BONUS_PAYOUTS := {
	"Royal Flush": 250,
	"Straight Flush": 100,
	"Four of a Kind": 40,
	"Full House": 15,
	"Flush": 10,
	"Straight": 6,
	"Three of a Kind": 4,
	"Two Pair": 3,
	"Sixes or Better": 1,
}
const PAI_GOW_STARTING_CREDITS := 200.0
const PAI_GOW_CARD_DISPLAY_SIZE := Vector2(98, 147)
const PAI_GOW_CARD_ROTATIONS := [-5.0, -3.0, -1.0, 1.0, 3.0, 5.0, 0.0]
const BACCARAT_STARTING_CREDITS := 100.0
const BACCARAT_TABLE_IMAGE := "res://tables/baccarat_table.png"
const BACCARAT_CARD_DISPLAY_SIZE := Vector2(150, 225)
const BACCARAT_CARD_ROTATIONS := [-2.0, 2.0, 0.0]
const BACCARAT_BET_OPTIONS := ["Player", "Banker", "Tie"]
const CRAPS_STARTING_CREDITS := 500.0
const CRAPS_TABLE_IMAGE := "res://tables/craps_layout.png"
const CRAPS_TABLE_REFERENCE_SIZE := Vector2(1880.0, 1312.0)
const CRAPS_CHIP_DIR := "res://assets/chips"
const CRAPS_DICE_DIR := "res://assets/dice"
const CRAPS_DICE_ROLL_DIR := "res://assets/dice_roll"
const CRAPS_DICE_FACE_FILES := [
	"dice_0000_Layer-1.png",
	"dice_0001_Layer-2.png",
	"dice_0002_Layer-3.png",
	"dice_0003_Layer-4.png",
	"dice_0004_Layer-5.png",
	"dice_0005_Layer-6.png",
]
const CRAPS_DICE_DISPLAY_SIZE := Vector2(132, 132)
const CRAPS_POINT_NUMBERS := [4, 5, 6, 8, 9, 10]
const CRAPS_HARDWAYS := [4, 6, 8, 10]
const CRAPS_CHIP_DENOMINATIONS := [1, 5, 10, 20, 25, 50, 100, 500, 1000, 5000]
const CRAPS_BET_ZONE_RECTS := {
	"pass": [Rect2(50.0, 190.0, 118.0, 844.0), Rect2(168.0, 1137.0, 1066.0, 123.0)],
	"dont_pass": [Rect2(168.0, 190.0, 119.0, 710.0), Rect2(408.0, 1018.0, 706.0, 116.0)],
	"come": [Rect2(290.0, 423.0, 825.0, 242.0)],
	"dont_come": [Rect2(290.0, 190.0, 354.0, 235.0)],
	"field": [Rect2(290.0, 665.0, 825.0, 353.0)],
	"big_6_8": [Rect2(168.0, 900.0, 240.0, 237.0)],
	"any_seven": [Rect2(1352.0, 190.0, 468.0, 181.0)],
	"any_craps": [Rect2(1352.0, 1075.0, 468.0, 183.0)],
	"hard_4": [Rect2(1352.0, 371.0, 238.0, 179.0)],
	"hard_6": [Rect2(1352.0, 551.0, 238.0, 179.0)],
	"hard_8": [Rect2(1590.0, 551.0, 230.0, 179.0)],
	"hard_10": [Rect2(1590.0, 371.0, 230.0, 179.0)],
	"aces": [Rect2(1352.0, 727.0, 238.0, 170.0)],
	"boxcars": [Rect2(1590.0, 727.0, 230.0, 170.0)],
	"ace_deuce": [Rect2(1352.0, 897.0, 238.0, 178.0)],
	"yo": [Rect2(1590.0, 897.0, 230.0, 178.0)],
}
const CRAPS_CHIP_POSITIONS := {
	"pass": Vector2(700.0, 1200.0),
	"dont_pass": Vector2(760.0, 1076.0),
	"come": Vector2(704.0, 545.0),
	"dont_come": Vector2(510.0, 310.0),
	"field": Vector2(704.0, 825.0),
	"big_6_8": Vector2(288.0, 1018.0),
	"any_seven": Vector2(1588.0, 280.0),
	"any_craps": Vector2(1588.0, 1168.0),
	"hard_4": Vector2(1470.0, 460.0),
	"hard_6": Vector2(1470.0, 640.0),
	"hard_8": Vector2(1705.0, 640.0),
	"hard_10": Vector2(1705.0, 460.0),
	"aces": Vector2(1470.0, 812.0),
	"boxcars": Vector2(1705.0, 812.0),
	"ace_deuce": Vector2(1470.0, 986.0),
	"yo": Vector2(1705.0, 986.0),
}
const CRAPS_POINT_MARKER_POSITIONS := {
	4: Vector2(582.0, 310.0),
	5: Vector2(703.0, 310.0),
	6: Vector2(825.0, 310.0),
	8: Vector2(944.0, 310.0),
	9: Vector2(1067.0, 310.0),
	10: Vector2(1180.0, 310.0),
}
const CRAPS_COME_POINT_CHIP_POSITIONS := {
	4: Vector2(582.0, 386.0),
	5: Vector2(703.0, 386.0),
	6: Vector2(825.0, 386.0),
	8: Vector2(944.0, 386.0),
	9: Vector2(1067.0, 386.0),
	10: Vector2(1180.0, 386.0),
}
const CRAPS_DONT_COME_POINT_CHIP_POSITIONS := {
	4: Vector2(582.0, 248.0),
	5: Vector2(703.0, 248.0),
	6: Vector2(825.0, 248.0),
	8: Vector2(944.0, 248.0),
	9: Vector2(1067.0, 248.0),
	10: Vector2(1180.0, 248.0),
}
const ROULETTE_STARTING_CREDITS := 500.0
const ROULETTE_TABLE_IMAGE := "res://tables/roulette_table.png"
const ROULETTE_WHEEL_IMAGE := "res://tables/roulette_wheel.png"
const ROULETTE_TABLE_REFERENCE_SIZE := Vector2(2048.0, 1104.0)
const ROULETTE_WHEEL_RECT := Rect2(42.0, 201.0, 760.0, 760.0)
const ROULETTE_WHEEL_CENTER := Vector2(421.0, 581.0)
const ROULETTE_BALL_TRACK_RADIUS := 258.0
const ROULETTE_BALL_BUMP_BOUNCE := 28.0
const ROULETTE_BALL_BUMP_COUNT := 30.0
const ROULETTE_CHIP_DENOMINATIONS := [1, 5, 10, 20, 25, 50, 100, 500]
const ROULETTE_RED_NUMBERS := [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36]
const ROULETTE_BET_OPTIONS := [
	{"label": "Red pays 1:1", "id": "red", "payout": 1},
	{"label": "Black pays 1:1", "id": "black", "payout": 1},
	{"label": "Odd pays 1:1", "id": "odd", "payout": 1},
	{"label": "Even pays 1:1", "id": "even", "payout": 1},
	{"label": "1 to 18 pays 1:1", "id": "low", "payout": 1},
	{"label": "19 to 36 pays 1:1", "id": "high", "payout": 1},
	{"label": "1st 12 pays 2:1", "id": "first_dozen", "payout": 2},
	{"label": "2nd 12 pays 2:1", "id": "second_dozen", "payout": 2},
	{"label": "3rd 12 pays 2:1", "id": "third_dozen", "payout": 2},
	{"label": "Column 1 pays 2:1", "id": "column_1", "payout": 2},
	{"label": "Column 2 pays 2:1", "id": "column_2", "payout": 2},
	{"label": "Column 3 pays 2:1", "id": "column_3", "payout": 2},
]
const SLOT_SCENE_PATH := "res://assets/slot_machine.tscn"
const LOBBY_IMAGE_PATH := "res://assets/lobby.png"
const LOBBY_EXIT := "exit"

var current_game := GAME_KENO
var selected_card := 0
var card_picks: Array = []
var card_plays := []
var card_wins := []
var card_profit := []
var card_last_hits := []
var card_last_paid := []
var saved_pick_patterns: Array = []
var selected_saved_pattern_index := 0
var saved_card_groups: Array = []
var selected_saved_group_index := 0
var keno_batch_running := false
var number_hit_counts := []
var last_draw := []
var reveal_all_card_numbers := false
var rounds_played := 0
var winning_rounds := 0
var losing_rounds := 0
var total_wagered := 0.0
var total_paid := 0.0
var keno_credits := KENO_STARTING_CREDITS
var keno_last_round_paid := 0.0
var keno_last_round_wagered := 0.0
var keno_last_cards_played := 0
var recent_runs: Array = []
var hit_tally: Dictionary = {}

var card_buttons := []
var number_buttons: Dictionary = {}
var keno_board_action_buttons := []
var keno_current_value_label: Label
var keno_pattern_value_label: Label
var keno_bottom_win_label: Label
var keno_bottom_cards_played_label: Label
var keno_bottom_bet_label: Label
var keno_bottom_credit_label: Label
var keno_summary_labels := []
var bet_spin: SpinBox
var quick_pick_count_spin: SpinBox
var saved_pattern_option: OptionButton
var saved_group_option: OptionButton
var saved_group_name_edit: LineEdit
var coverage_wheel_option: OptionButton
var patch_size_option: OptionButton
var optimizer_pick_count_spin: SpinBox
var batch_run_count_spin: SpinBox
var run_group_button: Button
var auto_play_button: Button
var auto_play_timer: Timer
var lock_layout_button: Button
var left_split: HSplitContainer
var right_split: HSplitContainer
var selected_label: Label
var last_draw_label: Label
var result_label: Label
var keno_board_scroll: ScrollContainer
var keno_board_control: Control
var keno_board_payout_hits_label: Label
var keno_board_payout_wins_label: Label
var keno_board_marked_value_label: Label
var keno_board_hit_value_label: Label
var keno_ball_stage: Control
var keno_ball_tube: PanelContainer
var keno_ball_spout: PanelContainer
var keno_ball_nodes := []
var keno_ball_tween: Tween
var keno_ball_textures: Dictionary = {}
var keno_ball_animating := false
var stats_label: Label
var hit_tally_label: Label
var recent_runs_label: Label
var hot_label: Label
var cold_label: Label
var suggestion_label: Label
var keno_root: VBoxContainer
var poker_root: VBoxContainer
var pai_gow_root: VBoxContainer
var blackjack_root: VBoxContainer
var three_card_root: VBoxContainer
var criss_cross_root: VBoxContainer
var baccarat_root: VBoxContainer
var craps_root: VBoxContainer
var roulette_root: VBoxContainer
var slots_root: VBoxContainer
var keno_game_button: Button
var poker_game_button: Button
var pai_gow_game_button: Button
var blackjack_game_button: Button
var three_card_game_button: Button
var criss_cross_game_button: Button
var baccarat_game_button: Button
var craps_game_button: Button
var roulette_game_button: Button
var slots_game_button: Button
var exit_game_button: Button
var poker_bet_spin: SpinBox
var poker_hand_count_option: OptionButton
var poker_deal_button: Button
var poker_draw_button: Button
var poker_bankroll_label: Label
var poker_status_label: Label
var poker_tip_label: Label
var poker_result_label: Label
var poker_paytable_label: Label
var poker_card_grid: GridContainer
var poker_card_buttons := []
var poker_card_textures: Dictionary = {}
var poker_deck := []
var poker_cards := []
var poker_hands := []
var poker_hold := []
var poker_hand_count := 9
var poker_credits := POKER_STARTING_CREDITS
var poker_hands_played := 0
var poker_total_wagered := 0.0
var poker_total_paid := 0.0
var poker_waiting_for_draw := false
var blackjack_bet_spin: SpinBox
var blackjack_deal_button: Button
var blackjack_hit_button: Button
var blackjack_stand_button: Button
var blackjack_bankroll_label: Label
var blackjack_status_label: Label
var blackjack_tip_label: Label
var blackjack_result_label: Label
var blackjack_dealer_total_label: Label
var blackjack_player_total_label: Label
var blackjack_dealer_row: HBoxContainer
var blackjack_player_row: HBoxContainer
var blackjack_deck := []
var blackjack_dealer_cards := []
var blackjack_player_cards := []
var blackjack_credits := BLACKJACK_STARTING_CREDITS
var blackjack_current_bet := 0.0
var blackjack_hands_played := 0
var blackjack_total_wagered := 0.0
var blackjack_total_paid := 0.0
var blackjack_in_round := false
var blackjack_round_over := false
var three_card_ante_spin: SpinBox
var three_card_pair_plus_spin: SpinBox
var three_card_deal_button: Button
var three_card_play_button: Button
var three_card_fold_button: Button
var three_card_bankroll_label: Label
var three_card_status_label: Label
var three_card_tip_label: Label
var three_card_result_label: Label
var three_card_dealer_label: Label
var three_card_player_label: Label
var three_card_dealer_row: HBoxContainer
var three_card_player_row: HBoxContainer
var three_card_deck := []
var three_card_dealer_cards := []
var three_card_player_cards := []
var three_card_credits := THREE_CARD_STARTING_CREDITS
var three_card_current_ante := 0.0
var three_card_current_pair_plus := 0.0
var three_card_hands_played := 0
var three_card_total_wagered := 0.0
var three_card_total_paid := 0.0
var three_card_in_round := false
var three_card_reveal_dealer := false
var criss_cross_ante_spin: SpinBox
var criss_cross_bonus_spin: SpinBox
var criss_cross_across_mult_spin: SpinBox
var criss_cross_down_mult_spin: SpinBox
var criss_cross_middle_mult_spin: SpinBox
var criss_cross_deal_button: Button
var criss_cross_across_button: Button
var criss_cross_down_button: Button
var criss_cross_middle_button: Button
var criss_cross_fold_button: Button
var criss_cross_bankroll_label: Label
var criss_cross_status_label: Label
var criss_cross_tip_label: Label
var criss_cross_result_label: Label
var criss_cross_across_label: Label
var criss_cross_down_label: Label
var criss_cross_bonus_label: Label
var criss_cross_player_row: HBoxContainer
var criss_cross_community_grid: GridContainer
var criss_cross_deck := []
var criss_cross_player_cards := []
var criss_cross_community_cards := []
var criss_cross_credits := CRISS_CROSS_STARTING_CREDITS
var criss_cross_current_ante := 0.0
var criss_cross_current_bonus := 0.0
var criss_cross_across_bet := 0.0
var criss_cross_down_bet := 0.0
var criss_cross_middle_bet := 0.0
var criss_cross_hands_played := 0
var criss_cross_total_wagered := 0.0
var criss_cross_total_paid := 0.0
var criss_cross_stage := CRISS_CROSS_STAGE_READY
var pai_gow_bet_spin: SpinBox
var pai_gow_deal_button: Button
var pai_gow_house_way_button: Button
var pai_gow_set_button: Button
var pai_gow_bankroll_label: Label
var pai_gow_status_label: Label
var pai_gow_tip_label: Label
var pai_gow_result_label: Label
var pai_gow_player_low_label: Label
var pai_gow_player_high_label: Label
var pai_gow_dealer_low_label: Label
var pai_gow_dealer_high_label: Label
var pai_gow_selection_row: HBoxContainer
var pai_gow_player_low_row: HBoxContainer
var pai_gow_player_high_row: HBoxContainer
var pai_gow_dealer_low_row: HBoxContainer
var pai_gow_dealer_high_row: HBoxContainer
var pai_gow_deck := []
var pai_gow_player_cards := []
var pai_gow_dealer_cards := []
var pai_gow_low_indices := []
var pai_gow_credits := PAI_GOW_STARTING_CREDITS
var pai_gow_current_bet := 0.0
var pai_gow_hands_played := 0
var pai_gow_total_wagered := 0.0
var pai_gow_total_paid := 0.0
var pai_gow_in_round := false
var pai_gow_reveal_dealer := false
var baccarat_bet_spin: SpinBox
var baccarat_bet_option: OptionButton
var baccarat_deal_button: Button
var baccarat_bankroll_label: Label
var baccarat_status_label: Label
var baccarat_tip_label: Label
var baccarat_result_label: Label
var baccarat_player_label: Label
var baccarat_banker_label: Label
var baccarat_player_row: HBoxContainer
var baccarat_banker_row: HBoxContainer
var baccarat_table_texture: TextureRect
var baccarat_deck := []
var baccarat_player_cards := []
var baccarat_banker_cards := []
var baccarat_credits := BACCARAT_STARTING_CREDITS
var baccarat_hands_played := 0
var baccarat_total_wagered := 0.0
var baccarat_total_paid := 0.0
var baccarat_last_bet_side := "Banker"
var craps_bet_spin: SpinBox
var craps_roll_button: Button
var craps_reset_button: Button
var craps_bankroll_label: Label
var craps_status_label: Label
var craps_tip_label: Label
var craps_result_label: Label
var craps_history_label: Label
var craps_bets_label: Label
var craps_point_label: Label
var craps_dice_row: HBoxContainer
var craps_die_one: TextureRect
var craps_die_two: TextureRect
var craps_bet_labels: Dictionary = {}
var craps_point_markers: Dictionary = {}
var craps_table_surface: Control
var craps_table_texture: TextureRect
var craps_chip_layer: Control
var craps_chip_selector_row: HBoxContainer
var craps_chip_selector_buttons: Dictionary = {}
var craps_roll_button_anchor: Control
var craps_chip_textures: Dictionary = {}
var craps_dice_textures: Dictionary = {}
var craps_roll_sequences := []
var craps_bets := {
	"pass": 0.0,
	"dont_pass": 0.0,
	"come": 0.0,
	"dont_come": 0.0,
	"field": 0.0,
	"big_6_8": 0.0,
	"any_seven": 0.0,
	"any_craps": 0.0,
	"hard_4": 0.0,
	"hard_6": 0.0,
	"hard_8": 0.0,
	"hard_10": 0.0,
	"aces": 0.0,
	"boxcars": 0.0,
	"ace_deuce": 0.0,
	"yo": 0.0,
}
var craps_come_points := {}
var craps_dont_come_points := {}
var craps_credits := CRAPS_STARTING_CREDITS
var craps_point := 0
var craps_rolls_played := 0
var craps_total_wagered := 0.0
var craps_total_paid := 0.0
var craps_roll_history := []
var craps_last_roll := [1, 1]
var craps_roll_in_progress := false
var craps_selected_chip_value := 10.0
var roulette_bet_spin: SpinBox
var roulette_bet_option: OptionButton
var roulette_spin_button: Button
var roulette_reset_button: Button
var roulette_bankroll_label: Label
var roulette_status_label: Label
var roulette_tip_label: Label
var roulette_result_label: Label
var roulette_history_label: Label
var roulette_table_surface: Control
var roulette_table_texture: TextureRect
var roulette_wheel_texture: TextureRect
var roulette_ball: Control
var roulette_chip_layer: Control
var roulette_chip_selector_row: HBoxContainer
var roulette_chip_selector_buttons: Dictionary = {}
var roulette_bet_zone_buttons: Dictionary = {}
var roulette_bet_zone_rects: Dictionary = {}
var roulette_credits := ROULETTE_STARTING_CREDITS
var roulette_spins_played := 0
var roulette_total_wagered := 0.0
var roulette_total_paid := 0.0
var roulette_last_pocket := 0
var roulette_spin_history := []
var roulette_bets := {}
var roulette_selected_chip_value := 10.0
var roulette_spin_in_progress := false
var roulette_ball_angle := -0.7
var roulette_ball_track_offset := 0.0
var casino_root: MarginContainer
var lobby_root: Control
var lobby_background_texture: TextureRect
var lobby_menu_buttons := []


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		_layout_lobby_buttons()


func _ready() -> void:
	randomize()
	for i in CARD_COUNT:
		card_picks.append([])
		card_plays.append(0)
		card_wins.append(0)
		card_profit.append(0.0)
		card_last_hits.append(0)
		card_last_paid.append(0.0)
	for i in SAVED_KENO_PATTERN_COUNT:
		saved_pick_patterns.append([])
	for i in SAVED_KENO_GROUP_COUNT:
		saved_card_groups.append(_empty_keno_card_group(i))
	for i in NUMBER_MAX + 1:
		number_hit_counts.append(0)

	_load_saved_pick_patterns()
	_load_saved_card_groups()
	_load_keno_ball_textures()
	_load_craps_chip_textures()
	_load_craps_dice_textures()
	_load_craps_roll_textures()
	_build_interface()
	get_viewport().size_changed.connect(_fit_keno_board_to_scroll)
	_refresh_all()


func _build_interface() -> void:
	var background := ColorRect.new()
	background.color = Color("#151820")
	background.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(background)

	var margin := MarginContainer.new()
	margin.set_anchors_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 16)
	margin.add_theme_constant_override("margin_top", 16)
	margin.add_theme_constant_override("margin_right", 16)
	margin.add_theme_constant_override("margin_bottom", 16)
	margin.visible = false
	add_child(margin)
	casino_root = margin

	var main := VBoxContainer.new()
	main.add_theme_constant_override("separation", 6)
	margin.add_child(main)

	auto_play_timer = Timer.new()
	auto_play_timer.wait_time = 0.65
	auto_play_timer.one_shot = false
	auto_play_timer.timeout.connect(_on_auto_play_timeout)
	add_child(auto_play_timer)

	if SHOW_CASINO_GAME_TABS:
		_build_game_switcher(main)

	keno_root = VBoxContainer.new()
	keno_root.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	keno_root.size_flags_vertical = Control.SIZE_EXPAND_FILL
	keno_root.add_theme_constant_override("separation", 4)
	keno_root.visible = current_game == GAME_KENO
	main.add_child(keno_root)

	poker_root = VBoxContainer.new()
	poker_root.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	poker_root.size_flags_vertical = Control.SIZE_EXPAND_FILL
	poker_root.add_theme_constant_override("separation", 12)
	poker_root.visible = false
	main.add_child(poker_root)


	pai_gow_root = VBoxContainer.new()
	pai_gow_root.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	pai_gow_root.size_flags_vertical = Control.SIZE_EXPAND_FILL
	pai_gow_root.add_theme_constant_override("separation", 12)
	pai_gow_root.visible = current_game == GAME_PAI_GOW
	main.add_child(pai_gow_root)

	blackjack_root = VBoxContainer.new()
	blackjack_root.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	blackjack_root.size_flags_vertical = Control.SIZE_EXPAND_FILL
	blackjack_root.add_theme_constant_override("separation", 12)
	blackjack_root.visible = false
	main.add_child(blackjack_root)

	three_card_root = VBoxContainer.new()
	three_card_root.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	three_card_root.size_flags_vertical = Control.SIZE_EXPAND_FILL
	three_card_root.add_theme_constant_override("separation", 12)
	three_card_root.visible = false
	main.add_child(three_card_root)

	criss_cross_root = VBoxContainer.new()
	criss_cross_root.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	criss_cross_root.size_flags_vertical = Control.SIZE_EXPAND_FILL
	criss_cross_root.add_theme_constant_override("separation", 12)
	criss_cross_root.visible = false
	main.add_child(criss_cross_root)

	baccarat_root = VBoxContainer.new()
	baccarat_root.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	baccarat_root.size_flags_vertical = Control.SIZE_EXPAND_FILL
	baccarat_root.add_theme_constant_override("separation", 12)
	baccarat_root.visible = false
	main.add_child(baccarat_root)

	craps_root = VBoxContainer.new()
	craps_root.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	craps_root.size_flags_vertical = Control.SIZE_EXPAND_FILL
	craps_root.add_theme_constant_override("separation", 12)
	craps_root.visible = current_game == GAME_CRAPS
	main.add_child(craps_root)

	roulette_root = VBoxContainer.new()
	roulette_root.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	roulette_root.size_flags_vertical = Control.SIZE_EXPAND_FILL
	roulette_root.add_theme_constant_override("separation", 12)
	roulette_root.visible = current_game == GAME_ROULETTE
	main.add_child(roulette_root)

	slots_root = VBoxContainer.new()
	slots_root.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	slots_root.size_flags_vertical = Control.SIZE_EXPAND_FILL
	slots_root.add_theme_constant_override("separation", 12)
	slots_root.visible = false
	main.add_child(slots_root)


	var top_bar := HFlowContainer.new()
	top_bar.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	top_bar.add_theme_constant_override("h_separation", 3)
	top_bar.add_theme_constant_override("v_separation", 2)
	keno_root.add_child(top_bar)

	var title := Label.new()
	title.text = "20 Card Keno"
	title.add_theme_font_size_override("font_size", 18)
	title.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(title)
	top_bar.add_child(title)

	selected_label = Label.new()
	selected_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	selected_label.add_theme_font_size_override("font_size", 11)
	selected_label.add_theme_color_override("font_color", Color("#cad1df"))
	_apply_text_depth(selected_label)
	top_bar.add_child(selected_label)

	var bet_label := Label.new()
	bet_label.text = "Bet per card"
	bet_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	bet_label.add_theme_font_size_override("font_size", 13)
	bet_label.add_theme_color_override("font_color", Color("#cad1df"))
	top_bar.add_child(bet_label)

	bet_spin = SpinBox.new()
	bet_spin.min_value = 1.0
	bet_spin.max_value = 1000.0
	bet_spin.step = 1.0
	bet_spin.value = 1.0
	bet_spin.custom_minimum_size = Vector2(68, 28)
	top_bar.add_child(bet_spin)

	var hot_pick_button := Button.new()
	hot_pick_button.text = "Hot Picks"
	hot_pick_button.tooltip_text = "Fill the selected card with the most-hit numbers from past draws."
	hot_pick_button.custom_minimum_size = Vector2(76, 28)
	hot_pick_button.pressed.connect(_on_use_hot_picks_pressed)
	_apply_button_text_depth(hot_pick_button)
	top_bar.add_child(hot_pick_button)

	var quick_count_label := Label.new()
	quick_count_label.text = "Quick"
	quick_count_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	quick_count_label.add_theme_font_size_override("font_size", 13)
	quick_count_label.add_theme_color_override("font_color", Color("#cad1df"))
	top_bar.add_child(quick_count_label)

	quick_pick_count_spin = SpinBox.new()
	quick_pick_count_spin.min_value = 1.0
	quick_pick_count_spin.max_value = float(MAX_PICKS_PER_CARD)
	quick_pick_count_spin.step = 1.0
	quick_pick_count_spin.value = float(MAX_PICKS_PER_CARD)
	quick_pick_count_spin.custom_minimum_size = Vector2(58, 28)
	quick_pick_count_spin.tooltip_text = "How many numbers Quick Card and Quick Pick All should choose."
	top_bar.add_child(quick_pick_count_spin)

	var quick_pick_card_button := Button.new()
	quick_pick_card_button.text = "Quick Card"
	quick_pick_card_button.tooltip_text = "Randomly fill the selected card with the quick count."
	quick_pick_card_button.custom_minimum_size = Vector2(82, 28)
	quick_pick_card_button.pressed.connect(_on_quick_pick_card_pressed)
	_apply_button_text_depth(quick_pick_card_button)
	top_bar.add_child(quick_pick_card_button)

	var quick_pick_button := Button.new()
	quick_pick_button.text = "Quick All"
	quick_pick_button.tooltip_text = "Randomly fill every card with the quick count."
	quick_pick_button.custom_minimum_size = Vector2(76, 28)
	quick_pick_button.pressed.connect(_on_quick_pick_all_pressed)
	_apply_button_text_depth(quick_pick_button)
	top_bar.add_child(quick_pick_button)

	saved_pattern_option = OptionButton.new()
	saved_pattern_option.custom_minimum_size = Vector2(128, 28)
	saved_pattern_option.tooltip_text = "Choose a saved pick pattern slot."
	saved_pattern_option.item_selected.connect(_on_saved_pattern_selected)
	top_bar.add_child(saved_pattern_option)

	var save_pattern_button := Button.new()
	save_pattern_button.text = "Save"
	save_pattern_button.tooltip_text = "Save the selected card's picks into the chosen pattern slot."
	save_pattern_button.custom_minimum_size = Vector2(48, 28)
	save_pattern_button.pressed.connect(_on_save_pattern_pressed)
	_apply_button_text_depth(save_pattern_button)
	top_bar.add_child(save_pattern_button)

	var use_pattern_button := Button.new()
	use_pattern_button.text = "Use"
	use_pattern_button.tooltip_text = "Load the chosen saved pattern onto the selected card."
	use_pattern_button.custom_minimum_size = Vector2(44, 28)
	use_pattern_button.pressed.connect(_on_use_saved_pattern_pressed)
	_apply_button_text_depth(use_pattern_button)
	top_bar.add_child(use_pattern_button)

	var reset_menu_button := MenuButton.new()
	reset_menu_button.text = "Resets"
	reset_menu_button.tooltip_text = "Reset keno counters, card stats, hit history, or picks."
	reset_menu_button.custom_minimum_size = Vector2(62, 28)
	var reset_popup := reset_menu_button.get_popup()
	reset_popup.add_item("Reset All-Time", 0)
	reset_popup.add_item("Reset Last 100", 1)
	reset_popup.add_item("Reset Hits", 2)
	reset_popup.add_item("Reset Card Stats", 3)
	reset_popup.add_item("Reset All Card Stats", 4)
	reset_popup.add_separator()
	reset_popup.add_item("Clear Card Picks", 5)
	reset_popup.add_item("Clear All Picks", 6)
	reset_popup.add_separator()
	reset_popup.add_item("Reset Everything", 7)
	reset_popup.id_pressed.connect(_on_keno_reset_menu_id_pressed)
	_apply_button_text_depth(reset_menu_button)
	top_bar.add_child(reset_menu_button)

	var play_button := Button.new()
	play_button.text = "Play"
	play_button.custom_minimum_size = Vector2(52, 28)
	play_button.pressed.connect(_on_play_pressed)
	_apply_button_text_depth(play_button)
	top_bar.add_child(play_button)

	auto_play_button = Button.new()
	auto_play_button.text = "Auto Play"
	auto_play_button.toggle_mode = true
	auto_play_button.tooltip_text = "Keep playing rounds until pressed again."
	auto_play_button.custom_minimum_size = Vector2(76, 28)
	auto_play_button.toggled.connect(_on_auto_play_toggled)
	_apply_button_text_depth(auto_play_button)
	top_bar.add_child(auto_play_button)
	_refresh_auto_play_button(false)

	lock_layout_button = Button.new()
	lock_layout_button.text = "Lock Layout"
	lock_layout_button.toggle_mode = true
	lock_layout_button.tooltip_text = "Lock or unlock the panel drag handles."
	lock_layout_button.custom_minimum_size = Vector2.ZERO
	lock_layout_button.toggled.connect(_on_lock_layout_toggled)
	_apply_button_text_depth(lock_layout_button)
	top_bar.add_child(lock_layout_button)
	lock_layout_button.disabled = true
	lock_layout_button.visible = false
	lock_layout_button.tooltip_text = "The new keno card uses a fixed artwork layout."
	_apply_compact_control_text(top_bar, 11)
	title.add_theme_font_size_override("font_size", 18)
	selected_label.add_theme_font_size_override("font_size", 11)

	keno_root.add_child(_build_keno_group_bar())
	_refresh_saved_pattern_option()
	_refresh_saved_group_option()
	keno_root.add_child(_build_number_panel())
	_build_poker_interface()
	_build_pai_gow_interface()
	_build_blackjack_interface()
	_build_three_card_interface()
	_build_criss_cross_interface()
	_build_baccarat_interface()
	_build_craps_interface()
	_build_roulette_interface()
	_build_slots_interface()
	_refresh_game_switcher()
	_refresh_poker()
	_refresh_pai_gow()
	_refresh_blackjack()
	_refresh_three_card()
	_refresh_criss_cross()
	_refresh_baccarat()
	_refresh_craps()
	_refresh_roulette()
	call_deferred("_apply_default_panel_sizes")
	_build_lobby_interface()


func _build_game_switcher(parent: VBoxContainer) -> void:
	var switcher := HFlowContainer.new()
	switcher.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	switcher.add_theme_constant_override("h_separation", 4)
	switcher.add_theme_constant_override("v_separation", 3)
	parent.add_child(switcher)

	var title := Label.new()
	title.text = "Games"
	title.add_theme_font_size_override("font_size", 22)
	title.add_theme_color_override("font_color", Color("#f6f0df"))
	title.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_apply_text_depth(title)
	switcher.add_child(title)

	keno_game_button = Button.new()
	keno_game_button.text = "20 Keno"
	keno_game_button.toggle_mode = true
	keno_game_button.custom_minimum_size = Vector2(92, 32)
	keno_game_button.pressed.connect(_on_game_selected.bind(GAME_KENO))
	_apply_button_text_depth(keno_game_button)
	switcher.add_child(keno_game_button)

	poker_game_button = Button.new()
	poker_game_button.text = "Spin"
	poker_game_button.toggle_mode = true
	poker_game_button.custom_minimum_size = Vector2(78, 32)
	poker_game_button.pressed.connect(_on_game_selected.bind(GAME_POKER))
	_apply_button_text_depth(poker_game_button)
	switcher.add_child(poker_game_button)

	pai_gow_game_button = Button.new()
	pai_gow_game_button.text = "Pai Gow"
	pai_gow_game_button.toggle_mode = true
	pai_gow_game_button.custom_minimum_size = Vector2(86, 32)
	pai_gow_game_button.pressed.connect(_on_game_selected.bind(GAME_PAI_GOW))
	_apply_button_text_depth(pai_gow_game_button)
	switcher.add_child(pai_gow_game_button)

	blackjack_game_button = Button.new()
	blackjack_game_button.text = "BJ"
	blackjack_game_button.toggle_mode = true
	blackjack_game_button.custom_minimum_size = Vector2(62, 32)
	blackjack_game_button.pressed.connect(_on_game_selected.bind(GAME_BLACKJACK))
	_apply_button_text_depth(blackjack_game_button)
	switcher.add_child(blackjack_game_button)

	three_card_game_button = Button.new()
	three_card_game_button.text = "3 Card"
	three_card_game_button.toggle_mode = true
	three_card_game_button.custom_minimum_size = Vector2(82, 32)
	three_card_game_button.pressed.connect(_on_game_selected.bind(GAME_THREE_CARD))
	_apply_button_text_depth(three_card_game_button)
	switcher.add_child(three_card_game_button)

	criss_cross_game_button = Button.new()
	criss_cross_game_button.text = "Criss"
	criss_cross_game_button.toggle_mode = true
	criss_cross_game_button.custom_minimum_size = Vector2(76, 32)
	criss_cross_game_button.pressed.connect(_on_game_selected.bind(GAME_CRISS_CROSS))
	_apply_button_text_depth(criss_cross_game_button)
	switcher.add_child(criss_cross_game_button)

	baccarat_game_button = Button.new()
	baccarat_game_button.text = "Bacc"
	baccarat_game_button.toggle_mode = true
	baccarat_game_button.custom_minimum_size = Vector2(74, 32)
	baccarat_game_button.pressed.connect(_on_game_selected.bind(GAME_BACCARAT))
	_apply_button_text_depth(baccarat_game_button)
	switcher.add_child(baccarat_game_button)

	craps_game_button = Button.new()
	craps_game_button.text = "Craps"
	craps_game_button.toggle_mode = true
	craps_game_button.custom_minimum_size = Vector2(74, 32)
	craps_game_button.pressed.connect(_on_game_selected.bind(GAME_CRAPS))
	_apply_button_text_depth(craps_game_button)
	switcher.add_child(craps_game_button)

	roulette_game_button = Button.new()
	roulette_game_button.text = "Rou"
	roulette_game_button.toggle_mode = true
	roulette_game_button.custom_minimum_size = Vector2(70, 32)
	roulette_game_button.pressed.connect(_on_game_selected.bind(GAME_ROULETTE))
	_apply_button_text_depth(roulette_game_button)
	switcher.add_child(roulette_game_button)

	slots_game_button = Button.new()
	slots_game_button.text = "Slots"
	slots_game_button.toggle_mode = true
	slots_game_button.custom_minimum_size = Vector2(70, 32)
	slots_game_button.pressed.connect(_on_game_selected.bind(GAME_SLOTS))
	_apply_button_text_depth(slots_game_button)
	switcher.add_child(slots_game_button)

	var spacer := Control.new()
	spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	spacer.visible = false
	switcher.add_child(spacer)

	exit_game_button = Button.new()
	exit_game_button.text = "Lobby"
	exit_game_button.custom_minimum_size = Vector2(72, 32)
	exit_game_button.tooltip_text = "Return to the lobby."
	exit_game_button.pressed.connect(_on_exit_pressed)
	_apply_button_text_depth(exit_game_button)
	switcher.add_child(exit_game_button)

	title.visible = false
	for button in [
		keno_game_button,
		poker_game_button,
		pai_gow_game_button,
		blackjack_game_button,
		three_card_game_button,
		criss_cross_game_button,
		baccarat_game_button,
		craps_game_button,
		roulette_game_button,
		slots_game_button,
	]:
		button.visible = false
	spacer.visible = true
	exit_game_button.custom_minimum_size = Vector2(82, 32)
	_apply_exit_tab_style()
	_apply_compact_control_text(switcher, 13)
	title.add_theme_font_size_override("font_size", 22)


func _build_lobby_interface() -> void:
	lobby_root = Control.new()
	lobby_root.name = "Lobby"
	lobby_root.mouse_filter = Control.MOUSE_FILTER_STOP
	lobby_root.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(lobby_root)

	var background := ColorRect.new()
	background.color = Color("#050506")
	background.set_anchors_preset(Control.PRESET_FULL_RECT)
	lobby_root.add_child(background)

	lobby_background_texture = TextureRect.new()
	lobby_background_texture.name = "LobbyImage"
	lobby_background_texture.texture = _load_lobby_texture()
	lobby_background_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	lobby_background_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	lobby_background_texture.set_anchors_preset(Control.PRESET_FULL_RECT)
	lobby_root.add_child(lobby_background_texture)

	if lobby_background_texture.texture == null:
		var missing_label := Label.new()
		missing_label.text = "Lobby image missing: %s" % LOBBY_IMAGE_PATH
		missing_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		missing_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		missing_label.add_theme_font_size_override("font_size", 28)
		missing_label.add_theme_color_override("font_color", Color("#f5d067"))
		missing_label.set_anchors_preset(Control.PRESET_FULL_RECT)
		_apply_text_depth(missing_label)
		lobby_root.add_child(missing_label)

	_add_lobby_button(GAME_KENO, Rect2(0.37, 0.249, 0.24, 0.057), "Keno")
	_add_lobby_button(GAME_POKER, Rect2(0.36, 0.316, 0.26, 0.057), "Spin Poker")
	_add_lobby_button(GAME_PAI_GOW, Rect2(0.285, 0.382, 0.43, 0.057), "Pai Gow Poker")
	_add_lobby_button(GAME_BLACKJACK, Rect2(0.33, 0.449, 0.34, 0.057), "Blackjack")
	_add_lobby_button(GAME_THREE_CARD, Rect2(0.245, 0.515, 0.51, 0.057), "3 Card Poker")
	_add_lobby_button(GAME_BACCARAT, Rect2(0.34, 0.583, 0.32, 0.057), "Baccarat")
	_add_lobby_button(GAME_CRAPS, Rect2(0.38, 0.650, 0.24, 0.057), "Craps")
	_add_lobby_button(GAME_ROULETTE, Rect2(0.34, 0.715, 0.32, 0.057), "Roulette")
	_add_lobby_button(GAME_SLOTS, Rect2(0.38, 0.785, 0.24, 0.057), "Slots")
	_add_lobby_button(LOBBY_EXIT, Rect2(0.39, 0.849, 0.22, 0.057), "Exit")
	_layout_lobby_buttons()


func _add_lobby_button(game: String, normalized_rect: Rect2, label: String) -> void:
	var button := Button.new()
	button.text = ""
	button.tooltip_text = label
	button.focus_mode = Control.FOCUS_NONE
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	button.pressed.connect(_on_lobby_game_pressed.bind(game))
	button.add_theme_stylebox_override("normal", _transparent_lobby_button_style(false, false))
	button.add_theme_stylebox_override("hover", _transparent_lobby_button_style(true, false))
	button.add_theme_stylebox_override("pressed", _transparent_lobby_button_style(true, true))
	button.add_theme_color_override("font_color", Color(0, 0, 0, 0))
	lobby_root.add_child(button)
	lobby_menu_buttons.append({
		"button": button,
		"rect": normalized_rect,
	})


func _on_lobby_game_pressed(game: String) -> void:
	if game == LOBBY_EXIT:
		_quit_casino()
		return

	if lobby_root != null:
		lobby_root.visible = false
	if casino_root != null:
		casino_root.visible = true
	_on_game_selected(game)


func _load_lobby_texture() -> Texture2D:
	if ResourceLoader.exists(LOBBY_IMAGE_PATH):
		var texture := load(LOBBY_IMAGE_PATH)
		if texture is Texture2D:
			return texture

	if FileAccess.file_exists(LOBBY_IMAGE_PATH):
		var image := Image.new()
		if image.load(LOBBY_IMAGE_PATH) == OK:
			return ImageTexture.create_from_image(image)
	return null


func _layout_lobby_buttons() -> void:
	if lobby_root == null or lobby_background_texture == null or lobby_background_texture.texture == null:
		return

	var image_rect := _get_lobby_image_rect()
	for entry in lobby_menu_buttons:
		var button: Button = entry["button"]
		var normalized_rect: Rect2 = entry["rect"]
		button.position = image_rect.position + Vector2(
			normalized_rect.position.x * image_rect.size.x,
			normalized_rect.position.y * image_rect.size.y
		)
		button.size = Vector2(
			normalized_rect.size.x * image_rect.size.x,
			normalized_rect.size.y * image_rect.size.y
		)


func _get_lobby_image_rect() -> Rect2:
	var viewport_size := lobby_root.size
	var texture_size := lobby_background_texture.texture.get_size()
	if viewport_size.x <= 0.0 or viewport_size.y <= 0.0 or texture_size.x <= 0.0 or texture_size.y <= 0.0:
		return Rect2(Vector2.ZERO, viewport_size)

	var scale_factor: float = min(viewport_size.x / texture_size.x, viewport_size.y / texture_size.y)
	var display_size := texture_size * scale_factor
	var display_position := (viewport_size - display_size) * 0.5
	return Rect2(display_position, display_size)


func _on_game_selected(game: String) -> void:
	if game == current_game:
		_refresh_game_switcher()
		return

	current_game = game
	if current_game != GAME_KENO and auto_play_timer != null:
		auto_play_timer.stop()
		if auto_play_button != null:
			auto_play_button.set_pressed_no_signal(false)
		_refresh_auto_play_button(false)

	keno_root.visible = current_game == GAME_KENO
	poker_root.visible = current_game == GAME_POKER
	pai_gow_root.visible = current_game == GAME_PAI_GOW
	blackjack_root.visible = current_game == GAME_BLACKJACK
	three_card_root.visible = current_game == GAME_THREE_CARD
	criss_cross_root.visible = current_game == GAME_CRISS_CROSS
	baccarat_root.visible = current_game == GAME_BACCARAT
	craps_root.visible = current_game == GAME_CRAPS
	roulette_root.visible = current_game == GAME_ROULETTE
	slots_root.visible = current_game == GAME_SLOTS
	_refresh_game_switcher()


func _refresh_game_switcher() -> void:
	if keno_game_button == null or poker_game_button == null or pai_gow_game_button == null or blackjack_game_button == null or three_card_game_button == null or criss_cross_game_button == null or baccarat_game_button == null or craps_game_button == null or roulette_game_button == null or slots_game_button == null:
		return

	keno_game_button.set_pressed_no_signal(current_game == GAME_KENO)
	poker_game_button.set_pressed_no_signal(current_game == GAME_POKER)
	pai_gow_game_button.set_pressed_no_signal(current_game == GAME_PAI_GOW)
	blackjack_game_button.set_pressed_no_signal(current_game == GAME_BLACKJACK)
	three_card_game_button.set_pressed_no_signal(current_game == GAME_THREE_CARD)
	criss_cross_game_button.set_pressed_no_signal(current_game == GAME_CRISS_CROSS)
	baccarat_game_button.set_pressed_no_signal(current_game == GAME_BACCARAT)
	craps_game_button.set_pressed_no_signal(current_game == GAME_CRAPS)
	roulette_game_button.set_pressed_no_signal(current_game == GAME_ROULETTE)
	slots_game_button.set_pressed_no_signal(current_game == GAME_SLOTS)
	_apply_game_tab_style(keno_game_button, current_game == GAME_KENO)
	_apply_game_tab_style(poker_game_button, current_game == GAME_POKER)
	_apply_game_tab_style(pai_gow_game_button, current_game == GAME_PAI_GOW)
	_apply_game_tab_style(blackjack_game_button, current_game == GAME_BLACKJACK)
	_apply_game_tab_style(three_card_game_button, current_game == GAME_THREE_CARD)
	_apply_game_tab_style(criss_cross_game_button, current_game == GAME_CRISS_CROSS)
	_apply_game_tab_style(baccarat_game_button, current_game == GAME_BACCARAT)
	_apply_game_tab_style(craps_game_button, current_game == GAME_CRAPS)
	_apply_game_tab_style(roulette_game_button, current_game == GAME_ROULETTE)
	_apply_game_tab_style(slots_game_button, current_game == GAME_SLOTS)
	_apply_exit_tab_style()


func _on_exit_pressed() -> void:
	if auto_play_timer != null:
		auto_play_timer.stop()
	if auto_play_button != null:
		auto_play_button.set_pressed_no_signal(false)
	_refresh_auto_play_button(false)
	if casino_root != null:
		casino_root.visible = false
	if lobby_root != null:
		lobby_root.visible = true
		_layout_lobby_buttons()


func _quit_casino() -> void:
	if auto_play_timer != null:
		auto_play_timer.stop()
	get_tree().quit()


func _apply_game_tab_style(button: Button, active: bool) -> void:
	var bg := Color("#336b9d") if active else Color("#2a3038")
	var border := Color("#f6f0df") if active else Color("#3b4450")
	button.add_theme_stylebox_override("normal", _button_style(bg, border, 2 if active else 1))
	button.add_theme_stylebox_override("hover", _button_style(bg.lightened(0.1), Color("#f6f0df"), 2))
	button.add_theme_stylebox_override("pressed", _button_style(bg.darkened(0.08), Color("#ffffff"), 3, true))
	button.add_theme_color_override("font_color", Color("#ffffff"))


func _apply_exit_tab_style() -> void:
	if exit_game_button == null:
		return

	_apply_exit_button_style(exit_game_button)


func _apply_exit_button_style(button: Button) -> void:
	var bg := Color("#8f3535")
	button.add_theme_stylebox_override("normal", _button_style(bg, Color("#5c2424"), 1))
	button.add_theme_stylebox_override("hover", _button_style(bg.lightened(0.12), Color("#f6f0df"), 2))
	button.add_theme_stylebox_override("pressed", _button_style(bg.darkened(0.12), Color("#ffffff"), 3, true))
	button.add_theme_color_override("font_color", Color("#ffffff"))


func _transparent_lobby_button_style(hovered: bool, pressed := false) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color("#f5d0672a") if hovered else Color(0, 0, 0, 0)
	style.border_color = Color("#f5d067aa") if hovered else Color(0, 0, 0, 0)
	style.set_border_width_all(3 if hovered else 0)
	style.set_corner_radius_all(8)
	style.shadow_color = Color("#00000000")
	style.content_margin_left = 0
	style.content_margin_right = 0
	style.content_margin_top = 0
	style.content_margin_bottom = 0
	if pressed:
		style.bg_color = Color("#ffffff30")
		style.border_color = Color("#ffffffcc")
	return style


func _transparent_button_style(bg: Color, border: Color, border_width: int, pressed := false) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = bg.darkened(0.08) if pressed else bg
	style.border_color = border
	style.set_border_width_all(border_width)
	style.corner_radius_top_left = 4
	style.corner_radius_top_right = 4
	style.corner_radius_bottom_right = 4
	style.corner_radius_bottom_left = 4
	return style


func _apply_default_panel_sizes() -> void:
	if left_split == null or right_split == null:
		return
	left_split.split_offset = CARD_PANEL_WIDTH
	right_split.split_offset = NUMBER_PANEL_WIDTH


func _on_lock_layout_toggled(locked: bool) -> void:
	if left_split == null or right_split == null:
		return
	var visibility := SplitContainer.DRAGGER_HIDDEN_COLLAPSED if locked else SplitContainer.DRAGGER_VISIBLE
	left_split.dragger_visibility = visibility
	right_split.dragger_visibility = visibility
	lock_layout_button.text = "Unlock Layout" if locked else "Lock Layout"


func _build_keno_group_bar() -> Control:
	var bar := HFlowContainer.new()
	bar.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	bar.add_theme_constant_override("h_separation", 3)
	bar.add_theme_constant_override("v_separation", 2)

	var label := Label.new()
	label.text = "Groups"
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.add_theme_color_override("font_color", Color("#cad1df"))
	bar.add_child(label)

	saved_group_option = OptionButton.new()
	saved_group_option.custom_minimum_size = Vector2(164, 28)
	saved_group_option.tooltip_text = "Choose a saved group of all 20 Keno cards."
	saved_group_option.item_selected.connect(_on_saved_group_selected)
	bar.add_child(saved_group_option)

	var group_name_label := Label.new()
	group_name_label.text = "Name"
	group_name_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	group_name_label.add_theme_color_override("font_color", Color("#cad1df"))
	bar.add_child(group_name_label)

	saved_group_name_edit = LineEdit.new()
	saved_group_name_edit.custom_minimum_size = Vector2(132, 28)
	saved_group_name_edit.placeholder_text = "Group name"
	saved_group_name_edit.tooltip_text = "Name to save with the selected 20-card group."
	saved_group_name_edit.text_submitted.connect(_on_group_name_submitted)
	bar.add_child(saved_group_name_edit)

	var save_group_button := Button.new()
	save_group_button.text = "Save"
	save_group_button.tooltip_text = "Save all 20 cards into the selected group slot with the typed name."
	save_group_button.custom_minimum_size = Vector2(48, 28)
	save_group_button.pressed.connect(_on_save_group_pressed)
	_apply_button_text_depth(save_group_button)
	bar.add_child(save_group_button)

	var load_group_button := Button.new()
	load_group_button.text = "Load"
	load_group_button.tooltip_text = "Load the selected 20-card group."
	load_group_button.custom_minimum_size = Vector2(48, 28)
	load_group_button.pressed.connect(_on_load_group_pressed)
	_apply_button_text_depth(load_group_button)
	bar.add_child(load_group_button)

	var clear_all_cards_button := Button.new()
	clear_all_cards_button.text = "Clear All"
	clear_all_cards_button.tooltip_text = "Clear picks from every Keno card."
	clear_all_cards_button.custom_minimum_size = Vector2(68, 28)
	clear_all_cards_button.pressed.connect(_on_clear_all_cards_button_pressed)
	_apply_button_text_depth(clear_all_cards_button)
	bar.add_child(clear_all_cards_button)

	var delete_group_button := Button.new()
	delete_group_button.text = "Delete"
	delete_group_button.tooltip_text = "Clear the selected saved group."
	delete_group_button.custom_minimum_size = Vector2(56, 28)
	delete_group_button.pressed.connect(_on_delete_group_pressed)
	_apply_button_text_depth(delete_group_button)
	bar.add_child(delete_group_button)

	var runs_label := Label.new()
	runs_label.text = "Runs"
	runs_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	runs_label.add_theme_color_override("font_color", Color("#cad1df"))
	bar.add_child(runs_label)

	batch_run_count_spin = SpinBox.new()
	batch_run_count_spin.min_value = 1.0
	batch_run_count_spin.max_value = float(KENO_MAX_BATCH_RUN_COUNT)
	batch_run_count_spin.step = 100.0
	batch_run_count_spin.value = float(KENO_DEFAULT_BATCH_RUN_COUNT)
	batch_run_count_spin.custom_minimum_size = Vector2(82, 28)
	batch_run_count_spin.tooltip_text = "How many fast background rounds to run and log."
	bar.add_child(batch_run_count_spin)

	run_group_button = Button.new()
	run_group_button.text = "Run"
	run_group_button.tooltip_text = "Run the selected group for the chosen number of fast background rounds and write each round to the Keno CSV log."
	run_group_button.custom_minimum_size = Vector2(46, 28)
	run_group_button.pressed.connect(_on_run_group_1000_pressed)
	_apply_button_text_depth(run_group_button)
	bar.add_child(run_group_button)

	coverage_wheel_option = OptionButton.new()
	coverage_wheel_option.custom_minimum_size = Vector2(170, 28)
	coverage_wheel_option.tooltip_text = "Coverage wheel to build into all 20 cards."
	coverage_wheel_option.add_item("Auto wheel", KENO_WHEEL_AUTO)
	coverage_wheel_option.add_item("3x3 5-spot wheel", KENO_WHEEL_3X3_5)
	coverage_wheel_option.add_item("3x3 4-spot wheel", KENO_WHEEL_3X3_4)
	coverage_wheel_option.add_item("4x4 4-spot wheel", KENO_WHEEL_4X4_4)
	coverage_wheel_option.add_item("4x4 5-spot wheel", KENO_WHEEL_4X4_5)
	coverage_wheel_option.add_item("4x4 mixed 4/5", KENO_WHEEL_4X4_MIXED)
	coverage_wheel_option.item_selected.connect(_on_coverage_wheel_selected)
	bar.add_child(coverage_wheel_option)

	patch_size_option = OptionButton.new()
	patch_size_option.custom_minimum_size = Vector2(112, 28)
	patch_size_option.tooltip_text = "Patch size for the optimizer."
	patch_size_option.add_item("Best 4x4 patch", 4)
	patch_size_option.add_item("Best 3x3 patch", 3)
	patch_size_option.select(1)
	bar.add_child(patch_size_option)

	var optimizer_spots_label := Label.new()
	optimizer_spots_label.text = "Spots"
	optimizer_spots_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	optimizer_spots_label.add_theme_color_override("font_color", Color("#cad1df"))
	bar.add_child(optimizer_spots_label)

	optimizer_pick_count_spin = SpinBox.new()
	optimizer_pick_count_spin.min_value = 1.0
	optimizer_pick_count_spin.max_value = float(MAX_PICKS_PER_CARD)
	optimizer_pick_count_spin.step = 1.0
	optimizer_pick_count_spin.value = float(KENO_DEFAULT_OPTIMIZER_PICK_COUNT)
	optimizer_pick_count_spin.custom_minimum_size = Vector2(52, 28)
	optimizer_pick_count_spin.tooltip_text = "How many spots each optimized card should use."
	bar.add_child(optimizer_pick_count_spin)

	var best_group_button := Button.new()
	best_group_button.text = "Build"
	best_group_button.tooltip_text = "Build the selected coverage wheel in the best current patch, save it as a group, and write a cheat sheet."
	best_group_button.custom_minimum_size = Vector2(56, 28)
	best_group_button.pressed.connect(_on_build_best_group_pressed)
	_apply_button_text_depth(best_group_button)
	bar.add_child(best_group_button)
	_apply_compact_control_text(bar, 11)

	return bar


func _build_card_panel() -> Control:
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(CARD_PANEL_WIDTH, 0)
	panel.add_theme_stylebox_override("panel", _panel_style(Color("#1e2430")))

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 10)
	padding.add_theme_constant_override("margin_top", 10)
	padding.add_theme_constant_override("margin_right", 10)
	padding.add_theme_constant_override("margin_bottom", 10)
	panel.add_child(padding)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 8)
	padding.add_child(layout)

	var header := HBoxContainer.new()
	layout.add_child(header)

	var label := Label.new()
	label.text = "Cards"
	label.add_theme_font_size_override("font_size", 20)
	label.add_theme_color_override("font_color", Color("#f6f0df"))
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	header.add_child(label)

	var clear_card := Button.new()
	clear_card.text = "Clear Card"
	clear_card.pressed.connect(_on_clear_card_pressed)
	header.add_child(clear_card)

	var clear_all := Button.new()
	clear_all.text = "Clear All"
	clear_all.pressed.connect(_on_clear_all_pressed)
	header.add_child(clear_all)

	var pattern_row := HBoxContainer.new()
	pattern_row.add_theme_constant_override("separation", 6)
	layout.add_child(pattern_row)

	saved_pattern_option = OptionButton.new()
	saved_pattern_option.custom_minimum_size = Vector2(190, 34)
	saved_pattern_option.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	saved_pattern_option.tooltip_text = "Choose a saved pick pattern slot."
	pattern_row.add_child(saved_pattern_option)

	var save_pattern_button := Button.new()
	save_pattern_button.text = "Save"
	save_pattern_button.tooltip_text = "Save the selected card's picks into the chosen pattern slot."
	save_pattern_button.custom_minimum_size = Vector2(62, 34)
	save_pattern_button.pressed.connect(_on_save_pattern_pressed)
	_apply_button_text_depth(save_pattern_button)
	pattern_row.add_child(save_pattern_button)

	var use_pattern_button := Button.new()
	use_pattern_button.text = "Use"
	use_pattern_button.tooltip_text = "Load the chosen saved pattern onto the selected card."
	use_pattern_button.custom_minimum_size = Vector2(58, 34)
	use_pattern_button.pressed.connect(_on_use_saved_pattern_pressed)
	_apply_button_text_depth(use_pattern_button)
	pattern_row.add_child(use_pattern_button)

	var delete_pattern_button := Button.new()
	delete_pattern_button.text = "Delete"
	delete_pattern_button.tooltip_text = "Clear the chosen saved pattern slot."
	delete_pattern_button.custom_minimum_size = Vector2(72, 34)
	delete_pattern_button.pressed.connect(_on_delete_saved_pattern_pressed)
	_apply_button_text_depth(delete_pattern_button)
	pattern_row.add_child(delete_pattern_button)
	_refresh_saved_pattern_option()

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	layout.add_child(scroll)

	var grid := GridContainer.new()
	grid.columns = 2
	grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	grid.add_theme_constant_override("h_separation", 8)
	grid.add_theme_constant_override("v_separation", 8)
	scroll.add_child(grid)

	for i in CARD_COUNT:
		var button := Button.new()
		button.custom_minimum_size = CARD_BUTTON_SIZE
		button.toggle_mode = true
		button.pressed.connect(_on_card_pressed.bind(i))
		card_buttons.append(button)
		grid.add_child(button)

	return panel


func _build_number_panel() -> Control:
	var panel := PanelContainer.new()
	panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	panel.add_theme_stylebox_override("panel", _panel_style(Color("#050505")))

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 6)
	padding.add_theme_constant_override("margin_top", 6)
	padding.add_theme_constant_override("margin_right", 6)
	padding.add_theme_constant_override("margin_bottom", 6)
	panel.add_child(padding)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 8)
	padding.add_child(layout)

	keno_board_scroll = ScrollContainer.new()
	keno_board_scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	keno_board_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	keno_board_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	keno_board_scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	keno_board_scroll.resized.connect(_fit_keno_board_to_scroll)
	layout.add_child(keno_board_scroll)

	keno_board_control = Control.new()
	keno_board_control.custom_minimum_size = Vector2(1, 1)
	keno_board_control.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	keno_board_control.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	keno_board_control.clip_contents = true
	keno_board_control.resized.connect(_layout_keno_card_overlays)
	keno_board_scroll.add_child(keno_board_control)

	var board_texture := TextureRect.new()
	board_texture.set_anchors_preset(Control.PRESET_FULL_RECT)
	board_texture.mouse_filter = Control.MOUSE_FILTER_IGNORE
	board_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	board_texture.stretch_mode = TextureRect.STRETCH_SCALE
	if ResourceLoader.exists(KENO_BOARD_IMAGE):
		board_texture.texture = load(KENO_BOARD_IMAGE)
	elif FileAccess.file_exists(KENO_BOARD_IMAGE):
		var board_image: Image = Image.load_from_file(KENO_BOARD_IMAGE)
		if board_image != null and not board_image.is_empty():
			board_texture.texture = ImageTexture.create_from_image(board_image)
	keno_board_control.add_child(board_texture)

	_build_keno_card_overlays()

	for number in range(1, NUMBER_MAX + 1):
		var button := Button.new()
		button.text = str(number)
		button.focus_mode = Control.FOCUS_NONE
		button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		button.tooltip_text = "Pick number %d for the selected card." % number
		button.pressed.connect(_on_number_pressed.bind(number))
		number_buttons[number] = button
		keno_board_control.add_child(button)

	keno_ball_stage = Control.new()
	keno_ball_stage.set_anchors_preset(Control.PRESET_FULL_RECT)
	keno_ball_stage.mouse_filter = Control.MOUSE_FILTER_IGNORE
	keno_ball_stage.z_index = 90
	keno_ball_stage.clip_contents = false
	keno_board_control.add_child(keno_ball_stage)
	call_deferred("_fit_keno_board_to_scroll")
	call_deferred("_layout_keno_card_overlays")

	last_draw_label = Label.new()
	last_draw_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	last_draw_label.add_theme_color_override("font_color", Color("#f6f0df"))
	layout.add_child(last_draw_label)

	result_label = Label.new()
	result_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	result_label.add_theme_color_override("font_color", Color("#cad1df"))
	layout.add_child(result_label)

	return panel


func _build_keno_card_overlays() -> void:
	card_buttons.clear()
	keno_summary_labels.clear()
	keno_board_action_buttons.clear()

	keno_current_value_label = _add_keno_card_label(KENO_CURRENT_VALUE_RECT, 72, Color("#007a76"), HORIZONTAL_ALIGNMENT_CENTER, Color("#000000"))
	keno_pattern_value_label = _add_keno_card_label(KENO_PATTERN_VALUE_RECT, 34, Color("#000000"), HORIZONTAL_ALIGNMENT_CENTER, Color("#fff200"))
	keno_bottom_win_label = _add_keno_card_label(KENO_BOTTOM_WIN_RECT, 58, Color("#000000"), HORIZONTAL_ALIGNMENT_CENTER, Color("#f6f0df"))
	keno_bottom_cards_played_label = _add_keno_card_label(KENO_BOTTOM_CARDS_PLAYED_RECT, 58, Color("#000000"), HORIZONTAL_ALIGNMENT_CENTER, Color("#f6f0df"))
	keno_bottom_bet_label = _add_keno_card_label(KENO_BOTTOM_BET_RECT, 58, Color("#000000"), HORIZONTAL_ALIGNMENT_CENTER, Color("#f6f0df"))
	keno_bottom_credit_label = _add_keno_card_label(KENO_BOTTOM_CREDIT_RECT, 58, Color("#000000"), HORIZONTAL_ALIGNMENT_CENTER, Color("#f6f0df"))

	for i in CARD_COUNT:
		var row := 0 if i < 10 else 1
		var column := i if i < 10 else i - 10
		var button_rect := Rect2(1384.0 + float(column) * 300.0, 82.0 + float(row) * 203.0, 236.0, 136.0)
		var button := Button.new()
		button.text = ""
		button.toggle_mode = true
		button.focus_mode = Control.FOCUS_NONE
		button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		button.tooltip_text = "Select Card %s." % _card_label(i)
		button.pressed.connect(_on_card_pressed.bind(i))
		button.set_meta("keno_reference_rect", button_rect)
		card_buttons.append(button)
		keno_board_control.add_child(button)

	for i in CARD_COUNT:
		var row_y := KENO_SUMMARY_ROW_START_Y + float(i) * KENO_SUMMARY_ROW_STEP_Y
		keno_summary_labels.append({
			"bet": _add_keno_card_label(Rect2(KENO_SUMMARY_BET_X - 70.0, row_y, 140.0, 42.0), 36, Color("#007a76"), HORIZONTAL_ALIGNMENT_CENTER, Color("#000000")),
			"marked": _add_keno_card_label(Rect2(KENO_SUMMARY_MARKED_X - 70.0, row_y, 140.0, 42.0), 36, Color("#007a76"), HORIZONTAL_ALIGNMENT_CENTER, Color("#000000")),
			"hit": _add_keno_card_label(Rect2(KENO_SUMMARY_HIT_X - 70.0, row_y, 140.0, 42.0), 36, Color("#007a76"), HORIZONTAL_ALIGNMENT_CENTER, Color("#000000")),
			"pay": _add_keno_card_label(Rect2(KENO_SUMMARY_PAY_X - 90.0, row_y, 180.0, 42.0), 36, Color("#007a76"), HORIZONTAL_ALIGNMENT_CENTER, Color("#000000")),
		})

	_add_keno_card_action_button(Rect2(95.0, 2400.0, 900.0, 115.0), "Select saved pattern", _on_select_pattern_art_pressed)
	_add_keno_card_action_button(Rect2(110.0, 2594.0, 520.0, 100.0), "Clear the selected card", _on_clear_card_pressed)
	_add_keno_card_action_button(Rect2(760.0, 2594.0, 520.0, 100.0), "Toggle auto play", _on_art_speed_pressed)
	_add_keno_card_action_button(Rect2(1465.0, 2594.0, 560.0, 100.0), "Set the bet to max", _on_art_max_bet_pressed)
	_add_keno_card_action_button(Rect2(2200.0, 2594.0, 540.0, 100.0), "Increase bet", _on_art_bet_pressed)
	_add_keno_card_action_button(Rect2(2945.0, 2594.0, 670.0, 100.0), "Load the selected pattern onto this card", _on_use_saved_pattern_pressed)
	_add_keno_card_action_button(Rect2(3795.0, 2594.0, 500.0, 100.0), "Play round", _on_play_pressed)


func _add_keno_card_label(rect: Rect2, font_size: int, background: Color, alignment: HorizontalAlignment, font_color: Color) -> Label:
	var label := Label.new()
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	label.horizontal_alignment = alignment
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.clip_text = true
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", font_color)
	label.set_meta("keno_reference_rect", rect)
	label.set_meta("keno_reference_font_size", font_size)
	keno_board_control.add_child(label)
	return label


func _add_keno_card_action_button(rect: Rect2, tooltip: String, callback: Callable) -> void:
	var button := Button.new()
	button.text = ""
	button.focus_mode = Control.FOCUS_NONE
	button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	button.tooltip_text = tooltip
	button.pressed.connect(callback)
	button.set_meta("keno_reference_rect", rect)
	button.add_theme_stylebox_override("normal", _transparent_button_style(Color("#f5d06722"), Color("#f5d06700"), 0))
	button.add_theme_stylebox_override("hover", _transparent_button_style(Color("#f5d06722"), Color("#f6f0df"), 3))
	button.add_theme_stylebox_override("pressed", _transparent_button_style(Color("#f5d06733"), Color("#ffffff"), 3, true))
	keno_board_action_buttons.append(button)
	keno_board_control.add_child(button)


func _build_keno_board_overlay_label(alignment: HorizontalAlignment, font_size: int) -> Label:
	var label := Label.new()
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	label.horizontal_alignment = alignment
	label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", Color("#000000"))
	label.add_theme_color_override("font_shadow_color", Color("#b8c21f99"))
	label.add_theme_constant_override("shadow_offset_x", 2)
	label.add_theme_constant_override("shadow_offset_y", 2)
	return label


func _build_stats_panel() -> Control:
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(STATS_PANEL_WIDTH, 0)
	panel.add_theme_stylebox_override("panel", _panel_style(Color("#1d2329")))

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 12)
	padding.add_theme_constant_override("margin_top", 10)
	padding.add_theme_constant_override("margin_right", 12)
	padding.add_theme_constant_override("margin_bottom", 10)
	panel.add_child(padding)

	var scroll := ScrollContainer.new()
	scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	padding.add_child(scroll)

	var layout := VBoxContainer.new()
	layout.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	layout.add_theme_constant_override("separation", 10)
	scroll.add_child(layout)

	var header := Label.new()
	header.text = "Live Game Data"
	header.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	header.add_theme_font_size_override("font_size", 20)
	header.add_theme_color_override("font_color", Color("#f6f0df"))
	layout.add_child(header)

	var reset_grid := GridContainer.new()
	reset_grid.columns = 2
	reset_grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	reset_grid.add_theme_constant_override("h_separation", 6)
	reset_grid.add_theme_constant_override("v_separation", 6)
	layout.add_child(reset_grid)

	reset_grid.add_child(_build_reset_button("Reset All-Time", _on_reset_all_time_pressed))
	reset_grid.add_child(_build_reset_button("Reset Last 100", _on_reset_recent_runs_pressed))
	reset_grid.add_child(_build_reset_button("Reset Hits", _on_reset_number_hits_pressed))
	reset_grid.add_child(_build_reset_button("Reset Card", _on_reset_selected_card_pressed))
	reset_grid.add_child(_build_reset_button("Reset Cards", _on_reset_all_cards_pressed))
	reset_grid.add_child(_build_reset_button("Reset All", _on_reset_all_counters_pressed))

	stats_label = Label.new()
	_configure_stats_wrap_label(stats_label)
	stats_label.add_theme_color_override("font_color", Color("#cad1df"))
	layout.add_child(stats_label)

	hit_tally_label = Label.new()
	_configure_stats_wrap_label(hit_tally_label)
	hit_tally_label.add_theme_color_override("font_color", Color("#c9f3df"))
	layout.add_child(hit_tally_label)

	recent_runs_label = Label.new()
	_configure_stats_wrap_label(recent_runs_label)
	recent_runs_label.add_theme_color_override("font_color", Color("#dfe7f3"))
	layout.add_child(recent_runs_label)

	suggestion_label = Label.new()
	_configure_stats_wrap_label(suggestion_label)
	suggestion_label.add_theme_color_override("font_color", Color("#f5d067"))
	layout.add_child(suggestion_label)

	hot_label = Label.new()
	_configure_stats_wrap_label(hot_label)
	hot_label.add_theme_color_override("font_color", Color("#ffb07a"))
	layout.add_child(hot_label)

	cold_label = Label.new()
	_configure_stats_wrap_label(cold_label)
	cold_label.add_theme_color_override("font_color", Color("#9ad4ff"))
	layout.add_child(cold_label)

	var payout_title := Label.new()
	payout_title.text = "Standard Payout"
	payout_title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	payout_title.add_theme_font_size_override("font_size", 18)
	payout_title.add_theme_color_override("font_color", Color("#f6f0df"))
	layout.add_child(payout_title)

	var payout_text := RichTextLabel.new()
	payout_text.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	payout_text.fit_content = true
	payout_text.bbcode_enabled = true
	payout_text.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	payout_text.text = _format_payout_table()
	payout_text.add_theme_color_override("default_color", Color("#cad1df"))
	layout.add_child(payout_text)

	return panel


func _build_poker_interface() -> void:
	var top_bar := HBoxContainer.new()
	top_bar.add_theme_constant_override("separation", 10)
	poker_root.add_child(top_bar)

	var title := Label.new()
	title.text = "Spin Poker"
	title.add_theme_font_size_override("font_size", 28)
	title.add_theme_color_override("font_color", Color("#f6f0df"))
	title.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_apply_text_depth(title)
	top_bar.add_child(title)

	poker_bankroll_label = Label.new()
	poker_bankroll_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	poker_bankroll_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	poker_bankroll_label.add_theme_font_size_override("font_size", 16)
	poker_bankroll_label.add_theme_color_override("font_color", Color("#cad1df"))
	_apply_text_depth(poker_bankroll_label)
	top_bar.add_child(poker_bankroll_label)

	var bet_label := Label.new()
	bet_label.text = "Bet"
	bet_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	bet_label.add_theme_color_override("font_color", Color("#cad1df"))
	top_bar.add_child(bet_label)

	poker_bet_spin = SpinBox.new()
	poker_bet_spin.min_value = 1.0
	poker_bet_spin.max_value = 100.0
	poker_bet_spin.step = 1.0
	poker_bet_spin.value = 5.0
	poker_bet_spin.custom_minimum_size = Vector2(95, 40)
	top_bar.add_child(poker_bet_spin)

	var hands_label := Label.new()
	hands_label.text = "Lines"
	hands_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	hands_label.add_theme_color_override("font_color", Color("#cad1df"))
	top_bar.add_child(hands_label)

	poker_hand_count_option = OptionButton.new()
	poker_hand_count_option.custom_minimum_size = Vector2(95, 40)
	for count in range(1, SPIN_POKER_LINE_PATTERNS.size() + 1):
		poker_hand_count_option.add_item(str(count), count)
	poker_hand_count_option.item_selected.connect(_on_poker_hand_count_selected)
	top_bar.add_child(poker_hand_count_option)

	var reset_button := Button.new()
	reset_button.text = "Reset Credits"
	reset_button.custom_minimum_size = Vector2(135, 40)
	reset_button.pressed.connect(_on_poker_reset_pressed)
	_apply_button_text_depth(reset_button)
	top_bar.add_child(reset_button)

	poker_root.add_child(_build_poker_table_panel())


func _build_poker_table_panel() -> Control:
	var panel := PanelContainer.new()
	panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	panel.add_theme_stylebox_override("panel", _poker_table_style())

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 16)
	padding.add_theme_constant_override("margin_top", 16)
	padding.add_theme_constant_override("margin_right", 16)
	padding.add_theme_constant_override("margin_bottom", 16)
	panel.add_child(padding)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 8)
	padding.add_child(layout)

	var machine_header := HBoxContainer.new()
	machine_header.add_theme_constant_override("separation", 12)
	layout.add_child(machine_header)

	var game_label := Label.new()
	game_label.text = "JACKS OR BETTER"
	game_label.add_theme_font_size_override("font_size", 22)
	game_label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(game_label)
	machine_header.add_child(game_label)

	poker_status_label = Label.new()
	poker_status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	poker_status_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	poker_status_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	poker_status_label.add_theme_font_size_override("font_size", 16)
	poker_status_label.add_theme_color_override("font_color", Color("#cad1df"))
	_apply_text_depth(poker_status_label)
	machine_header.add_child(poker_status_label)

	var card_scroll := ScrollContainer.new()
	card_scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	card_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	layout.add_child(card_scroll)

	var card_center := CenterContainer.new()
	card_center.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	card_center.size_flags_vertical = Control.SIZE_EXPAND_FILL
	card_scroll.add_child(card_center)

	poker_card_grid = GridContainer.new()
	poker_card_grid.columns = POKER_HAND_SIZE
	poker_card_grid.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	poker_card_grid.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	poker_card_grid.add_theme_constant_override("h_separation", 10)
	poker_card_grid.add_theme_constant_override("v_separation", 8)
	card_center.add_child(poker_card_grid)

	for i in POKER_HAND_SIZE * SPIN_POKER_ROWS:
		var button := Button.new()
		button.custom_minimum_size = POKER_CARD_DISPLAY_SIZE
		button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		button.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		button.expand_icon = true
		button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
		button.vertical_icon_alignment = VERTICAL_ALIGNMENT_CENTER
		button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		button.pressed.connect(_on_poker_card_pressed.bind(i % POKER_HAND_SIZE))
		_apply_button_text_depth(button)
		poker_card_buttons.append(button)
		poker_card_grid.add_child(button)

	var pay_action_row := HBoxContainer.new()
	pay_action_row.add_theme_constant_override("separation", 12)
	layout.add_child(pay_action_row)

	poker_paytable_label = Label.new()
	poker_paytable_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	poker_paytable_label.custom_minimum_size = Vector2(560, 88)
	poker_paytable_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	poker_paytable_label.add_theme_font_size_override("font_size", 13)
	poker_paytable_label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(poker_paytable_label)
	pay_action_row.add_child(poker_paytable_label)

	var action_row := HBoxContainer.new()
	action_row.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	action_row.add_theme_constant_override("separation", 10)
	pay_action_row.add_child(action_row)

	poker_deal_button = Button.new()
	poker_deal_button.text = "DEAL"
	poker_deal_button.custom_minimum_size = Vector2(140, 58)
	poker_deal_button.pressed.connect(_on_poker_deal_pressed)
	poker_deal_button.add_theme_font_size_override("font_size", 20)
	_apply_button_text_depth(poker_deal_button)
	action_row.add_child(poker_deal_button)

	poker_draw_button = Button.new()
	poker_draw_button.text = "SPIN"
	poker_draw_button.custom_minimum_size = Vector2(140, 58)
	poker_draw_button.pressed.connect(_on_poker_draw_pressed)
	poker_draw_button.add_theme_font_size_override("font_size", 20)
	_apply_button_text_depth(poker_draw_button)
	action_row.add_child(poker_draw_button)

	poker_tip_label = Label.new()
	poker_tip_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	poker_tip_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	poker_tip_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	poker_tip_label.add_theme_font_size_override("font_size", 18)
	poker_tip_label.add_theme_color_override("font_color", Color("#c9f3df"))
	_apply_text_depth(poker_tip_label)
	layout.add_child(poker_tip_label)

	poker_result_label = Label.new()
	poker_result_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	poker_result_label.size_flags_vertical = Control.SIZE_SHRINK_END
	poker_result_label.add_theme_font_size_override("font_size", 18)
	poker_result_label.add_theme_color_override("font_color", Color("#f5d067"))
	_apply_text_depth(poker_result_label)
	layout.add_child(poker_result_label)

	return panel


func _build_poker_stats_panel() -> Control:
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(410, 0)
	panel.add_theme_stylebox_override("panel", _panel_style(Color("#20242a")))

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 12)
	padding.add_theme_constant_override("margin_top", 12)
	padding.add_theme_constant_override("margin_right", 12)
	padding.add_theme_constant_override("margin_bottom", 12)
	panel.add_child(padding)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 10)
	padding.add_child(layout)

	var title := Label.new()
	title.text = "Jacks or Better"
	title.add_theme_font_size_override("font_size", 20)
	title.add_theme_color_override("font_color", Color("#f6f0df"))
	layout.add_child(title)

	poker_paytable_label = Label.new()
	poker_paytable_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	poker_paytable_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	poker_paytable_label.add_theme_color_override("font_color", Color("#cad1df"))
	layout.add_child(poker_paytable_label)

	return panel


func _build_pai_gow_interface() -> void:
	var top_bar := HBoxContainer.new()
	top_bar.add_theme_constant_override("separation", 10)
	pai_gow_root.add_child(top_bar)

	var title := Label.new()
	title.text = "Pai Gow Poker"
	title.add_theme_font_size_override("font_size", 28)
	title.add_theme_color_override("font_color", Color("#f6f0df"))
	title.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_apply_text_depth(title)
	top_bar.add_child(title)

	pai_gow_bankroll_label = Label.new()
	pai_gow_bankroll_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	pai_gow_bankroll_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	pai_gow_bankroll_label.add_theme_font_size_override("font_size", 16)
	pai_gow_bankroll_label.add_theme_color_override("font_color", Color("#cad1df"))
	_apply_text_depth(pai_gow_bankroll_label)
	top_bar.add_child(pai_gow_bankroll_label)

	var bet_label := Label.new()
	bet_label.text = "Bet"
	bet_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	bet_label.add_theme_color_override("font_color", Color("#cad1df"))
	top_bar.add_child(bet_label)

	pai_gow_bet_spin = SpinBox.new()
	pai_gow_bet_spin.min_value = 1.0
	pai_gow_bet_spin.max_value = 100.0
	pai_gow_bet_spin.step = 1.0
	pai_gow_bet_spin.value = 10.0
	pai_gow_bet_spin.custom_minimum_size = Vector2(95, 40)
	top_bar.add_child(pai_gow_bet_spin)

	var reset_button := Button.new()
	reset_button.text = "Reset Credits"
	reset_button.custom_minimum_size = Vector2(135, 40)
	reset_button.pressed.connect(_on_pai_gow_reset_pressed)
	_apply_button_text_depth(reset_button)
	top_bar.add_child(reset_button)

	var body := HSplitContainer.new()
	body.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	body.size_flags_vertical = Control.SIZE_EXPAND_FILL
	body.dragger_visibility = SplitContainer.DRAGGER_VISIBLE
	pai_gow_root.add_child(body)

	body.add_child(_build_pai_gow_table_panel())
	body.add_child(_build_pai_gow_info_panel())


func _build_pai_gow_table_panel() -> Control:
	var panel := PanelContainer.new()
	panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	panel.add_theme_stylebox_override("panel", _poker_table_style())

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 16)
	padding.add_theme_constant_override("margin_top", 16)
	padding.add_theme_constant_override("margin_right", 16)
	padding.add_theme_constant_override("margin_bottom", 16)
	panel.add_child(padding)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 12)
	padding.add_child(layout)

	pai_gow_status_label = Label.new()
	pai_gow_status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	pai_gow_status_label.add_theme_font_size_override("font_size", 18)
	pai_gow_status_label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(pai_gow_status_label)
	layout.add_child(pai_gow_status_label)

	pai_gow_selection_row = HBoxContainer.new()
	pai_gow_selection_row.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	pai_gow_selection_row.add_theme_constant_override("separation", 10)
	layout.add_child(pai_gow_selection_row)

	var action_row := HBoxContainer.new()
	action_row.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	action_row.add_theme_constant_override("separation", 16)
	layout.add_child(action_row)

	pai_gow_deal_button = Button.new()
	pai_gow_deal_button.text = "Deal"
	pai_gow_deal_button.custom_minimum_size = Vector2(150, 58)
	pai_gow_deal_button.pressed.connect(_on_pai_gow_deal_pressed)
	pai_gow_deal_button.add_theme_font_size_override("font_size", 22)
	_apply_button_text_depth(pai_gow_deal_button)
	action_row.add_child(pai_gow_deal_button)

	pai_gow_house_way_button = Button.new()
	pai_gow_house_way_button.text = "House Way"
	pai_gow_house_way_button.custom_minimum_size = Vector2(170, 58)
	pai_gow_house_way_button.pressed.connect(_on_pai_gow_house_way_pressed)
	pai_gow_house_way_button.add_theme_font_size_override("font_size", 22)
	_apply_button_text_depth(pai_gow_house_way_button)
	action_row.add_child(pai_gow_house_way_button)

	pai_gow_set_button = Button.new()
	pai_gow_set_button.text = "Set Hands"
	pai_gow_set_button.custom_minimum_size = Vector2(170, 58)
	pai_gow_set_button.pressed.connect(_on_pai_gow_set_pressed)
	pai_gow_set_button.add_theme_font_size_override("font_size", 22)
	_apply_button_text_depth(pai_gow_set_button)
	action_row.add_child(pai_gow_set_button)

	pai_gow_tip_label = Label.new()
	pai_gow_tip_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	pai_gow_tip_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	pai_gow_tip_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	pai_gow_tip_label.add_theme_font_size_override("font_size", 22)
	pai_gow_tip_label.add_theme_color_override("font_color", Color("#c9f3df"))
	_apply_text_depth(pai_gow_tip_label)
	layout.add_child(pai_gow_tip_label)

	var split_grid := GridContainer.new()
	split_grid.columns = 2
	split_grid.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	split_grid.add_theme_constant_override("h_separation", 30)
	split_grid.add_theme_constant_override("v_separation", 10)
	layout.add_child(split_grid)

	var player_box := VBoxContainer.new()
	player_box.add_theme_constant_override("separation", 8)
	split_grid.add_child(player_box)

	pai_gow_player_low_label = Label.new()
	pai_gow_player_low_label.add_theme_font_size_override("font_size", 20)
	pai_gow_player_low_label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(pai_gow_player_low_label)
	player_box.add_child(pai_gow_player_low_label)

	pai_gow_player_low_row = HBoxContainer.new()
	pai_gow_player_low_row.add_theme_constant_override("separation", 8)
	player_box.add_child(pai_gow_player_low_row)

	pai_gow_player_high_label = Label.new()
	pai_gow_player_high_label.add_theme_font_size_override("font_size", 20)
	pai_gow_player_high_label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(pai_gow_player_high_label)
	player_box.add_child(pai_gow_player_high_label)

	pai_gow_player_high_row = HBoxContainer.new()
	pai_gow_player_high_row.add_theme_constant_override("separation", 8)
	player_box.add_child(pai_gow_player_high_row)

	var dealer_box := VBoxContainer.new()
	dealer_box.add_theme_constant_override("separation", 8)
	split_grid.add_child(dealer_box)

	pai_gow_dealer_low_label = Label.new()
	pai_gow_dealer_low_label.add_theme_font_size_override("font_size", 20)
	pai_gow_dealer_low_label.add_theme_color_override("font_color", Color("#ff7070"))
	_apply_text_depth(pai_gow_dealer_low_label)
	dealer_box.add_child(pai_gow_dealer_low_label)

	pai_gow_dealer_low_row = HBoxContainer.new()
	pai_gow_dealer_low_row.add_theme_constant_override("separation", 8)
	dealer_box.add_child(pai_gow_dealer_low_row)

	pai_gow_dealer_high_label = Label.new()
	pai_gow_dealer_high_label.add_theme_font_size_override("font_size", 20)
	pai_gow_dealer_high_label.add_theme_color_override("font_color", Color("#ff7070"))
	_apply_text_depth(pai_gow_dealer_high_label)
	dealer_box.add_child(pai_gow_dealer_high_label)

	pai_gow_dealer_high_row = HBoxContainer.new()
	pai_gow_dealer_high_row.add_theme_constant_override("separation", 8)
	dealer_box.add_child(pai_gow_dealer_high_row)

	pai_gow_result_label = Label.new()
	pai_gow_result_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	pai_gow_result_label.add_theme_font_size_override("font_size", 20)
	pai_gow_result_label.add_theme_color_override("font_color", Color("#f5d067"))
	_apply_text_depth(pai_gow_result_label)
	layout.add_child(pai_gow_result_label)

	return panel


func _build_pai_gow_info_panel() -> Control:
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(430, 0)
	panel.add_theme_stylebox_override("panel", _panel_style(Color("#20242a")))

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 12)
	padding.add_theme_constant_override("margin_top", 12)
	padding.add_theme_constant_override("margin_right", 12)
	padding.add_theme_constant_override("margin_bottom", 12)
	panel.add_child(padding)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 10)
	padding.add_child(layout)

	var title := Label.new()
	title.text = "Pai Gow Poker"
	title.add_theme_font_size_override("font_size", 20)
	title.add_theme_color_override("font_color", Color("#f6f0df"))
	layout.add_child(title)

	var info := Label.new()
	info.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	info.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	info.add_theme_color_override("font_color", Color("#cad1df"))
	info.text = "Set seven cards into a two-card Low hand and a five-card High hand.\n\nClick exactly two cards for Low. The remaining five become High. High must outrank Low or the hand is fouled.\n\nBoth hands beat the dealer: win 1:1.\nOne wins and one loses: push.\nDealer copies win for the dealer.\n\nThis table uses a 52-card deck and no commission."
	layout.add_child(info)

	return panel


func _build_blackjack_interface() -> void:
	var top_bar := HBoxContainer.new()
	top_bar.add_theme_constant_override("separation", 10)
	blackjack_root.add_child(top_bar)

	var title := Label.new()
	title.text = "Blackjack"
	title.add_theme_font_size_override("font_size", 28)
	title.add_theme_color_override("font_color", Color("#f6f0df"))
	title.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_apply_text_depth(title)
	top_bar.add_child(title)

	blackjack_bankroll_label = Label.new()
	blackjack_bankroll_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	blackjack_bankroll_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	blackjack_bankroll_label.add_theme_font_size_override("font_size", 16)
	blackjack_bankroll_label.add_theme_color_override("font_color", Color("#cad1df"))
	_apply_text_depth(blackjack_bankroll_label)
	top_bar.add_child(blackjack_bankroll_label)

	var bet_label := Label.new()
	bet_label.text = "Bet"
	bet_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	bet_label.add_theme_color_override("font_color", Color("#cad1df"))
	top_bar.add_child(bet_label)

	blackjack_bet_spin = SpinBox.new()
	blackjack_bet_spin.min_value = 1.0
	blackjack_bet_spin.max_value = 100.0
	blackjack_bet_spin.step = 1.0
	blackjack_bet_spin.value = 5.0
	blackjack_bet_spin.custom_minimum_size = Vector2(95, 40)
	top_bar.add_child(blackjack_bet_spin)

	var reset_button := Button.new()
	reset_button.text = "Reset Credits"
	reset_button.custom_minimum_size = Vector2(135, 40)
	reset_button.pressed.connect(_on_blackjack_reset_pressed)
	_apply_button_text_depth(reset_button)
	top_bar.add_child(reset_button)

	var body := HSplitContainer.new()
	body.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	body.size_flags_vertical = Control.SIZE_EXPAND_FILL
	body.dragger_visibility = SplitContainer.DRAGGER_VISIBLE
	blackjack_root.add_child(body)

	body.add_child(_build_blackjack_table_panel())
	body.add_child(_build_blackjack_info_panel())


func _build_blackjack_table_panel() -> Control:
	var panel := PanelContainer.new()
	panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	panel.add_theme_stylebox_override("panel", _poker_table_style())

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 16)
	padding.add_theme_constant_override("margin_top", 16)
	padding.add_theme_constant_override("margin_right", 16)
	padding.add_theme_constant_override("margin_bottom", 16)
	panel.add_child(padding)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 14)
	padding.add_child(layout)

	blackjack_status_label = Label.new()
	blackjack_status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	blackjack_status_label.add_theme_font_size_override("font_size", 18)
	blackjack_status_label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(blackjack_status_label)
	layout.add_child(blackjack_status_label)

	blackjack_dealer_total_label = Label.new()
	blackjack_dealer_total_label.add_theme_font_size_override("font_size", 20)
	blackjack_dealer_total_label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(blackjack_dealer_total_label)
	layout.add_child(blackjack_dealer_total_label)

	blackjack_dealer_row = HBoxContainer.new()
	blackjack_dealer_row.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	blackjack_dealer_row.add_theme_constant_override("separation", 14)
	layout.add_child(blackjack_dealer_row)

	blackjack_player_total_label = Label.new()
	blackjack_player_total_label.add_theme_font_size_override("font_size", 20)
	blackjack_player_total_label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(blackjack_player_total_label)
	layout.add_child(blackjack_player_total_label)

	blackjack_player_row = HBoxContainer.new()
	blackjack_player_row.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	blackjack_player_row.add_theme_constant_override("separation", 14)
	layout.add_child(blackjack_player_row)

	var action_row := HBoxContainer.new()
	action_row.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	action_row.add_theme_constant_override("separation", 16)
	layout.add_child(action_row)

	blackjack_deal_button = Button.new()
	blackjack_deal_button.text = "Deal"
	blackjack_deal_button.custom_minimum_size = Vector2(170, 58)
	blackjack_deal_button.pressed.connect(_on_blackjack_deal_pressed)
	blackjack_deal_button.add_theme_font_size_override("font_size", 22)
	_apply_button_text_depth(blackjack_deal_button)
	action_row.add_child(blackjack_deal_button)

	blackjack_hit_button = Button.new()
	blackjack_hit_button.text = "Hit"
	blackjack_hit_button.custom_minimum_size = Vector2(150, 58)
	blackjack_hit_button.pressed.connect(_on_blackjack_hit_pressed)
	blackjack_hit_button.add_theme_font_size_override("font_size", 22)
	_apply_button_text_depth(blackjack_hit_button)
	action_row.add_child(blackjack_hit_button)

	blackjack_stand_button = Button.new()
	blackjack_stand_button.text = "Stand"
	blackjack_stand_button.custom_minimum_size = Vector2(150, 58)
	blackjack_stand_button.pressed.connect(_on_blackjack_stand_pressed)
	blackjack_stand_button.add_theme_font_size_override("font_size", 22)
	_apply_button_text_depth(blackjack_stand_button)
	action_row.add_child(blackjack_stand_button)

	blackjack_tip_label = Label.new()
	blackjack_tip_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	blackjack_tip_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	blackjack_tip_label.add_theme_font_size_override("font_size", 24)
	blackjack_tip_label.add_theme_color_override("font_color", Color("#c9f3df"))
	_apply_text_depth(blackjack_tip_label)
	layout.add_child(blackjack_tip_label)

	blackjack_result_label = Label.new()
	blackjack_result_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	blackjack_result_label.add_theme_font_size_override("font_size", 20)
	blackjack_result_label.add_theme_color_override("font_color", Color("#f5d067"))
	_apply_text_depth(blackjack_result_label)
	layout.add_child(blackjack_result_label)

	return panel


func _build_blackjack_info_panel() -> Control:
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(410, 0)
	panel.add_theme_stylebox_override("panel", _panel_style(Color("#20242a")))

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 12)
	padding.add_theme_constant_override("margin_top", 12)
	padding.add_theme_constant_override("margin_right", 12)
	padding.add_theme_constant_override("margin_bottom", 12)
	panel.add_child(padding)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 10)
	padding.add_child(layout)

	var title := Label.new()
	title.text = "Blackjack"
	title.add_theme_font_size_override("font_size", 20)
	title.add_theme_color_override("font_color", Color("#f6f0df"))
	layout.add_child(title)

	var info := Label.new()
	info.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	info.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	info.add_theme_color_override("font_color", Color("#cad1df"))
	info.text = "Goal: beat the dealer without going over 21.\n\nDealer stands on 17.\nBlackjack pays 3:2.\nWin pays 1:1.\nPush returns your bet.\n\nTips use simple basic strategy for Hit or Stand."
	layout.add_child(info)

	return panel


func _build_three_card_interface() -> void:
	var top_bar := HBoxContainer.new()
	top_bar.add_theme_constant_override("separation", 10)
	three_card_root.add_child(top_bar)

	var title := Label.new()
	title.text = "3 Card Poker"
	title.add_theme_font_size_override("font_size", 28)
	title.add_theme_color_override("font_color", Color("#f6f0df"))
	title.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_apply_text_depth(title)
	top_bar.add_child(title)

	three_card_bankroll_label = Label.new()
	three_card_bankroll_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	three_card_bankroll_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	three_card_bankroll_label.add_theme_font_size_override("font_size", 16)
	three_card_bankroll_label.add_theme_color_override("font_color", Color("#cad1df"))
	_apply_text_depth(three_card_bankroll_label)
	top_bar.add_child(three_card_bankroll_label)

	var ante_label := Label.new()
	ante_label.text = "Ante"
	ante_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	ante_label.add_theme_color_override("font_color", Color("#cad1df"))
	top_bar.add_child(ante_label)

	three_card_ante_spin = SpinBox.new()
	three_card_ante_spin.min_value = 1.0
	three_card_ante_spin.max_value = 100.0
	three_card_ante_spin.step = 1.0
	three_card_ante_spin.value = 5.0
	three_card_ante_spin.custom_minimum_size = Vector2(95, 40)
	top_bar.add_child(three_card_ante_spin)

	var pair_label := Label.new()
	pair_label.text = "Pair Plus"
	pair_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	pair_label.add_theme_color_override("font_color", Color("#cad1df"))
	top_bar.add_child(pair_label)

	three_card_pair_plus_spin = SpinBox.new()
	three_card_pair_plus_spin.min_value = 0.0
	three_card_pair_plus_spin.max_value = 100.0
	three_card_pair_plus_spin.step = 1.0
	three_card_pair_plus_spin.value = 1.0
	three_card_pair_plus_spin.custom_minimum_size = Vector2(95, 40)
	top_bar.add_child(three_card_pair_plus_spin)

	var reset_button := Button.new()
	reset_button.text = "Reset Credits"
	reset_button.custom_minimum_size = Vector2(135, 40)
	reset_button.pressed.connect(_on_three_card_reset_pressed)
	_apply_button_text_depth(reset_button)
	top_bar.add_child(reset_button)

	var body := HSplitContainer.new()
	body.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	body.size_flags_vertical = Control.SIZE_EXPAND_FILL
	body.dragger_visibility = SplitContainer.DRAGGER_VISIBLE
	three_card_root.add_child(body)

	body.add_child(_build_three_card_table_panel())
	body.add_child(_build_three_card_info_panel())


func _build_three_card_table_panel() -> Control:
	var panel := PanelContainer.new()
	panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	panel.add_theme_stylebox_override("panel", _poker_table_style())

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 16)
	padding.add_theme_constant_override("margin_top", 16)
	padding.add_theme_constant_override("margin_right", 16)
	padding.add_theme_constant_override("margin_bottom", 16)
	panel.add_child(padding)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 14)
	padding.add_child(layout)

	three_card_status_label = Label.new()
	three_card_status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	three_card_status_label.add_theme_font_size_override("font_size", 18)
	three_card_status_label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(three_card_status_label)
	layout.add_child(three_card_status_label)

	three_card_dealer_label = Label.new()
	three_card_dealer_label.add_theme_font_size_override("font_size", 20)
	three_card_dealer_label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(three_card_dealer_label)
	layout.add_child(three_card_dealer_label)

	three_card_dealer_row = HBoxContainer.new()
	three_card_dealer_row.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	three_card_dealer_row.add_theme_constant_override("separation", 14)
	layout.add_child(three_card_dealer_row)

	three_card_player_label = Label.new()
	three_card_player_label.add_theme_font_size_override("font_size", 20)
	three_card_player_label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(three_card_player_label)
	layout.add_child(three_card_player_label)

	three_card_player_row = HBoxContainer.new()
	three_card_player_row.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	three_card_player_row.add_theme_constant_override("separation", 14)
	layout.add_child(three_card_player_row)

	var action_row := HBoxContainer.new()
	action_row.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	action_row.add_theme_constant_override("separation", 16)
	layout.add_child(action_row)

	three_card_deal_button = Button.new()
	three_card_deal_button.text = "Deal"
	three_card_deal_button.custom_minimum_size = Vector2(170, 58)
	three_card_deal_button.pressed.connect(_on_three_card_deal_pressed)
	three_card_deal_button.add_theme_font_size_override("font_size", 22)
	_apply_button_text_depth(three_card_deal_button)
	action_row.add_child(three_card_deal_button)

	three_card_play_button = Button.new()
	three_card_play_button.text = "Play"
	three_card_play_button.custom_minimum_size = Vector2(150, 58)
	three_card_play_button.pressed.connect(_on_three_card_play_pressed)
	three_card_play_button.add_theme_font_size_override("font_size", 22)
	_apply_button_text_depth(three_card_play_button)
	action_row.add_child(three_card_play_button)

	three_card_fold_button = Button.new()
	three_card_fold_button.text = "Fold"
	three_card_fold_button.custom_minimum_size = Vector2(150, 58)
	three_card_fold_button.pressed.connect(_on_three_card_fold_pressed)
	three_card_fold_button.add_theme_font_size_override("font_size", 22)
	_apply_button_text_depth(three_card_fold_button)
	action_row.add_child(three_card_fold_button)

	three_card_tip_label = Label.new()
	three_card_tip_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	three_card_tip_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	three_card_tip_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	three_card_tip_label.add_theme_font_size_override("font_size", 24)
	three_card_tip_label.add_theme_color_override("font_color", Color("#c9f3df"))
	_apply_text_depth(three_card_tip_label)
	layout.add_child(three_card_tip_label)

	three_card_result_label = Label.new()
	three_card_result_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	three_card_result_label.add_theme_font_size_override("font_size", 20)
	three_card_result_label.add_theme_color_override("font_color", Color("#f5d067"))
	_apply_text_depth(three_card_result_label)
	layout.add_child(three_card_result_label)

	return panel


func _build_three_card_info_panel() -> Control:
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(430, 0)
	panel.add_theme_stylebox_override("panel", _panel_style(Color("#20242a")))

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 12)
	padding.add_theme_constant_override("margin_top", 12)
	padding.add_theme_constant_override("margin_right", 12)
	padding.add_theme_constant_override("margin_bottom", 12)
	panel.add_child(padding)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 10)
	padding.add_child(layout)

	var title := Label.new()
	title.text = "3 Card Poker"
	title.add_theme_font_size_override("font_size", 20)
	title.add_theme_color_override("font_color", Color("#f6f0df"))
	layout.add_child(title)

	var info := Label.new()
	info.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	info.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	info.add_theme_color_override("font_color", Color("#cad1df"))
	info.text = "Ante: deal 3 cards, then Play with another Ante-sized bet or Fold.\n\nDealer qualifies with Queen-high or better.\n\nPair Plus pays on your hand only:\nStraight Flush 40:1\nThree of a Kind 30:1\nStraight 6:1\nFlush 3:1\nPair 1:1\n\nAnte bonus:\nStraight Flush 5:1\nThree of a Kind 4:1\nStraight 1:1"
	layout.add_child(info)

	return panel


func _build_criss_cross_interface() -> void:
	var top_bar := HBoxContainer.new()
	top_bar.add_theme_constant_override("separation", 10)
	criss_cross_root.add_child(top_bar)

	var title := Label.new()
	title.text = "Criss Cross Poker"
	title.add_theme_font_size_override("font_size", 28)
	title.add_theme_color_override("font_color", Color("#f6f0df"))
	title.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_apply_text_depth(title)
	top_bar.add_child(title)

	criss_cross_bankroll_label = Label.new()
	criss_cross_bankroll_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	criss_cross_bankroll_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	criss_cross_bankroll_label.add_theme_font_size_override("font_size", 16)
	criss_cross_bankroll_label.add_theme_color_override("font_color", Color("#cad1df"))
	_apply_text_depth(criss_cross_bankroll_label)
	top_bar.add_child(criss_cross_bankroll_label)

	var ante_label := Label.new()
	ante_label.text = "Ante"
	ante_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	ante_label.add_theme_color_override("font_color", Color("#cad1df"))
	top_bar.add_child(ante_label)

	criss_cross_ante_spin = SpinBox.new()
	criss_cross_ante_spin.min_value = 1.0
	criss_cross_ante_spin.max_value = 100.0
	criss_cross_ante_spin.step = 1.0
	criss_cross_ante_spin.value = 5.0
	criss_cross_ante_spin.custom_minimum_size = Vector2(95, 40)
	top_bar.add_child(criss_cross_ante_spin)

	var bonus_label := Label.new()
	bonus_label.text = "5-Card Bonus"
	bonus_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	bonus_label.add_theme_color_override("font_color", Color("#cad1df"))
	top_bar.add_child(bonus_label)

	criss_cross_bonus_spin = SpinBox.new()
	criss_cross_bonus_spin.min_value = 0.0
	criss_cross_bonus_spin.max_value = 100.0
	criss_cross_bonus_spin.step = 1.0
	criss_cross_bonus_spin.value = 1.0
	criss_cross_bonus_spin.custom_minimum_size = Vector2(95, 40)
	top_bar.add_child(criss_cross_bonus_spin)

	var reset_button := Button.new()
	reset_button.text = "Reset Credits"
	reset_button.custom_minimum_size = Vector2(135, 40)
	reset_button.pressed.connect(_on_criss_cross_reset_pressed)
	_apply_button_text_depth(reset_button)
	top_bar.add_child(reset_button)

	var body := HSplitContainer.new()
	body.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	body.size_flags_vertical = Control.SIZE_EXPAND_FILL
	body.dragger_visibility = SplitContainer.DRAGGER_VISIBLE
	criss_cross_root.add_child(body)

	body.add_child(_build_criss_cross_table_panel())
	body.add_child(_build_criss_cross_info_panel())


func _build_criss_cross_table_panel() -> Control:
	var panel := PanelContainer.new()
	panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	panel.add_theme_stylebox_override("panel", _poker_table_style())

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 16)
	padding.add_theme_constant_override("margin_top", 16)
	padding.add_theme_constant_override("margin_right", 16)
	padding.add_theme_constant_override("margin_bottom", 16)
	panel.add_child(padding)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 12)
	padding.add_child(layout)

	criss_cross_status_label = Label.new()
	criss_cross_status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	criss_cross_status_label.add_theme_font_size_override("font_size", 18)
	criss_cross_status_label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(criss_cross_status_label)
	layout.add_child(criss_cross_status_label)

	var rows := HBoxContainer.new()
	rows.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	rows.add_theme_constant_override("separation", 34)
	layout.add_child(rows)

	var player_box := VBoxContainer.new()
	player_box.add_theme_constant_override("separation", 8)
	rows.add_child(player_box)

	var player_label := Label.new()
	player_label.text = "Your Cards"
	player_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	player_label.add_theme_font_size_override("font_size", 20)
	player_label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(player_label)
	player_box.add_child(player_label)

	criss_cross_player_row = HBoxContainer.new()
	criss_cross_player_row.add_theme_constant_override("separation", 10)
	player_box.add_child(criss_cross_player_row)

	var community_box := VBoxContainer.new()
	community_box.add_theme_constant_override("separation", 8)
	rows.add_child(community_box)

	var community_label := Label.new()
	community_label.text = "Community Cross"
	community_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	community_label.add_theme_font_size_override("font_size", 20)
	community_label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(community_label)
	community_box.add_child(community_label)

	criss_cross_community_grid = GridContainer.new()
	criss_cross_community_grid.columns = 3
	criss_cross_community_grid.add_theme_constant_override("h_separation", 10)
	criss_cross_community_grid.add_theme_constant_override("v_separation", 8)
	community_box.add_child(criss_cross_community_grid)

	var action_row := HBoxContainer.new()
	action_row.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	action_row.add_theme_constant_override("separation", 10)
	layout.add_child(action_row)

	criss_cross_deal_button = Button.new()
	criss_cross_deal_button.text = "Deal"
	criss_cross_deal_button.custom_minimum_size = Vector2(130, 54)
	criss_cross_deal_button.pressed.connect(_on_criss_cross_deal_pressed)
	criss_cross_deal_button.add_theme_font_size_override("font_size", 20)
	_apply_button_text_depth(criss_cross_deal_button)
	action_row.add_child(criss_cross_deal_button)

	criss_cross_across_mult_spin = _build_criss_cross_mult_spin()
	action_row.add_child(criss_cross_across_mult_spin)
	criss_cross_across_button = _build_criss_cross_action_button("Across Bet", _on_criss_cross_across_pressed)
	action_row.add_child(criss_cross_across_button)

	criss_cross_down_mult_spin = _build_criss_cross_mult_spin()
	action_row.add_child(criss_cross_down_mult_spin)
	criss_cross_down_button = _build_criss_cross_action_button("Down Bet", _on_criss_cross_down_pressed)
	action_row.add_child(criss_cross_down_button)

	criss_cross_middle_mult_spin = _build_criss_cross_mult_spin()
	action_row.add_child(criss_cross_middle_mult_spin)
	criss_cross_middle_button = _build_criss_cross_action_button("Middle Bet", _on_criss_cross_middle_pressed)
	action_row.add_child(criss_cross_middle_button)

	criss_cross_fold_button = Button.new()
	criss_cross_fold_button.text = "Fold"
	criss_cross_fold_button.custom_minimum_size = Vector2(105, 54)
	criss_cross_fold_button.pressed.connect(_on_criss_cross_fold_pressed)
	criss_cross_fold_button.add_theme_font_size_override("font_size", 20)
	_apply_button_text_depth(criss_cross_fold_button)
	action_row.add_child(criss_cross_fold_button)

	var hand_grid := GridContainer.new()
	hand_grid.columns = 3
	hand_grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hand_grid.add_theme_constant_override("h_separation", 12)
	layout.add_child(hand_grid)

	criss_cross_across_label = _build_criss_cross_hand_summary_label()
	hand_grid.add_child(criss_cross_across_label)
	criss_cross_down_label = _build_criss_cross_hand_summary_label()
	hand_grid.add_child(criss_cross_down_label)
	criss_cross_bonus_label = _build_criss_cross_hand_summary_label()
	hand_grid.add_child(criss_cross_bonus_label)

	criss_cross_tip_label = Label.new()
	criss_cross_tip_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	criss_cross_tip_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	criss_cross_tip_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	criss_cross_tip_label.add_theme_font_size_override("font_size", 22)
	criss_cross_tip_label.add_theme_color_override("font_color", Color("#c9f3df"))
	_apply_text_depth(criss_cross_tip_label)
	layout.add_child(criss_cross_tip_label)

	criss_cross_result_label = Label.new()
	criss_cross_result_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	criss_cross_result_label.add_theme_font_size_override("font_size", 20)
	criss_cross_result_label.add_theme_color_override("font_color", Color("#f5d067"))
	_apply_text_depth(criss_cross_result_label)
	layout.add_child(criss_cross_result_label)

	return panel


func _build_criss_cross_info_panel() -> Control:
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(430, 0)
	panel.add_theme_stylebox_override("panel", _panel_style(Color("#20242a")))

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 12)
	padding.add_theme_constant_override("margin_top", 12)
	padding.add_theme_constant_override("margin_right", 12)
	padding.add_theme_constant_override("margin_bottom", 12)
	panel.add_child(padding)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 10)
	padding.add_child(layout)

	var title := Label.new()
	title.text = "Criss Cross Poker"
	title.add_theme_font_size_override("font_size", 20)
	title.add_theme_color_override("font_color", Color("#f6f0df"))
	layout.add_child(title)

	var info := Label.new()
	info.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	info.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	info.add_theme_color_override("font_color", Color("#cad1df"))
	info.text = "Make equal Ante Across and Ante Down bets, with an optional 5-Card Bonus.\n\nAfter your two cards, choose 1x-3x Across, then 1x-3x Down, then 1x-3x Middle as the cross is revealed.\n\nAcross and Down use your two cards plus the horizontal or vertical three-card line. Middle pays from the better qualifying hand.\n\nMain paytable:\nRoyal 500:1\nStraight Flush 100:1\nFour of a Kind 40:1\nFull House 12:1\nFlush 8:1\nStraight 5:1\nThree of a Kind 3:1\nTwo Pair 2:1\nJacks or Better 1:1\nPair 6s-10s push\n\n5-Card Bonus:\nRoyal 250:1\nStraight Flush 100:1\nFour of a Kind 40:1\nFull House 15:1\nFlush 10:1\nStraight 6:1\nThree of a Kind 4:1\nTwo Pair 3:1\nSixes or Better 1:1"
	layout.add_child(info)

	return panel


func _build_criss_cross_mult_spin() -> SpinBox:
	var spin := SpinBox.new()
	spin.min_value = 1.0
	spin.max_value = 3.0
	spin.step = 1.0
	spin.value = 1.0
	spin.custom_minimum_size = Vector2(64, 40)
	spin.tooltip_text = "Raise multiple: 1x to 3x the ante."
	return spin


func _build_criss_cross_action_button(label: String, callable: Callable) -> Button:
	var button := Button.new()
	button.text = label
	button.custom_minimum_size = Vector2(130, 54)
	button.pressed.connect(callable)
	button.add_theme_font_size_override("font_size", 18)
	_apply_button_text_depth(button)
	return button


func _build_criss_cross_hand_summary_label() -> Label:
	var label := Label.new()
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.add_theme_font_size_override("font_size", 17)
	label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(label)
	return label


func _build_baccarat_interface() -> void:
	var top_bar := HBoxContainer.new()
	top_bar.add_theme_constant_override("separation", 10)
	baccarat_root.add_child(top_bar)

	var title := Label.new()
	title.text = "Baccarat"
	title.add_theme_font_size_override("font_size", 28)
	title.add_theme_color_override("font_color", Color("#f6f0df"))
	title.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_apply_text_depth(title)
	top_bar.add_child(title)

	baccarat_bankroll_label = Label.new()
	baccarat_bankroll_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	baccarat_bankroll_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	baccarat_bankroll_label.add_theme_font_size_override("font_size", 16)
	baccarat_bankroll_label.add_theme_color_override("font_color", Color("#cad1df"))
	_apply_text_depth(baccarat_bankroll_label)
	top_bar.add_child(baccarat_bankroll_label)

	var bet_label := Label.new()
	bet_label.text = "Bet"
	bet_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	bet_label.add_theme_color_override("font_color", Color("#cad1df"))
	top_bar.add_child(bet_label)

	baccarat_bet_spin = SpinBox.new()
	baccarat_bet_spin.min_value = 1.0
	baccarat_bet_spin.max_value = 100.0
	baccarat_bet_spin.step = 1.0
	baccarat_bet_spin.value = 5.0
	baccarat_bet_spin.custom_minimum_size = Vector2(95, 40)
	top_bar.add_child(baccarat_bet_spin)

	baccarat_bet_option = OptionButton.new()
	baccarat_bet_option.custom_minimum_size = Vector2(125, 40)
	for option in BACCARAT_BET_OPTIONS:
		baccarat_bet_option.add_item(option)
	baccarat_bet_option.select(1)
	top_bar.add_child(baccarat_bet_option)

	var reset_button := Button.new()
	reset_button.text = "Reset Credits"
	reset_button.custom_minimum_size = Vector2(135, 40)
	reset_button.pressed.connect(_on_baccarat_reset_pressed)
	_apply_button_text_depth(reset_button)
	top_bar.add_child(reset_button)

	var body := HSplitContainer.new()
	body.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	body.size_flags_vertical = Control.SIZE_EXPAND_FILL
	body.dragger_visibility = SplitContainer.DRAGGER_VISIBLE
	baccarat_root.add_child(body)

	body.add_child(_build_baccarat_table_panel())
	body.add_child(_build_baccarat_info_panel())


func _build_baccarat_table_panel() -> Control:
	var panel := PanelContainer.new()
	panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	panel.add_theme_stylebox_override("panel", _poker_table_style())

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 16)
	padding.add_theme_constant_override("margin_top", 16)
	padding.add_theme_constant_override("margin_right", 16)
	padding.add_theme_constant_override("margin_bottom", 16)
	panel.add_child(padding)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 12)
	padding.add_child(layout)

	baccarat_status_label = Label.new()
	baccarat_status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	baccarat_status_label.add_theme_font_size_override("font_size", 18)
	baccarat_status_label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(baccarat_status_label)
	layout.add_child(baccarat_status_label)

	baccarat_table_texture = TextureRect.new()
	baccarat_table_texture.custom_minimum_size = Vector2(560, 255)
	baccarat_table_texture.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	baccarat_table_texture.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	baccarat_table_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	if ResourceLoader.exists(BACCARAT_TABLE_IMAGE):
		baccarat_table_texture.texture = load(BACCARAT_TABLE_IMAGE)
	layout.add_child(baccarat_table_texture)

	var totals := HBoxContainer.new()
	totals.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	totals.add_theme_constant_override("separation", 90)
	layout.add_child(totals)

	baccarat_player_label = Label.new()
	baccarat_player_label.add_theme_font_size_override("font_size", 22)
	baccarat_player_label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(baccarat_player_label)
	totals.add_child(baccarat_player_label)

	baccarat_banker_label = Label.new()
	baccarat_banker_label.add_theme_font_size_override("font_size", 22)
	baccarat_banker_label.add_theme_color_override("font_color", Color("#ff7070"))
	_apply_text_depth(baccarat_banker_label)
	totals.add_child(baccarat_banker_label)

	var rows := HBoxContainer.new()
	rows.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	rows.add_theme_constant_override("separation", 46)
	layout.add_child(rows)

	baccarat_player_row = HBoxContainer.new()
	baccarat_player_row.add_theme_constant_override("separation", 10)
	rows.add_child(baccarat_player_row)

	baccarat_banker_row = HBoxContainer.new()
	baccarat_banker_row.add_theme_constant_override("separation", 10)
	rows.add_child(baccarat_banker_row)

	var action_row := HBoxContainer.new()
	action_row.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	action_row.add_theme_constant_override("separation", 16)
	layout.add_child(action_row)

	baccarat_deal_button = Button.new()
	baccarat_deal_button.text = "Deal"
	baccarat_deal_button.custom_minimum_size = Vector2(190, 62)
	baccarat_deal_button.pressed.connect(_on_baccarat_deal_pressed)
	baccarat_deal_button.add_theme_font_size_override("font_size", 22)
	_apply_button_text_depth(baccarat_deal_button)
	action_row.add_child(baccarat_deal_button)

	baccarat_tip_label = Label.new()
	baccarat_tip_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	baccarat_tip_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	baccarat_tip_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	baccarat_tip_label.add_theme_font_size_override("font_size", 24)
	baccarat_tip_label.add_theme_color_override("font_color", Color("#c9f3df"))
	_apply_text_depth(baccarat_tip_label)
	layout.add_child(baccarat_tip_label)

	baccarat_result_label = Label.new()
	baccarat_result_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	baccarat_result_label.add_theme_font_size_override("font_size", 20)
	baccarat_result_label.add_theme_color_override("font_color", Color("#f5d067"))
	_apply_text_depth(baccarat_result_label)
	layout.add_child(baccarat_result_label)

	return panel


func _build_baccarat_info_panel() -> Control:
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(430, 0)
	panel.add_theme_stylebox_override("panel", _panel_style(Color("#20242a")))

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 12)
	padding.add_theme_constant_override("margin_top", 12)
	padding.add_theme_constant_override("margin_right", 12)
	padding.add_theme_constant_override("margin_bottom", 12)
	panel.add_child(padding)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 10)
	padding.add_child(layout)

	var title := Label.new()
	title.text = "Baccarat"
	title.add_theme_font_size_override("font_size", 20)
	title.add_theme_color_override("font_color", Color("#f6f0df"))
	layout.add_child(title)

	var info := Label.new()
	info.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	info.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	info.add_theme_color_override("font_color", Color("#cad1df"))
	info.text = "Bet Player, Banker, or Tie before dealing.\n\nCards total by last digit only. Tens and face cards count as 0, aces count as 1.\n\nNatural 8 or 9 stands.\nPlayer and Banker third-card rules are automatic.\n\nPayouts:\nPlayer 1:1\nBanker 0.95:1\nTie 8:1"
	layout.add_child(info)

	return panel


func _build_craps_interface() -> void:
	var top_bar := HBoxContainer.new()
	top_bar.add_theme_constant_override("separation", 10)
	craps_root.add_child(top_bar)

	var title := Label.new()
	title.text = "Craps Royale"
	title.add_theme_font_size_override("font_size", 28)
	title.add_theme_color_override("font_color", Color("#f6f0df"))
	title.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_apply_text_depth(title)
	top_bar.add_child(title)

	craps_bankroll_label = Label.new()
	craps_bankroll_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	craps_bankroll_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	craps_bankroll_label.add_theme_font_size_override("font_size", 16)
	craps_bankroll_label.add_theme_color_override("font_color", Color("#cad1df"))
	_apply_text_depth(craps_bankroll_label)
	top_bar.add_child(craps_bankroll_label)

	craps_reset_button = Button.new()
	craps_reset_button.text = "Reset Table"
	craps_reset_button.custom_minimum_size = Vector2(125, 40)
	craps_reset_button.pressed.connect(_on_craps_reset_pressed)
	_apply_button_text_depth(craps_reset_button)
	top_bar.add_child(craps_reset_button)

	if not SHOW_CASINO_GAME_TABS:
		var exit_button := Button.new()
		exit_button.text = "Exit"
		exit_button.custom_minimum_size = Vector2(100, 40)
		exit_button.pressed.connect(_on_exit_pressed)
		_apply_button_text_depth(exit_button)
		_apply_exit_button_style(exit_button)
		top_bar.add_child(exit_button)

	var body := HSplitContainer.new()
	body.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	body.size_flags_vertical = Control.SIZE_EXPAND_FILL
	body.dragger_visibility = SplitContainer.DRAGGER_VISIBLE
	craps_root.add_child(body)

	body.add_child(_build_craps_table_panel())
	body.add_child(_build_craps_info_panel())


func _build_craps_table_panel() -> Control:
	var panel := PanelContainer.new()
	panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	panel.add_theme_stylebox_override("panel", _craps_table_style())

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 18)
	padding.add_theme_constant_override("margin_top", 18)
	padding.add_theme_constant_override("margin_right", 18)
	padding.add_theme_constant_override("margin_bottom", 18)
	panel.add_child(padding)

	craps_table_surface = Control.new()
	craps_table_surface.custom_minimum_size = Vector2(1200, 760)
	craps_table_surface.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	craps_table_surface.size_flags_vertical = Control.SIZE_EXPAND_FILL
	craps_table_surface.clip_contents = true
	craps_table_surface.resized.connect(_layout_craps_table_overlays)
	padding.add_child(craps_table_surface)

	craps_table_texture = TextureRect.new()
	craps_table_texture.set_anchors_preset(Control.PRESET_FULL_RECT)
	craps_table_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	craps_table_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	craps_table_texture.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if ResourceLoader.exists(CRAPS_TABLE_IMAGE):
		craps_table_texture.texture = load(CRAPS_TABLE_IMAGE)
	else:
		var table_image := Image.load_from_file(CRAPS_TABLE_IMAGE)
		if table_image != null and not table_image.is_empty():
			craps_table_texture.texture = ImageTexture.create_from_image(table_image)
	craps_table_surface.add_child(craps_table_texture)

	craps_status_label = Label.new()
	craps_status_label.position = Vector2(18, 14)
	craps_status_label.size = Vector2(760, 36)
	craps_status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	craps_status_label.add_theme_font_size_override("font_size", 20)
	craps_status_label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(craps_status_label)
	craps_table_surface.add_child(craps_status_label)

	for number in CRAPS_POINT_NUMBERS:
		var marker := Button.new()
		marker.text = str(number)
		marker.custom_minimum_size = Vector2(70, 42)
		marker.size = Vector2(70, 42)
		marker.disabled = true
		marker.add_theme_font_size_override("font_size", 22)
		marker.add_theme_color_override("font_color", Color("#f6f0df"))
		marker.add_theme_stylebox_override("normal", _craps_point_style(false))
		marker.add_theme_stylebox_override("disabled", _craps_point_style(false))
		_apply_button_text_depth(marker)
		craps_point_markers[number] = marker
		craps_table_surface.add_child(marker)

	craps_die_one = _build_craps_die()
	craps_die_two = _build_craps_die()
	craps_die_one.position = Vector2(-220, -220)
	craps_die_two.position = Vector2(-220, -220)
	craps_die_one.z_index = 10
	craps_die_two.z_index = 10
	craps_table_surface.add_child(craps_die_one)
	craps_table_surface.add_child(craps_die_two)

	craps_roll_button = Button.new()
	craps_roll_button.text = "Roll Dice"
	craps_roll_button.custom_minimum_size = Vector2(150, 54)
	craps_roll_button.size = Vector2(150, 54)
	craps_roll_button.add_theme_font_size_override("font_size", 24)
	craps_roll_button.pressed.connect(_on_craps_roll_pressed)
	_apply_button_text_depth(craps_roll_button)
	craps_table_surface.add_child(craps_roll_button)

	craps_point_label = Label.new()
	craps_point_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	craps_point_label.size = Vector2(170, 34)
	craps_point_label.add_theme_font_size_override("font_size", 22)
	craps_point_label.add_theme_color_override("font_color", Color("#f5d067"))
	_apply_text_depth(craps_point_label)
	craps_table_surface.add_child(craps_point_label)

	_add_craps_bet_zones()

	craps_chip_layer = Control.new()
	craps_chip_layer.set_anchors_preset(Control.PRESET_FULL_RECT)
	craps_chip_layer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	craps_chip_layer.z_index = 6
	craps_table_surface.add_child(craps_chip_layer)

	craps_chip_selector_row = HBoxContainer.new()
	craps_chip_selector_row.add_theme_constant_override("separation", 10)
	craps_chip_selector_row.z_index = 8
	craps_table_surface.add_child(craps_chip_selector_row)
	for denomination in CRAPS_CHIP_DENOMINATIONS:
		var chip_button := Button.new()
		chip_button.text = "$%d" % int(denomination)
		chip_button.toggle_mode = true
		chip_button.custom_minimum_size = Vector2(72, 72)
		chip_button.tooltip_text = "Use a $%d chip." % int(denomination)
		chip_button.pressed.connect(_on_craps_chip_selected.bind(float(denomination)))
		var chip_texture := _get_craps_chip_texture(float(denomination))
		if chip_texture != null:
			chip_button.icon = chip_texture
			chip_button.expand_icon = true
			chip_button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
			chip_button.vertical_icon_alignment = VERTICAL_ALIGNMENT_CENTER
			chip_button.text = ""
		chip_button.add_theme_font_size_override("font_size", 18)
		_apply_button_text_depth(chip_button)
		craps_chip_selector_buttons[float(denomination)] = chip_button
		craps_chip_selector_row.add_child(chip_button)

	craps_tip_label = Label.new()
	craps_tip_label.size = Vector2(760, 34)
	craps_tip_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	craps_tip_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	craps_tip_label.add_theme_font_size_override("font_size", 22)
	craps_tip_label.add_theme_color_override("font_color", Color("#c9f3df"))
	_apply_text_depth(craps_tip_label)
	craps_table_surface.add_child(craps_tip_label)

	craps_result_label = Label.new()
	craps_result_label.size = Vector2(760, 86)
	craps_result_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	craps_result_label.add_theme_font_size_override("font_size", 20)
	craps_result_label.add_theme_color_override("font_color", Color("#f5d067"))
	_apply_text_depth(craps_result_label)
	craps_table_surface.add_child(craps_result_label)

	call_deferred("_layout_craps_table_overlays")
	return panel


func _build_craps_info_panel() -> Control:
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(430, 0)
	panel.add_theme_stylebox_override("panel", _panel_style(Color("#20242a")))

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 12)
	padding.add_theme_constant_override("margin_top", 12)
	padding.add_theme_constant_override("margin_right", 12)
	padding.add_theme_constant_override("margin_bottom", 12)
	panel.add_child(padding)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 12)
	padding.add_child(layout)

	var title := Label.new()
	title.text = "Shooter Rail"
	title.add_theme_font_size_override("font_size", 20)
	title.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(title)
	layout.add_child(title)

	craps_bets_label = Label.new()
	craps_bets_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	craps_bets_label.add_theme_color_override("font_color", Color("#cad1df"))
	layout.add_child(craps_bets_label)

	craps_history_label = Label.new()
	craps_history_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	craps_history_label.add_theme_color_override("font_color", Color("#cad1df"))
	layout.add_child(craps_history_label)

	var separator := HSeparator.new()
	layout.add_child(separator)

	var how_to_title := Label.new()
	how_to_title.text = "How To Play"
	how_to_title.add_theme_font_size_override("font_size", 18)
	how_to_title.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(how_to_title)
	layout.add_child(how_to_title)

	var rules_scroll := ScrollContainer.new()
	rules_scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	rules_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	rules_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	layout.add_child(rules_scroll)

	var rules := Label.new()
	rules.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	rules.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	rules.add_theme_color_override("font_color", Color("#cad1df"))
	rules.text = _craps_rules_text()
	rules_scroll.add_child(rules)

	return panel


func _build_craps_die() -> TextureRect:
	var die := TextureRect.new()
	die.custom_minimum_size = CRAPS_DICE_DISPLAY_SIZE
	die.size = CRAPS_DICE_DISPLAY_SIZE
	die.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	die.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	die.mouse_filter = Control.MOUSE_FILTER_IGNORE
	die.texture = _get_craps_die_texture(1)
	die.pivot_offset = CRAPS_DICE_DISPLAY_SIZE * 0.5
	return die


func _build_craps_bet_spot(title: String, key: String, tooltip: String, color: Color, accent: Color) -> Button:
	var button := Button.new()
	button.custom_minimum_size = Vector2(220, 104)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.text = "%s\n$0" % title
	button.tooltip_text = tooltip
	button.set_meta("craps_title", title)
	button.set_meta("craps_color", color)
	button.set_meta("craps_accent", accent)
	button.pressed.connect(_on_craps_bet_pressed.bind(key))
	button.add_theme_font_size_override("font_size", 18)
	button.add_theme_color_override("font_color", Color("#ffffff"))
	_apply_button_text_depth(button)
	craps_bet_labels[key] = button
	button.add_theme_stylebox_override("normal", _craps_bet_spot_style(color, accent, false))
	button.add_theme_stylebox_override("hover", _craps_bet_spot_style(color.lightened(0.08), Color("#f6f0df"), true))
	button.add_theme_stylebox_override("pressed", _craps_bet_spot_style(color.darkened(0.08), Color("#ffffff"), true, true))
	return button


func _add_craps_bet_zones() -> void:
	for key in CRAPS_BET_ZONE_RECTS.keys():
		var buttons := []
		var rects: Array = CRAPS_BET_ZONE_RECTS[key]
		for zone_index in rects.size():
			var zone := Button.new()
			zone.text = ""
			zone.flat = true
			zone.focus_mode = Control.FOCUS_NONE
			zone.tooltip_text = "%s: %s" % [_craps_bet_display_name(str(key)), _craps_bet_tooltip(str(key))]
			zone.set_meta("craps_key", str(key))
			zone.set_meta("craps_reference_rect", rects[zone_index])
			zone.pressed.connect(_on_craps_bet_pressed.bind(str(key)))
			zone.z_index = 4
			_apply_craps_zone_style(zone, false, false)
			craps_table_surface.add_child(zone)
			buttons.append(zone)
		craps_bet_labels[key] = buttons


func _craps_bet_tooltip(key: String) -> String:
	match key:
		"pass":
			return "Come-out 7 or 11 wins. After a point is set, the point repeats before 7."
		"dont_pass":
			return "Come-out 2 or 3 wins, 12 pushes, 7 or 11 loses. After point, 7 wins."
		"come":
			return "After the main point is on, 7 or 11 wins, craps loses, and 4/5/6/8/9/10 travels as a Come point."
		"dont_come":
			return "After the main point is on, 2 or 3 wins, 12 pushes, 7 or 11 loses, and a number travels as a Don't Come point."
		"field":
			return "One-roll bet. 3, 4, 9, 10, 11 pay even; 2 pays 2:1; 12 pays 3:1."
		"big_6_8":
			return "Working bet. 6 or 8 pays even money before a 7."
		"any_seven":
			return "One-roll bet. Any 7 pays 4:1."
		"any_craps":
			return "One-roll bet. 2, 3, or 12 pays 7:1."
		"aces":
			return "One-roll bet. 1+1 pays 30:1."
		"boxcars":
			return "One-roll bet. 6+6 pays 30:1."
		"ace_deuce":
			return "One-roll bet. 1+2 pays 15:1."
		"yo":
			return "One-roll bet. 11 pays 15:1."
		"hard_4":
			return "Hard 4 pays 7:1 if 2+2 rolls before easy 4 or 7."
		"hard_6":
			return "Hard 6 pays 9:1 if 3+3 rolls before easy 6 or 7."
		"hard_8":
			return "Hard 8 pays 9:1 if 4+4 rolls before easy 8 or 7."
		"hard_10":
			return "Hard 10 pays 7:1 if 5+5 rolls before easy 10 or 7."
	return "Place a chip on this betting area."


func _layout_craps_table_overlays() -> void:
	if craps_table_surface == null:
		return

	var image_rect := _craps_table_image_rect()
	for key in craps_bet_labels.keys():
		var buttons: Array = craps_bet_labels[key]
		var rects: Array = CRAPS_BET_ZONE_RECTS[key]
		for index in min(buttons.size(), rects.size()):
			var button: Button = buttons[index]
			var zone_rect: Rect2 = rects[index]
			var mapped_rect := _map_craps_reference_rect(zone_rect, image_rect)
			button.position = mapped_rect.position
			button.size = mapped_rect.size

	for number in craps_point_markers.keys():
		var marker: Button = craps_point_markers[number]
		var reference_position: Vector2 = CRAPS_POINT_MARKER_POSITIONS.get(number, Vector2.ZERO)
		var mapped_position := _map_craps_reference_point(reference_position, image_rect)
		marker.position = mapped_position - marker.size * 0.5

	if craps_roll_button != null:
		var roll_position := _map_craps_reference_point(Vector2(900, 82), image_rect)
		craps_roll_button.position = roll_position - craps_roll_button.size * 0.5

	if craps_point_label != null:
		var point_position := _map_craps_reference_point(Vector2(900, 135), image_rect)
		craps_point_label.position = point_position - craps_point_label.size * 0.5

	if craps_tip_label != null:
		craps_tip_label.position = Vector2((craps_table_surface.size.x - craps_tip_label.size.x) * 0.5, max(48.0, craps_table_surface.size.y - 154.0))

	if craps_result_label != null:
		craps_result_label.position = Vector2(20, max(86.0, craps_table_surface.size.y - 96.0))

	if craps_chip_selector_row != null:
		var selector_size := craps_chip_selector_row.get_combined_minimum_size()
		craps_chip_selector_row.position = Vector2(
			(craps_table_surface.size.x - selector_size.x) * 0.5,
			max(64.0, craps_table_surface.size.y - 82.0)
		)

	_refresh_craps_chips()
	_place_craps_dice_at_rest()


func _craps_table_image_rect() -> Rect2:
	if craps_table_surface == null:
		return Rect2(Vector2.ZERO, CRAPS_TABLE_REFERENCE_SIZE)

	var surface_size := craps_table_surface.size
	if surface_size.x <= 0.0 or surface_size.y <= 0.0:
		return Rect2(Vector2.ZERO, CRAPS_TABLE_REFERENCE_SIZE)

	var scale: float = min(surface_size.x / CRAPS_TABLE_REFERENCE_SIZE.x, surface_size.y / CRAPS_TABLE_REFERENCE_SIZE.y)
	var displayed_size: Vector2 = CRAPS_TABLE_REFERENCE_SIZE * scale
	var origin: Vector2 = (surface_size - displayed_size) * 0.5
	return Rect2(origin, displayed_size)


func _map_craps_reference_point(point: Vector2, image_rect: Rect2) -> Vector2:
	return image_rect.position + Vector2(
		(point.x / CRAPS_TABLE_REFERENCE_SIZE.x) * image_rect.size.x,
		(point.y / CRAPS_TABLE_REFERENCE_SIZE.y) * image_rect.size.y
	)


func _map_craps_reference_rect(reference_rect: Rect2, image_rect: Rect2) -> Rect2:
	var top_left := _map_craps_reference_point(reference_rect.position, image_rect)
	var bottom_right := _map_craps_reference_point(reference_rect.position + reference_rect.size, image_rect)
	return Rect2(top_left, bottom_right - top_left)


func _refresh_craps_chips() -> void:
	if craps_chip_layer == null:
		return

	for child in craps_chip_layer.get_children():
		child.queue_free()

	var image_rect := _craps_table_image_rect()
	for key in craps_bets.keys():
		var amount := float(craps_bets.get(key, 0.0))
		if amount <= 0.0:
			continue

		var chip := _build_craps_chip(amount)
		var chip_position := _map_craps_reference_point(CRAPS_CHIP_POSITIONS.get(key, Vector2(750, 520)), image_rect)
		chip.position = chip_position - chip.custom_minimum_size * 0.5
		craps_chip_layer.add_child(chip)

	for point_number in CRAPS_POINT_NUMBERS:
		var come_amount := float(craps_come_points.get(point_number, 0.0))
		if come_amount > 0.0:
			var come_chip := _build_craps_chip(come_amount)
			var come_position := _map_craps_reference_point(CRAPS_COME_POINT_CHIP_POSITIONS.get(point_number, Vector2(750, 386)), image_rect)
			come_chip.position = come_position - come_chip.custom_minimum_size * 0.5
			craps_chip_layer.add_child(come_chip)

		var dont_come_amount := float(craps_dont_come_points.get(point_number, 0.0))
		if dont_come_amount > 0.0:
			var dont_come_chip := _build_craps_chip(dont_come_amount)
			var dont_come_position := _map_craps_reference_point(CRAPS_DONT_COME_POINT_CHIP_POSITIONS.get(point_number, Vector2(750, 248)), image_rect)
			dont_come_chip.position = dont_come_position - dont_come_chip.custom_minimum_size * 0.5
			craps_chip_layer.add_child(dont_come_chip)


func _build_craps_chip(amount: float) -> Control:
	var chip := Control.new()
	chip.custom_minimum_size = Vector2(78, 78)
	chip.size = chip.custom_minimum_size
	chip.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var texture := _get_craps_chip_texture(amount)
	if texture != null:
		var image := TextureRect.new()
		image.set_anchors_preset(Control.PRESET_FULL_RECT)
		image.texture = texture
		image.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		image.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		image.mouse_filter = Control.MOUSE_FILTER_IGNORE
		chip.add_child(image)
	else:
		var fallback := PanelContainer.new()
		fallback.set_anchors_preset(Control.PRESET_FULL_RECT)
		fallback.add_theme_stylebox_override("panel", _craps_chip_style())
		fallback.mouse_filter = Control.MOUSE_FILTER_IGNORE
		chip.add_child(fallback)

	if _has_exact_craps_chip_texture(amount):
		return chip

	var label := Label.new()
	label.set_anchors_preset(Control.PRESET_FULL_RECT)
	label.text = _format_craps_chip_amount(amount)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 17)
	label.add_theme_color_override("font_color", Color("#ffffff"))
	_apply_text_depth(label)
	chip.add_child(label)
	return chip


func _refresh_craps_chip_selector() -> void:
	if craps_chip_selector_buttons.is_empty():
		return

	for amount_value in craps_chip_selector_buttons.keys():
		var amount := float(amount_value)
		var button: Button = craps_chip_selector_buttons[amount]
		var selected := is_equal_approx(amount, craps_selected_chip_value)
		var unavailable := amount > craps_credits
		button.set_pressed_no_signal(selected)
		button.disabled = craps_roll_in_progress or unavailable
		button.add_theme_stylebox_override("normal", _craps_selector_chip_style(selected, false))
		button.add_theme_stylebox_override("hover", _craps_selector_chip_style(true, false))
		button.add_theme_stylebox_override("pressed", _craps_selector_chip_style(true, true))
		button.add_theme_stylebox_override("disabled", _craps_selector_chip_style(selected, false, true))
		button.add_theme_color_override("font_color", Color("#101317") if selected else Color("#f6f0df"))
		button.add_theme_color_override("font_hover_color", Color("#101317"))
		button.add_theme_color_override("font_pressed_color", Color("#101317"))
		button.add_theme_color_override("font_disabled_color", Color("#b9c0c9"))


func _format_craps_chip_amount(amount: float) -> String:
	if is_equal_approx(amount, roundf(amount)):
		return "$%d" % int(roundf(amount))
	return "$%.2f" % amount


func _place_craps_dice_at_rest() -> void:
	if craps_roll_in_progress or craps_die_one == null or craps_die_two == null:
		return

	var image_rect := _craps_table_image_rect()
	craps_die_one.position = _map_craps_reference_point(Vector2(560, 545), image_rect) - CRAPS_DICE_DISPLAY_SIZE * 0.5
	craps_die_two.position = _map_craps_reference_point(Vector2(680, 545), image_rect) - CRAPS_DICE_DISPLAY_SIZE * 0.5


func _build_roulette_interface() -> void:
	var top_bar := HBoxContainer.new()
	top_bar.add_theme_constant_override("separation", 10)
	roulette_root.add_child(top_bar)

	var title := Label.new()
	title.text = "Roulette"
	title.add_theme_font_size_override("font_size", 28)
	title.add_theme_color_override("font_color", Color("#f6f0df"))
	title.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_apply_text_depth(title)
	top_bar.add_child(title)

	roulette_bankroll_label = Label.new()
	roulette_bankroll_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	roulette_bankroll_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	roulette_bankroll_label.add_theme_font_size_override("font_size", 16)
	roulette_bankroll_label.add_theme_color_override("font_color", Color("#cad1df"))
	_apply_text_depth(roulette_bankroll_label)
	top_bar.add_child(roulette_bankroll_label)

	roulette_bet_option = OptionButton.new()
	roulette_bet_option.custom_minimum_size = Vector2(250, 40)
	roulette_bet_option.tooltip_text = "Shows the last betting spot you selected on the table."
	for option in ROULETTE_BET_OPTIONS:
		roulette_bet_option.add_item(str(option["label"]))
		roulette_bet_option.set_item_metadata(roulette_bet_option.item_count - 1, option["id"])
	roulette_bet_option.add_item("Straight 0 pays 35:1")
	roulette_bet_option.set_item_metadata(roulette_bet_option.item_count - 1, "straight_0")
	for number in range(1, 37):
		roulette_bet_option.add_item("Straight %d pays 35:1" % number)
		roulette_bet_option.set_item_metadata(roulette_bet_option.item_count - 1, "straight_%d" % number)
	top_bar.add_child(roulette_bet_option)

	roulette_reset_button = Button.new()
	roulette_reset_button.text = "Reset Credits"
	roulette_reset_button.custom_minimum_size = Vector2(135, 40)
	roulette_reset_button.pressed.connect(_on_roulette_reset_pressed)
	_apply_button_text_depth(roulette_reset_button)
	top_bar.add_child(roulette_reset_button)

	if not SHOW_CASINO_GAME_TABS:
		var exit_button := Button.new()
		exit_button.text = "Exit"
		exit_button.custom_minimum_size = Vector2(100, 40)
		exit_button.pressed.connect(_on_exit_pressed)
		_apply_button_text_depth(exit_button)
		_apply_exit_button_style(exit_button)
		top_bar.add_child(exit_button)

	var body := HSplitContainer.new()
	body.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	body.size_flags_vertical = Control.SIZE_EXPAND_FILL
	body.dragger_visibility = SplitContainer.DRAGGER_VISIBLE
	roulette_root.add_child(body)

	body.add_child(_build_roulette_table_panel())
	body.add_child(_build_roulette_info_panel())


func _build_roulette_table_panel() -> Control:
	var panel := PanelContainer.new()
	panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	panel.add_theme_stylebox_override("panel", _poker_table_style())

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 16)
	padding.add_theme_constant_override("margin_top", 16)
	padding.add_theme_constant_override("margin_right", 16)
	padding.add_theme_constant_override("margin_bottom", 16)
	panel.add_child(padding)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 12)
	padding.add_child(layout)

	roulette_status_label = Label.new()
	roulette_status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	roulette_status_label.add_theme_font_size_override("font_size", 18)
	roulette_status_label.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(roulette_status_label)
	layout.add_child(roulette_status_label)

	roulette_table_surface = Control.new()
	roulette_table_surface.custom_minimum_size = Vector2(960, 518)
	roulette_table_surface.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	roulette_table_surface.size_flags_vertical = Control.SIZE_EXPAND_FILL
	roulette_table_surface.clip_contents = true
	roulette_table_surface.resized.connect(_layout_roulette_table_overlays)
	layout.add_child(roulette_table_surface)

	var table_texture := _load_image_texture(ROULETTE_TABLE_IMAGE)
	roulette_table_texture = TextureRect.new()
	roulette_table_texture.set_anchors_preset(Control.PRESET_FULL_RECT)
	roulette_table_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	roulette_table_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	roulette_table_texture.mouse_filter = Control.MOUSE_FILTER_IGNORE
	roulette_table_texture.texture = table_texture
	roulette_table_surface.add_child(roulette_table_texture)

	roulette_wheel_texture = TextureRect.new()
	roulette_wheel_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	roulette_wheel_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	roulette_wheel_texture.mouse_filter = Control.MOUSE_FILTER_IGNORE
	roulette_wheel_texture.z_index = 2
	roulette_wheel_texture.texture = _load_image_texture(ROULETTE_WHEEL_IMAGE)
	roulette_table_surface.add_child(roulette_wheel_texture)

	_add_roulette_bet_zones()

	roulette_chip_layer = Control.new()
	roulette_chip_layer.set_anchors_preset(Control.PRESET_FULL_RECT)
	roulette_chip_layer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	roulette_chip_layer.z_index = 6
	roulette_table_surface.add_child(roulette_chip_layer)

	roulette_ball = _build_roulette_ball()
	roulette_ball.z_index = 7
	roulette_table_surface.add_child(roulette_ball)

	var action_row := HBoxContainer.new()
	action_row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	action_row.alignment = BoxContainer.ALIGNMENT_CENTER
	action_row.add_theme_constant_override("separation", 10)
	layout.add_child(action_row)

	roulette_chip_selector_row = HBoxContainer.new()
	roulette_chip_selector_row.add_theme_constant_override("separation", 8)
	action_row.add_child(roulette_chip_selector_row)
	for denomination in ROULETTE_CHIP_DENOMINATIONS:
		var chip_button := Button.new()
		chip_button.text = "$%d" % int(denomination)
		chip_button.toggle_mode = true
		chip_button.custom_minimum_size = Vector2(62, 62)
		chip_button.tooltip_text = "Select a $%d chip." % int(denomination)
		chip_button.pressed.connect(_on_roulette_chip_selected.bind(float(denomination)))
		var chip_texture := _get_craps_chip_texture(float(denomination))
		if chip_texture != null:
			chip_button.icon = chip_texture
			chip_button.expand_icon = true
			chip_button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
			chip_button.vertical_icon_alignment = VERTICAL_ALIGNMENT_CENTER
			chip_button.text = ""
		chip_button.add_theme_font_size_override("font_size", 16)
		_apply_button_text_depth(chip_button)
		roulette_chip_selector_buttons[float(denomination)] = chip_button
		roulette_chip_selector_row.add_child(chip_button)

	roulette_spin_button = Button.new()
	roulette_spin_button.text = "Spin"
	roulette_spin_button.custom_minimum_size = Vector2(190, 62)
	roulette_spin_button.pressed.connect(_on_roulette_spin_pressed)
	roulette_spin_button.add_theme_font_size_override("font_size", 22)
	_apply_button_text_depth(roulette_spin_button)
	action_row.add_child(roulette_spin_button)

	roulette_tip_label = Label.new()
	roulette_tip_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	roulette_tip_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	roulette_tip_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	roulette_tip_label.add_theme_font_size_override("font_size", 22)
	roulette_tip_label.add_theme_color_override("font_color", Color("#c9f3df"))
	_apply_text_depth(roulette_tip_label)
	layout.add_child(roulette_tip_label)

	roulette_result_label = Label.new()
	roulette_result_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	roulette_result_label.add_theme_font_size_override("font_size", 20)
	roulette_result_label.add_theme_color_override("font_color", Color("#f5d067"))
	_apply_text_depth(roulette_result_label)
	layout.add_child(roulette_result_label)

	return panel


func _build_roulette_info_panel() -> Control:
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(430, 0)
	panel.add_theme_stylebox_override("panel", _panel_style(Color("#20242a")))

	var padding := MarginContainer.new()
	padding.add_theme_constant_override("margin_left", 12)
	padding.add_theme_constant_override("margin_top", 12)
	padding.add_theme_constant_override("margin_right", 12)
	padding.add_theme_constant_override("margin_bottom", 12)
	panel.add_child(padding)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 12)
	padding.add_child(layout)

	var title := Label.new()
	title.text = "Wheel Rail"
	title.add_theme_font_size_override("font_size", 20)
	title.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(title)
	layout.add_child(title)

	roulette_history_label = Label.new()
	roulette_history_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	roulette_history_label.add_theme_color_override("font_color", Color("#cad1df"))
	layout.add_child(roulette_history_label)

	var separator := HSeparator.new()
	layout.add_child(separator)

	var how_to_title := Label.new()
	how_to_title.text = "How To Play"
	how_to_title.add_theme_font_size_override("font_size", 18)
	how_to_title.add_theme_color_override("font_color", Color("#f6f0df"))
	_apply_text_depth(how_to_title)
	layout.add_child(how_to_title)

	var rules_scroll := ScrollContainer.new()
	rules_scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	rules_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	rules_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	layout.add_child(rules_scroll)

	var rules := Label.new()
	rules.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	rules.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	rules.add_theme_color_override("font_color", Color("#cad1df"))
	rules.text = _roulette_rules_text()
	rules_scroll.add_child(rules)

	return panel


func _add_roulette_bet_zones() -> void:
	roulette_bet_zone_rects = _roulette_bet_zone_rects()
	roulette_bet_zone_buttons.clear()
	roulette_bets.clear()
	for key in roulette_bet_zone_rects.keys():
		roulette_bets[key] = 0.0
		var zone := Button.new()
		zone.text = ""
		zone.flat = true
		zone.focus_mode = Control.FOCUS_NONE
		zone.tooltip_text = "Place chip on %s" % _roulette_bet_display_name(str(key))
		zone.set_meta("roulette_key", str(key))
		zone.pressed.connect(_on_roulette_table_bet_pressed.bind(str(key)))
		zone.z_index = 4
		_apply_roulette_zone_style(zone, false, false)
		roulette_table_surface.add_child(zone)
		roulette_bet_zone_buttons[key] = zone


func _roulette_bet_zone_rects() -> Dictionary:
	var zones := {}
	var grid_origin := Vector2(956.0, 425.0)
	var cell_size := Vector2(66.0, 82.0)
	zones["straight_0"] = Rect2(883.0, 425.0, 73.0, 246.0)
	for column in range(12):
		var x := grid_origin.x + float(column) * cell_size.x
		zones["straight_%d" % (3 + column * 3)] = Rect2(x, grid_origin.y, cell_size.x, cell_size.y)
		zones["straight_%d" % (2 + column * 3)] = Rect2(x, grid_origin.y + cell_size.y, cell_size.x, cell_size.y)
		zones["straight_%d" % (1 + column * 3)] = Rect2(x, grid_origin.y + cell_size.y * 2.0, cell_size.x, cell_size.y)

	zones["column_3"] = Rect2(1748.0, 425.0, 76.0, 82.0)
	zones["column_2"] = Rect2(1748.0, 507.0, 76.0, 82.0)
	zones["column_1"] = Rect2(1748.0, 589.0, 76.0, 82.0)
	zones["first_dozen"] = Rect2(956.0, 678.0, 265.0, 65.0)
	zones["second_dozen"] = Rect2(1221.0, 678.0, 263.0, 65.0)
	zones["third_dozen"] = Rect2(1484.0, 678.0, 263.0, 65.0)
	zones["low"] = Rect2(956.0, 744.0, 132.0, 116.0)
	zones["odd"] = Rect2(1088.0, 744.0, 132.0, 116.0)
	zones["red"] = Rect2(1220.0, 744.0, 132.0, 116.0)
	zones["black"] = Rect2(1352.0, 744.0, 132.0, 116.0)
	zones["even"] = Rect2(1484.0, 744.0, 132.0, 116.0)
	zones["high"] = Rect2(1616.0, 744.0, 132.0, 116.0)
	return zones


func _layout_roulette_table_overlays() -> void:
	if roulette_table_surface == null:
		return

	var image_rect := _roulette_table_image_rect()
	for key in roulette_bet_zone_buttons.keys():
		var zone: Button = roulette_bet_zone_buttons[key]
		var reference_rect: Rect2 = roulette_bet_zone_rects[key]
		var mapped_rect := _map_roulette_reference_rect(reference_rect, image_rect)
		zone.position = mapped_rect.position
		zone.size = mapped_rect.size

	if roulette_wheel_texture != null:
		var wheel_rect := _map_roulette_reference_rect(ROULETTE_WHEEL_RECT, image_rect)
		roulette_wheel_texture.position = wheel_rect.position
		roulette_wheel_texture.size = wheel_rect.size
		roulette_wheel_texture.pivot_offset = wheel_rect.size * 0.5

	_position_roulette_ball()
	_refresh_roulette_chips()


func _roulette_table_image_rect() -> Rect2:
	if roulette_table_surface == null:
		return Rect2(Vector2.ZERO, ROULETTE_TABLE_REFERENCE_SIZE)

	var surface_size := roulette_table_surface.size
	if surface_size.x <= 0.0 or surface_size.y <= 0.0:
		return Rect2(Vector2.ZERO, ROULETTE_TABLE_REFERENCE_SIZE)

	var scale: float = min(surface_size.x / ROULETTE_TABLE_REFERENCE_SIZE.x, surface_size.y / ROULETTE_TABLE_REFERENCE_SIZE.y)
	var displayed_size: Vector2 = ROULETTE_TABLE_REFERENCE_SIZE * scale
	var origin: Vector2 = (surface_size - displayed_size) * 0.5
	return Rect2(origin, displayed_size)


func _map_roulette_reference_point(point: Vector2, image_rect: Rect2) -> Vector2:
	return image_rect.position + Vector2(
		(point.x / ROULETTE_TABLE_REFERENCE_SIZE.x) * image_rect.size.x,
		(point.y / ROULETTE_TABLE_REFERENCE_SIZE.y) * image_rect.size.y
	)


func _map_roulette_reference_rect(reference_rect: Rect2, image_rect: Rect2) -> Rect2:
	var top_left := _map_roulette_reference_point(reference_rect.position, image_rect)
	var bottom_right := _map_roulette_reference_point(reference_rect.position + reference_rect.size, image_rect)
	return Rect2(top_left, bottom_right - top_left)


func _build_roulette_ball() -> Control:
	var ball := PanelContainer.new()
	ball.custom_minimum_size = Vector2(20, 20)
	ball.size = ball.custom_minimum_size
	ball.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var style := StyleBoxFlat.new()
	style.bg_color = Color("#f9f7ef")
	style.border_color = Color("#d8b95f")
	style.set_border_width_all(2)
	style.set_corner_radius_all(10)
	style.shadow_color = Color("#000000aa")
	style.shadow_size = 8
	style.shadow_offset = Vector2(3, 4)
	ball.add_theme_stylebox_override("panel", style)
	return ball


func _position_roulette_ball() -> void:
	if roulette_ball == null:
		return

	var image_rect := _roulette_table_image_rect()
	var scale := image_rect.size.x / ROULETTE_TABLE_REFERENCE_SIZE.x
	var ball_size := Vector2.ONE * clampf(32.0 * scale, 16.0, 32.0)
	var center := _map_roulette_reference_point(ROULETTE_WHEEL_CENTER, image_rect)
	var radius := (ROULETTE_BALL_TRACK_RADIUS + roulette_ball_track_offset) * scale
	var orbit := Vector2(cos(roulette_ball_angle), sin(roulette_ball_angle)) * radius
	roulette_ball.size = ball_size
	roulette_ball.position = center + orbit - ball_size * 0.5


func _refresh_roulette_chips() -> void:
	if roulette_chip_layer == null:
		return

	for child in roulette_chip_layer.get_children():
		child.queue_free()

	var image_rect := _roulette_table_image_rect()
	var table_scale := image_rect.size.x / ROULETTE_TABLE_REFERENCE_SIZE.x
	var chip_size := Vector2.ONE * clampf(72.0 * table_scale, 34.0, 58.0)
	for key in roulette_bets.keys():
		var amount := float(roulette_bets.get(key, 0.0))
		if amount <= 0.0:
			continue

		var chip := _build_craps_chip(amount)
		chip.custom_minimum_size = chip_size
		chip.size = chip_size
		var chip_position := _roulette_chip_position(str(key), image_rect)
		chip.position = chip_position - chip_size * 0.5
		roulette_chip_layer.add_child(chip)


func _roulette_chip_position(key: String, image_rect: Rect2) -> Vector2:
	if not roulette_bet_zone_rects.has(key):
		return _map_roulette_reference_point(Vector2(1360.0, 640.0), image_rect)
	var rect: Rect2 = roulette_bet_zone_rects[key]
	return _map_roulette_reference_point(rect.position + rect.size * 0.5, image_rect)


func _build_slots_interface() -> void:
	var slot_scene: PackedScene = load(SLOT_SCENE_PATH)
	if slot_scene != null:
		var slot_node: Node = slot_scene.instantiate()
		if slot_node is Control:
			var scroll := ScrollContainer.new()
			scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
			slots_root.add_child(scroll)

			var center := CenterContainer.new()
			center.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			center.size_flags_vertical = Control.SIZE_EXPAND_FILL
			scroll.add_child(center)

			var slot_control := slot_node as Control
			slot_control.set("cell_size", Vector2(150, 150))
			slot_control.custom_minimum_size = Vector2(900, 760)
			slot_control.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
			slot_control.size_flags_vertical = Control.SIZE_SHRINK_CENTER
			center.add_child(slot_control)
		else:
			slots_root.add_child(slot_node)
		return

	var message := Label.new()
	message.text = "Slot scene missing: %s" % SLOT_SCENE_PATH
	message.add_theme_font_size_override("font_size", 24)
	message.add_theme_color_override("font_color", Color("#f5d067"))
	_apply_text_depth(message)
	slots_root.add_child(message)


func _configure_stats_wrap_label(label: Label) -> void:
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART


func _build_reset_button(text: String, callback: Callable) -> Button:
	var button := Button.new()
	button.text = text
	button.custom_minimum_size = Vector2(0, 34)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.tooltip_text = "%s without changing card picks." % text
	button.pressed.connect(callback)
	_apply_button_text_depth(button)
	return button


func _on_craps_bet_pressed(key: String) -> void:
	if craps_roll_in_progress:
		return
	if not craps_bets.has(key):
		return
	if craps_point != 0 and (key == "pass" or key == "dont_pass"):
		craps_result_label.text = "Line bets start on the come-out roll. The point is already %d." % craps_point
		return
	if craps_point == 0 and (key == "come" or key == "dont_come"):
		craps_result_label.text = "%s starts after a point is on." % _craps_bet_display_name(key)
		return

	var amount := craps_selected_chip_value
	if amount <= 0.0:
		return
	if amount > craps_credits:
		craps_result_label.text = "Not enough credits for a $%.2f chip." % amount
		return

	craps_credits -= amount
	craps_total_wagered += amount
	craps_bets[key] = float(craps_bets[key]) + amount
	craps_result_label.text = "$%.2f pressed onto %s." % [amount, _craps_bet_display_name(key)]
	_refresh_craps()


func _on_craps_chip_selected(amount: float) -> void:
	craps_selected_chip_value = amount
	_refresh_craps_chip_selector()


func _on_craps_roll_pressed() -> void:
	if craps_roll_in_progress:
		return
	if _craps_total_active_bets() <= 0.0:
		craps_result_label.text = "Place a chip on the felt before rolling."
		return

	craps_roll_in_progress = true
	_refresh_craps()

	var die_a := randi_range(1, 6)
	var die_b := randi_range(1, 6)
	await _animate_craps_throw(die_a, die_b)

	_set_craps_dice(die_a, die_b, false)
	_resolve_craps_roll(die_a, die_b)
	craps_roll_in_progress = false
	_refresh_craps()


func _animate_craps_throw(final_die_a: int, final_die_b: int) -> void:
	if craps_table_surface == null or craps_die_one == null or craps_die_two == null:
		for i in 9:
			_set_craps_dice(randi_range(1, 6), randi_range(1, 6), true, i)
			await get_tree().create_timer(0.055 + float(i) * 0.012).timeout
		return

	var image_rect := _craps_table_image_rect()
	var start_a := _map_craps_reference_point(Vector2(-90, 1060), image_rect)
	var start_b := _map_craps_reference_point(Vector2(-120, 1120), image_rect)
	var end_a := _map_craps_reference_point(Vector2(randf_range(500.0, 980.0), randf_range(470.0, 820.0)), image_rect)
	var end_b := _map_craps_reference_point(Vector2(randf_range(620.0, 1100.0), randf_range(520.0, 870.0)), image_rect)
	var bounce_a := _craps_throw_bounce_point(start_a, end_a, image_rect)
	var bounce_b := _craps_throw_bounce_point(start_b, end_b, image_rect)

	craps_die_one.position = start_a - CRAPS_DICE_DISPLAY_SIZE * 0.5
	craps_die_two.position = start_b - CRAPS_DICE_DISPLAY_SIZE * 0.5
	craps_die_one.scale = Vector2(1.1, 1.1)
	craps_die_two.scale = Vector2(1.1, 1.1)

	var tween_a := create_tween()
	tween_a.tween_property(craps_die_one, "position", bounce_a - CRAPS_DICE_DISPLAY_SIZE * 0.5, 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween_a.tween_property(craps_die_one, "position", end_a - CRAPS_DICE_DISPLAY_SIZE * 0.5, 0.42).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween_a.parallel().tween_property(craps_die_one, "rotation_degrees", randf_range(260.0, 460.0), 0.67)

	var tween_b := create_tween()
	tween_b.tween_property(craps_die_two, "position", bounce_b - CRAPS_DICE_DISPLAY_SIZE * 0.5, 0.30).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween_b.tween_property(craps_die_two, "position", end_b - CRAPS_DICE_DISPLAY_SIZE * 0.5, 0.38).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween_b.parallel().tween_property(craps_die_two, "rotation_degrees", randf_range(-460.0, -260.0), 0.68)

	for i in 14:
		_set_craps_dice(randi_range(1, 6), randi_range(1, 6), true, i)
		await get_tree().create_timer(0.045 + float(i) * 0.006).timeout

	_set_craps_dice(final_die_a, final_die_b, false)
	if tween_a.is_running():
		await tween_a.finished
	if tween_b.is_running():
		await tween_b.finished


func _craps_throw_bounce_point(start: Vector2, ending: Vector2, image_rect: Rect2) -> Vector2:
	var should_hit_rail := randf() < 0.45
	if should_hit_rail:
		var rail := randi_range(0, 2)
		match rail:
			0:
				return Vector2(randf_range(image_rect.position.x + image_rect.size.x * 0.18, image_rect.position.x + image_rect.size.x * 0.82), image_rect.position.y + image_rect.size.y * 0.10)
			1:
				return Vector2(image_rect.position.x + image_rect.size.x * 0.12, randf_range(image_rect.position.y + image_rect.size.y * 0.28, image_rect.position.y + image_rect.size.y * 0.72))
			_:
				return Vector2(image_rect.position.x + image_rect.size.x * 0.88, randf_range(image_rect.position.y + image_rect.size.y * 0.28, image_rect.position.y + image_rect.size.y * 0.72))

	return start.lerp(ending, 0.55) + Vector2(randf_range(-90.0, 90.0), randf_range(-80.0, 40.0))


func _on_craps_reset_pressed() -> void:
	craps_credits = CRAPS_STARTING_CREDITS
	craps_point = 0
	craps_rolls_played = 0
	craps_total_wagered = 0.0
	craps_total_paid = 0.0
	craps_roll_history.clear()
	craps_last_roll = [1, 1]
	craps_roll_in_progress = false
	for key in craps_bets.keys():
		craps_bets[key] = 0.0
	craps_come_points.clear()
	craps_dont_come_points.clear()
	craps_result_label.text = "Fresh rail. The dice are yours."
	_set_craps_dice(1, 1, false)
	_refresh_craps()


func _on_roulette_spin_pressed() -> void:
	if roulette_spin_in_progress:
		return

	var total_bet := _roulette_total_active_bets()
	if total_bet <= 0.0:
		roulette_result_label.text = "Place at least one chip on the roulette table before spinning."
		return

	roulette_spin_in_progress = true
	_refresh_roulette()

	var pocket := randi_range(0, 36)
	await _animate_roulette_spin(pocket)

	roulette_spins_played += 1
	roulette_last_pocket = pocket

	var pocket_text := _roulette_pocket_text(pocket)
	var color_text := _roulette_pocket_color_name(pocket)
	var paid := 0.0
	var winners := []
	for bet_key in roulette_bets.keys():
		var stake := float(roulette_bets[bet_key])
		if stake <= 0.0:
			continue
		if _roulette_bet_wins(str(bet_key), pocket):
			var payout := stake * float(_roulette_bet_payout_multiplier(str(bet_key)) + 1)
			paid += payout
			winners.append("%s paid $%.2f" % [_roulette_bet_display_name(str(bet_key)), payout])
		roulette_bets[bet_key] = 0.0

	if paid > 0.0:
		roulette_credits += paid
		roulette_total_paid += paid

	var net := paid - total_bet
	var result_text := "%s %s. " % [pocket_text, color_text]
	if winners.is_empty():
		result_text += "All roulette bets lose $%.2f." % total_bet
	else:
		result_text += "%s. Net %s." % [", ".join(winners), _format_signed_money(net)]
	roulette_result_label.text = result_text

	roulette_spin_history.push_front(
		"Spin %d: %s %s | wager $%.2f | paid $%.2f | %s" % [
			roulette_spins_played,
			pocket_text,
			color_text,
			total_bet,
			paid,
			_format_signed_money(net),
		]
	)
	while roulette_spin_history.size() > 12:
		roulette_spin_history.pop_back()

	roulette_spin_in_progress = false
	_refresh_roulette()


func _on_roulette_chip_selected(amount: float) -> void:
	roulette_selected_chip_value = amount
	_refresh_roulette_chip_selector()


func _on_roulette_table_bet_pressed(key: String) -> void:
	if roulette_spin_in_progress:
		return
	if not roulette_bets.has(key):
		return

	var amount := roulette_selected_chip_value
	if amount <= 0.0:
		return
	if amount > roulette_credits:
		roulette_result_label.text = "Not enough credits for a $%.2f chip." % amount
		return

	roulette_credits -= amount
	roulette_total_wagered += amount
	roulette_bets[key] = float(roulette_bets[key]) + amount
	_select_roulette_bet_option(key)
	roulette_result_label.text = "$%.2f placed on %s." % [amount, _roulette_bet_display_name(key)]
	_refresh_roulette()


func _on_roulette_reset_pressed() -> void:
	roulette_credits = ROULETTE_STARTING_CREDITS
	roulette_spins_played = 0
	roulette_total_wagered = 0.0
	roulette_total_paid = 0.0
	roulette_last_pocket = 0
	roulette_spin_in_progress = false
	roulette_spin_history.clear()
	for key in roulette_bets.keys():
		roulette_bets[key] = 0.0
	roulette_result_label.text = "Credits reset. Choose a bet and spin."
	_refresh_roulette()


func _on_poker_deal_pressed() -> void:
	if poker_waiting_for_draw:
		poker_result_label.text = "Spin this hand before dealing again."
		return

	var bet := float(poker_bet_spin.value)
	var line_count := _get_poker_hand_count()
	var total_bet := bet * float(line_count)
	if total_bet > poker_credits:
		poker_result_label.text = "Not enough credits for %d lines at $%.2f each." % [line_count, bet]
		return

	poker_hand_count = line_count
	poker_credits -= total_bet
	poker_total_wagered += total_bet
	poker_hands_played += line_count
	poker_deck = _build_poker_deck()
	poker_deck.shuffle()
	poker_cards.clear()
	poker_hands.clear()
	poker_hold.clear()
	for i in POKER_HAND_SIZE:
		poker_cards.append(_draw_poker_card())
		poker_hold.append(false)
	for row_index in SPIN_POKER_ROWS:
		var row_cards := []
		for card_index in POKER_HAND_SIZE:
			if row_index == SPIN_POKER_CENTER_ROW:
				row_cards.append(poker_cards[card_index])
			else:
				row_cards.append({})
		poker_hands.append(row_cards)

	poker_waiting_for_draw = true
	poker_result_label.text = "Choose holds on the middle row, then spin %d line%s." % [poker_hand_count, "" if poker_hand_count == 1 else "s"]
	_refresh_poker()


func _on_poker_draw_pressed() -> void:
	if not poker_waiting_for_draw:
		return

	var bet := float(poker_bet_spin.value)
	var total_payout := 0.0
	var win_lines := []
	var draw_deck := _build_poker_deck_excluding(poker_cards)
	draw_deck.shuffle()
	for row_index in SPIN_POKER_ROWS:
		var hand: Array = poker_hands[row_index]
		for card_index in POKER_HAND_SIZE:
			if bool(poker_hold[card_index]):
				hand[card_index] = poker_cards[card_index]
			else:
				hand[card_index] = draw_deck.pop_back()

	var line_count := _active_poker_line_count()
	for line_index in line_count:
		var line_cards := _spin_poker_line_cards(line_index)
		var result := _evaluate_poker_hand(line_cards)
		var multiplier := int(result["multiplier"])
		var payout := bet * float(multiplier)
		total_payout += payout
		if payout > 0.0:
			win_lines.append("Line %d: %s pays %.0fx (+$%.2f)" % [line_index + 1, str(result["hand"]), multiplier, payout])
	poker_cards = _duplicate_poker_cards(poker_hands[SPIN_POKER_CENTER_ROW]) if poker_hands.size() > SPIN_POKER_CENTER_ROW else []
	poker_credits += total_payout
	poker_total_paid += total_payout
	poker_waiting_for_draw = false

	if total_payout > 0.0:
		poker_result_label.text = "Paid $%.2f total.\n%s" % [total_payout, "\n".join(win_lines)]
	else:
		poker_result_label.text = "No payout across %d active line%s." % [line_count, "" if line_count == 1 else "s"]

	_refresh_poker()


func _on_poker_card_pressed(index: int) -> void:
	if not poker_waiting_for_draw or index < 0 or index >= poker_hold.size():
		return

	poker_hold[index] = not bool(poker_hold[index])
	_refresh_poker()


func _on_poker_hand_count_selected(index: int) -> void:
	if poker_waiting_for_draw:
		_refresh_poker_hand_count_option()
		return
	if poker_hand_count_option == null:
		return
	poker_hand_count = int(poker_hand_count_option.get_item_id(index))
	_refresh_poker()


func _on_poker_reset_pressed() -> void:
	poker_credits = POKER_STARTING_CREDITS
	poker_hands_played = 0
	poker_total_wagered = 0.0
	poker_total_paid = 0.0
	poker_waiting_for_draw = false
	poker_cards.clear()
	poker_hands.clear()
	poker_hold.clear()
	poker_result_label.text = "Credits reset. Deal the middle row to start Spin Poker."
	_refresh_poker()


func _on_pai_gow_deal_pressed() -> void:
	if pai_gow_in_round:
		pai_gow_result_label.text = "Set this hand before dealing again."
		return

	var bet := float(pai_gow_bet_spin.value)
	if bet > pai_gow_credits:
		pai_gow_result_label.text = "Not enough credits for that bet."
		return

	pai_gow_credits -= bet
	pai_gow_current_bet = bet
	pai_gow_total_wagered += bet
	pai_gow_hands_played += 1
	pai_gow_deck = _build_poker_deck()
	pai_gow_deck.shuffle()
	pai_gow_player_cards.clear()
	pai_gow_dealer_cards.clear()
	pai_gow_low_indices.clear()
	pai_gow_in_round = true
	pai_gow_reveal_dealer = false

	for i in 7:
		pai_gow_player_cards.append(_draw_pai_gow_card())
		pai_gow_dealer_cards.append(_draw_pai_gow_card())

	pai_gow_result_label.text = "Choose two cards for the Low hand, then set your hands."
	_refresh_pai_gow()


func _on_pai_gow_house_way_pressed() -> void:
	if not pai_gow_in_round:
		return

	pai_gow_low_indices = _pai_gow_house_way_low_indices(pai_gow_player_cards)
	pai_gow_result_label.text = "House Way selected. Set hands when ready."
	_refresh_pai_gow()


func _on_pai_gow_card_pressed(index: int) -> void:
	if not pai_gow_in_round or index < 0 or index >= pai_gow_player_cards.size():
		return

	if pai_gow_low_indices.has(index):
		pai_gow_low_indices.erase(index)
	elif pai_gow_low_indices.size() < 2:
		pai_gow_low_indices.append(index)
		pai_gow_low_indices.sort()
	else:
		pai_gow_result_label.text = "Low hand already has two cards. Unselect one first."
	_refresh_pai_gow()


func _on_pai_gow_set_pressed() -> void:
	if not pai_gow_in_round:
		return
	if pai_gow_low_indices.size() != 2:
		pai_gow_result_label.text = "Choose exactly two cards for the Low hand."
		return

	var player_split := _pai_gow_split_from_indices(pai_gow_player_cards, pai_gow_low_indices)
	if _pai_gow_split_is_foul(player_split):
		pai_gow_result_label.text = "Foul hand: your five-card High must outrank your two-card Low."
		_refresh_pai_gow()
		return

	var dealer_low_indices := _pai_gow_house_way_low_indices(pai_gow_dealer_cards)
	var dealer_split := _pai_gow_split_from_indices(pai_gow_dealer_cards, dealer_low_indices)
	var low_compare := _compare_pai_gow_evals(
		_pai_gow_evaluate_two_card(player_split["low"]),
		_pai_gow_evaluate_two_card(dealer_split["low"])
	)
	var high_compare := _compare_pai_gow_evals(
		_pai_gow_evaluate_five_card(player_split["high"]),
		_pai_gow_evaluate_five_card(dealer_split["high"])
	)

	var player_units := 0
	var banker_units := 0
	for compare in [low_compare, high_compare]:
		if int(compare) > 0:
			player_units += 1
		else:
			banker_units += 1

	var payout := 0.0
	var message := ""
	if player_units == 2:
		payout = pai_gow_current_bet * 2.0
		message = "You win both hands."
	elif banker_units == 2:
		message = "Dealer wins both hands."
	else:
		payout = pai_gow_current_bet
		message = "Push. One side wins each hand."

	pai_gow_credits += payout
	pai_gow_total_paid += payout
	pai_gow_in_round = false
	pai_gow_reveal_dealer = true
	pai_gow_result_label.text = "%s Paid $%.2f." % [message, payout]
	_refresh_pai_gow()


func _on_pai_gow_reset_pressed() -> void:
	pai_gow_credits = PAI_GOW_STARTING_CREDITS
	pai_gow_current_bet = 0.0
	pai_gow_hands_played = 0
	pai_gow_total_wagered = 0.0
	pai_gow_total_paid = 0.0
	pai_gow_in_round = false
	pai_gow_reveal_dealer = false
	pai_gow_deck.clear()
	pai_gow_player_cards.clear()
	pai_gow_dealer_cards.clear()
	pai_gow_low_indices.clear()
	pai_gow_result_label.text = "Credits reset."
	_refresh_pai_gow()


func _on_blackjack_deal_pressed() -> void:
	if blackjack_in_round:
		return

	var bet := float(blackjack_bet_spin.value)
	if bet > blackjack_credits:
		blackjack_result_label.text = "Not enough credits for that bet."
		return

	blackjack_credits -= bet
	blackjack_current_bet = bet
	blackjack_total_wagered += bet
	blackjack_hands_played += 1
	blackjack_deck = _build_poker_deck()
	blackjack_deck.shuffle()
	blackjack_dealer_cards.clear()
	blackjack_player_cards.clear()
	blackjack_round_over = false
	blackjack_in_round = true

	blackjack_player_cards.append(_draw_blackjack_card())
	blackjack_dealer_cards.append(_draw_blackjack_card())
	blackjack_player_cards.append(_draw_blackjack_card())
	blackjack_dealer_cards.append(_draw_blackjack_card())

	var player_blackjack := _is_blackjack(blackjack_player_cards)
	var dealer_blackjack := _is_blackjack(blackjack_dealer_cards)
	if player_blackjack and dealer_blackjack:
		_finish_blackjack_round("Both have blackjack. Push.", bet)
	elif player_blackjack:
		_finish_blackjack_round("Blackjack pays 3:2.", bet * 2.5)
	elif dealer_blackjack:
		_finish_blackjack_round("Dealer has blackjack.", 0.0)
	else:
		blackjack_result_label.text = "Choose Hit or Stand."
		_refresh_blackjack()


func _on_blackjack_hit_pressed() -> void:
	if not blackjack_in_round:
		return

	blackjack_player_cards.append(_draw_blackjack_card())
	var total := int(_blackjack_hand_value(blackjack_player_cards)["total"])
	if total > 21:
		_finish_blackjack_round("Bust. Dealer wins.", 0.0)
	else:
		blackjack_result_label.text = "Hit or Stand."
		_refresh_blackjack()


func _on_blackjack_stand_pressed() -> void:
	if not blackjack_in_round:
		return

	while int(_blackjack_hand_value(blackjack_dealer_cards)["total"]) < 17:
		blackjack_dealer_cards.append(_draw_blackjack_card())

	var player_total := int(_blackjack_hand_value(blackjack_player_cards)["total"])
	var dealer_total := int(_blackjack_hand_value(blackjack_dealer_cards)["total"])
	if dealer_total > 21:
		_finish_blackjack_round("Dealer busts. You win.", blackjack_current_bet * 2.0)
	elif player_total > dealer_total:
		_finish_blackjack_round("You beat the dealer.", blackjack_current_bet * 2.0)
	elif player_total == dealer_total:
		_finish_blackjack_round("Push. Bet returned.", blackjack_current_bet)
	else:
		_finish_blackjack_round("Dealer wins.", 0.0)


func _on_blackjack_reset_pressed() -> void:
	blackjack_credits = BLACKJACK_STARTING_CREDITS
	blackjack_current_bet = 0.0
	blackjack_hands_played = 0
	blackjack_total_wagered = 0.0
	blackjack_total_paid = 0.0
	blackjack_in_round = false
	blackjack_round_over = false
	blackjack_deck.clear()
	blackjack_dealer_cards.clear()
	blackjack_player_cards.clear()
	blackjack_result_label.text = "Credits reset."
	_refresh_blackjack()


func _on_three_card_deal_pressed() -> void:
	if three_card_in_round:
		return

	var ante := float(three_card_ante_spin.value)
	var pair_plus := float(three_card_pair_plus_spin.value)
	var wager := ante + pair_plus
	if wager > three_card_credits:
		three_card_result_label.text = "Not enough credits for that bet."
		return

	three_card_credits -= wager
	three_card_current_ante = ante
	three_card_current_pair_plus = pair_plus
	three_card_total_wagered += wager
	three_card_hands_played += 1
	three_card_deck = _build_poker_deck()
	three_card_deck.shuffle()
	three_card_dealer_cards.clear()
	three_card_player_cards.clear()
	three_card_in_round = true
	three_card_reveal_dealer = false

	for i in 3:
		three_card_player_cards.append(_draw_three_card())
		three_card_dealer_cards.append(_draw_three_card())

	var player_eval := _evaluate_three_card_hand(three_card_player_cards)
	three_card_result_label.text = "Your hand: %s. Play or Fold." % str(player_eval["name"])
	_refresh_three_card()


func _on_three_card_play_pressed() -> void:
	if not three_card_in_round:
		return

	var play_bet := three_card_current_ante
	if play_bet > three_card_credits:
		three_card_result_label.text = "Not enough credits to make the Play bet."
		return

	three_card_credits -= play_bet
	three_card_total_wagered += play_bet
	three_card_reveal_dealer = true

	var player_eval := _evaluate_three_card_hand(three_card_player_cards)
	var dealer_eval := _evaluate_three_card_hand(three_card_dealer_cards)
	var pair_plus_paid := _three_card_pair_plus_payout(player_eval)
	var ante_bonus := _three_card_ante_bonus(player_eval)
	var dealer_qualifies := _three_card_dealer_qualifies(dealer_eval)
	var ante := three_card_current_ante
	var payout := pair_plus_paid + ante_bonus
	var message := ""

	if not dealer_qualifies:
		payout += ante * 2.0 + play_bet
		message = "Dealer does not qualify. Ante wins, Play pushes."
	else:
		var compare := _compare_three_card_hands(player_eval, dealer_eval)
		if compare > 0:
			payout += ante * 2.0 + play_bet * 2.0
			message = "You win with %s." % str(player_eval["name"])
		elif compare == 0:
			payout += ante + play_bet
			message = "Push. Both hands tie."
		else:
			message = "Dealer wins with %s." % str(dealer_eval["name"])

	_finish_three_card_round("%s Pair Plus/bonus paid $%.2f." % [message, pair_plus_paid + ante_bonus], payout)


func _on_three_card_fold_pressed() -> void:
	if not three_card_in_round:
		return

	three_card_reveal_dealer = true
	var player_eval := _evaluate_three_card_hand(three_card_player_cards)
	var pair_plus_paid := _three_card_pair_plus_payout(player_eval)
	_finish_three_card_round("Folded. Ante lost. Pair Plus paid $%.2f." % pair_plus_paid, pair_plus_paid)


func _on_three_card_reset_pressed() -> void:
	three_card_credits = THREE_CARD_STARTING_CREDITS
	three_card_current_ante = 0.0
	three_card_current_pair_plus = 0.0
	three_card_hands_played = 0
	three_card_total_wagered = 0.0
	three_card_total_paid = 0.0
	three_card_in_round = false
	three_card_reveal_dealer = false
	three_card_deck.clear()
	three_card_dealer_cards.clear()
	three_card_player_cards.clear()
	three_card_result_label.text = "Credits reset."
	_refresh_three_card()


func _on_criss_cross_deal_pressed() -> void:
	if criss_cross_stage != CRISS_CROSS_STAGE_READY and criss_cross_stage != CRISS_CROSS_STAGE_COMPLETE:
		criss_cross_result_label.text = "Finish this hand before dealing again."
		return

	var ante := float(criss_cross_ante_spin.value)
	var bonus := float(criss_cross_bonus_spin.value)
	var opening_wager := ante * 2.0 + bonus
	if opening_wager > criss_cross_credits:
		criss_cross_result_label.text = "Not enough credits for the two antes and bonus."
		return

	criss_cross_credits -= opening_wager
	criss_cross_total_wagered += opening_wager
	criss_cross_current_ante = ante
	criss_cross_current_bonus = bonus
	criss_cross_across_bet = 0.0
	criss_cross_down_bet = 0.0
	criss_cross_middle_bet = 0.0
	criss_cross_hands_played += 1
	criss_cross_deck = _build_poker_deck()
	criss_cross_deck.shuffle()
	criss_cross_player_cards.clear()
	criss_cross_community_cards.clear()
	criss_cross_stage = CRISS_CROSS_STAGE_ACROSS

	for i in 5:
		criss_cross_community_cards.append(_draw_criss_cross_card())
	for i in 2:
		criss_cross_player_cards.append(_draw_criss_cross_card())

	criss_cross_result_label.text = "Choose an Across Bet from 1x to 3x, or fold."
	_refresh_criss_cross()


func _on_criss_cross_across_pressed() -> void:
	if criss_cross_stage != CRISS_CROSS_STAGE_ACROSS:
		return
	var bet := criss_cross_current_ante * float(criss_cross_across_mult_spin.value)
	if not _criss_cross_take_raise(bet):
		return
	criss_cross_across_bet = bet
	criss_cross_stage = CRISS_CROSS_STAGE_DOWN
	criss_cross_result_label.text = "Horizontal outside cards are revealed. Choose a Down Bet."
	_refresh_criss_cross()


func _on_criss_cross_down_pressed() -> void:
	if criss_cross_stage != CRISS_CROSS_STAGE_DOWN:
		return
	var bet := criss_cross_current_ante * float(criss_cross_down_mult_spin.value)
	if not _criss_cross_take_raise(bet):
		return
	criss_cross_down_bet = bet
	criss_cross_stage = CRISS_CROSS_STAGE_MIDDLE
	criss_cross_result_label.text = "Top and bottom cards are revealed. Choose a Middle Bet."
	_refresh_criss_cross()


func _on_criss_cross_middle_pressed() -> void:
	if criss_cross_stage != CRISS_CROSS_STAGE_MIDDLE:
		return
	var bet := criss_cross_current_ante * float(criss_cross_middle_mult_spin.value)
	if not _criss_cross_take_raise(bet):
		return
	criss_cross_middle_bet = bet
	_finish_criss_cross_round(false)


func _on_criss_cross_fold_pressed() -> void:
	if not [CRISS_CROSS_STAGE_ACROSS, CRISS_CROSS_STAGE_DOWN, CRISS_CROSS_STAGE_MIDDLE].has(criss_cross_stage):
		return
	_finish_criss_cross_round(true)


func _on_criss_cross_reset_pressed() -> void:
	criss_cross_credits = CRISS_CROSS_STARTING_CREDITS
	criss_cross_current_ante = 0.0
	criss_cross_current_bonus = 0.0
	criss_cross_across_bet = 0.0
	criss_cross_down_bet = 0.0
	criss_cross_middle_bet = 0.0
	criss_cross_hands_played = 0
	criss_cross_total_wagered = 0.0
	criss_cross_total_paid = 0.0
	criss_cross_stage = CRISS_CROSS_STAGE_READY
	criss_cross_deck.clear()
	criss_cross_player_cards.clear()
	criss_cross_community_cards.clear()
	criss_cross_result_label.text = "Credits reset."
	_refresh_criss_cross()


func _criss_cross_take_raise(bet: float) -> bool:
	if bet > criss_cross_credits:
		criss_cross_result_label.text = "Not enough credits for that raise."
		_refresh_criss_cross()
		return false
	criss_cross_credits -= bet
	criss_cross_total_wagered += bet
	return true


func _finish_criss_cross_round(folded: bool) -> void:
	criss_cross_stage = CRISS_CROSS_STAGE_COMPLETE
	var bonus_paid := _criss_cross_bonus_return()
	var main_paid := 0.0
	var message := ""

	if folded:
		message = "Folded. Main wagers are lost."
	else:
		var across_eval := _criss_cross_across_eval()
		var down_eval := _criss_cross_down_eval()
		var across_ante_paid := _criss_cross_ante_return(criss_cross_current_ante, across_eval)
		var down_ante_paid := _criss_cross_ante_return(criss_cross_current_ante, down_eval)
		var across_paid := _criss_cross_play_return(criss_cross_across_bet, across_eval)
		var down_paid := _criss_cross_play_return(criss_cross_down_bet, down_eval)
		var middle_paid := _criss_cross_middle_return(criss_cross_middle_bet, across_eval, down_eval)
		main_paid = across_ante_paid + down_ante_paid + across_paid + down_paid + middle_paid
		message = "Across: %s. Down: %s." % [str(across_eval["name"]), str(down_eval["name"])]

	var payout := main_paid + bonus_paid
	criss_cross_credits += payout
	criss_cross_total_paid += payout
	criss_cross_result_label.text = "%s Main paid $%.2f. Bonus paid $%.2f. Total paid $%.2f." % [
		message,
		main_paid,
		bonus_paid,
		payout,
	]
	_refresh_criss_cross()


func _on_baccarat_deal_pressed() -> void:
	var bet := float(baccarat_bet_spin.value)
	if bet > baccarat_credits:
		baccarat_result_label.text = "Not enough credits for that bet."
		return

	baccarat_last_bet_side = BACCARAT_BET_OPTIONS[baccarat_bet_option.selected]
	baccarat_credits -= bet
	baccarat_total_wagered += bet
	baccarat_hands_played += 1
	baccarat_deck = _build_poker_deck()
	baccarat_deck.shuffle()
	baccarat_player_cards.clear()
	baccarat_banker_cards.clear()

	baccarat_player_cards.append(_draw_baccarat_card())
	baccarat_banker_cards.append(_draw_baccarat_card())
	baccarat_player_cards.append(_draw_baccarat_card())
	baccarat_banker_cards.append(_draw_baccarat_card())
	_apply_baccarat_draw_rules()

	var player_total := _baccarat_total(baccarat_player_cards)
	var banker_total := _baccarat_total(baccarat_banker_cards)
	var winner := "Tie"
	if player_total > banker_total:
		winner = "Player"
	elif banker_total > player_total:
		winner = "Banker"

	var payout := _baccarat_payout(bet, baccarat_last_bet_side, winner)
	baccarat_credits += payout
	baccarat_total_paid += payout
	baccarat_result_label.text = "%s wins %d-%d. Bet: %s. Paid $%.2f." % [
		winner,
		player_total,
		banker_total,
		baccarat_last_bet_side,
		payout,
	]
	_refresh_baccarat()


func _on_baccarat_reset_pressed() -> void:
	baccarat_credits = BACCARAT_STARTING_CREDITS
	baccarat_hands_played = 0
	baccarat_total_wagered = 0.0
	baccarat_total_paid = 0.0
	baccarat_player_cards.clear()
	baccarat_banker_cards.clear()
	baccarat_deck.clear()
	baccarat_result_label.text = "Credits reset."
	_refresh_baccarat()


func _on_card_pressed(index: int) -> void:
	selected_card = index
	reveal_all_card_numbers = false
	_refresh_all()


func _on_number_pressed(number: int) -> void:
	reveal_all_card_numbers = false
	var picks: Array = card_picks[selected_card]
	if picks.has(number):
		picks.erase(number)
	elif picks.size() < MAX_PICKS_PER_CARD:
		picks.append(number)
		picks.sort()
	else:
		result_label.text = "Card %s already has %d picks. Clear one first." % [_card_label(selected_card), MAX_PICKS_PER_CARD]
		return
	_refresh_all()


func _on_play_pressed() -> void:
	var result := _run_keno_round("single", true, true)
	if not bool(result.get("ok", false)):
		result_label.text = str(result.get("message", "Could not play this round."))
		_refresh_all()


func _run_keno_round(mode: String, animate_balls: bool, write_log: bool, group_index := -1, group_name := "", allow_negative_credits := false) -> Dictionary:
	var active_cards := _get_active_cards()
	if active_cards.is_empty():
		return {"ok": false, "message": "Pick at least one number on a card before playing."}

	var bet := float(bet_spin.value)
	var round_wager := bet * active_cards.size()
	if not allow_negative_credits and round_wager > keno_credits:
		return {"ok": false, "message": "Not enough credits for a $%.2f round. Lower the bet or reset counters." % round_wager}

	last_draw = _draw_numbers()
	rounds_played += 1
	for number in last_draw:
		number_hit_counts[number] += 1

	var round_paid := 0.0
	var round_hits := 0
	var result_lines := []
	var card_results := []
	for i in CARD_COUNT:
		card_last_hits[i] = 0
		card_last_paid[i] = 0.0

	for card_index in active_cards:
		var picks: Array = card_picks[card_index]
		var matches := _count_matches(picks, last_draw)
		var multiplier := _get_payout_multiplier(picks.size(), matches)
		var payout := bet * multiplier
		card_last_hits[card_index] = matches
		card_last_paid[card_index] = payout
		card_plays[card_index] += 1
		card_profit[card_index] += payout - bet
		if payout > bet:
			card_wins[card_index] += 1
		_record_hit_tally(picks.size(), matches)
		round_paid += payout
		round_hits += matches
		result_lines.append("%s %d/%d hits pays %.0fx" % [_card_label(card_index), matches, picks.size(), multiplier])
		card_results.append({
			"card": _card_label(card_index),
			"index": card_index,
			"spots": picks.size(),
			"matches": matches,
			"multiplier": multiplier,
			"paid": payout,
			"picks": picks.duplicate(),
		})

	total_wagered += round_wager
	total_paid += round_paid
	keno_credits += round_paid - round_wager
	keno_last_round_paid = round_paid
	keno_last_round_wagered = round_wager
	keno_last_cards_played = active_cards.size()
	if round_paid > round_wager:
		winning_rounds += 1
	else:
		losing_rounds += 1

	_record_recent_run(rounds_played, active_cards.size(), round_hits, round_paid, round_wager)
	reveal_all_card_numbers = true

	var result_text := "Round %d: wager $%.2f, paid $%.2f, net $%.2f\n%s" % [
		rounds_played,
		round_wager,
		round_paid,
		round_paid - round_wager,
		", ".join(result_lines),
	]
	if mode != "batch":
		result_label.text = result_text
	if write_log:
		_append_keno_run_log({
			"timestamp": Time.get_datetime_string_from_system(),
			"mode": mode,
			"group_index": group_index,
			"group_name": group_name,
			"round": rounds_played,
			"active_cards": active_cards.size(),
			"bet": bet,
			"wagered": round_wager,
			"paid": round_paid,
			"net": round_paid - round_wager,
			"hits": round_hits,
			"draw": last_draw.duplicate(),
			"cards": card_results,
		})
	_refresh_all()
	if animate_balls:
		_animate_keno_balls()
	return {
		"ok": true,
		"round": rounds_played,
		"paid": round_paid,
		"wagered": round_wager,
		"net": round_paid - round_wager,
		"hits": round_hits,
		"wins": 1 if round_paid > round_wager else 0,
		"text": result_text,
	}


func _on_auto_play_toggled(playing: bool) -> void:
	if playing and _get_active_cards().is_empty():
		result_label.text = "Pick at least one number on a card before starting Auto Play."
		auto_play_button.set_pressed_no_signal(false)
		_refresh_auto_play_button(false)
		return

	if playing:
		auto_play_timer.start()
	else:
		auto_play_timer.stop()

	_refresh_auto_play_button(playing)


func _on_auto_play_timeout() -> void:
	if keno_ball_animating:
		return

	if _get_active_cards().is_empty():
		auto_play_timer.stop()
		auto_play_button.set_pressed_no_signal(false)
		_refresh_auto_play_button(false)
		result_label.text = "Auto Play stopped because no cards have picks."
		_refresh_all()
		return

	_on_play_pressed()


func _on_quick_pick_all_pressed() -> void:
	reveal_all_card_numbers = false
	var quick_count := _get_quick_pick_count()
	for i in CARD_COUNT:
		card_picks[i] = _draw_unique(quick_count, NUMBER_MAX)
	_refresh_all()


func _on_quick_pick_card_pressed() -> void:
	reveal_all_card_numbers = false
	card_picks[selected_card] = _draw_unique(_get_quick_pick_count(), NUMBER_MAX)
	_refresh_all()


func _on_use_hot_picks_pressed() -> void:
	reveal_all_card_numbers = false
	var picks := _draw_unique(MAX_PICKS_PER_CARD, NUMBER_MAX)
	if rounds_played > 0:
		picks = _get_hot_numbers(MAX_PICKS_PER_CARD)
	card_picks[selected_card] = picks
	_refresh_all()


func _on_select_pattern_art_pressed() -> void:
	selected_saved_pattern_index = (selected_saved_pattern_index + 1) % SAVED_KENO_PATTERN_COUNT
	if saved_pattern_option != null:
		saved_pattern_option.select(selected_saved_pattern_index)
	if not _load_selected_saved_pattern():
		result_label.text = "Selected Pattern %d. This slot is empty." % (selected_saved_pattern_index + 1)
		_refresh_all()


func _on_art_speed_pressed() -> void:
	if auto_play_button == null:
		return
	auto_play_button.set_pressed_no_signal(not auto_play_button.button_pressed)
	_on_auto_play_toggled(auto_play_button.button_pressed)


func _on_art_max_bet_pressed() -> void:
	bet_spin.value = bet_spin.max_value
	result_label.text = "Bet set to max."
	_refresh_all()


func _on_art_bet_pressed() -> void:
	var next_bet := float(bet_spin.value) + float(bet_spin.step)
	if next_bet > float(bet_spin.max_value):
		next_bet = float(bet_spin.min_value)
	bet_spin.value = next_bet
	result_label.text = "Bet per card: $%.0f." % float(bet_spin.value)
	_refresh_all()


func _on_saved_pattern_selected(index: int) -> void:
	if saved_pattern_option == null:
		return
	selected_saved_pattern_index = clampi(saved_pattern_option.get_item_id(index), 0, SAVED_KENO_PATTERN_COUNT - 1)
	if not _load_selected_saved_pattern():
		result_label.text = "Selected Pattern %d. This slot is empty." % (selected_saved_pattern_index + 1)
		_refresh_all()


func _on_save_pattern_pressed() -> void:
	var picks := _sanitize_keno_pick_list(card_picks[selected_card])
	if picks.is_empty():
		result_label.text = "Pick at least one number on Card %s before saving a pattern." % _card_label(selected_card)
		return

	var pattern_index := _get_selected_pattern_index()
	saved_pick_patterns[pattern_index] = picks
	if not _save_saved_pick_patterns():
		result_label.text = "Could not save Pattern %d." % (pattern_index + 1)
		return

	result_label.text = "Saved Card %s picks to Pattern %d." % [_card_label(selected_card), pattern_index + 1]
	_refresh_saved_pattern_option()
	_refresh_all()


func _on_use_saved_pattern_pressed() -> void:
	_load_selected_saved_pattern()


func _load_selected_saved_pattern() -> bool:
	var pattern_index := _get_selected_pattern_index()
	var picks: Array = saved_pick_patterns[pattern_index]
	if picks.is_empty():
		result_label.text = "Pattern %d is empty. Save picks to it first." % (pattern_index + 1)
		return false

	reveal_all_card_numbers = false
	card_picks[selected_card] = picks.duplicate()
	result_label.text = "Loaded Pattern %d onto Card %s." % [pattern_index + 1, _card_label(selected_card)]
	_refresh_all()
	return true


func _on_delete_saved_pattern_pressed() -> void:
	var pattern_index := _get_selected_pattern_index()
	if saved_pick_patterns[pattern_index].is_empty():
		result_label.text = "Pattern %d is already empty." % (pattern_index + 1)
		return

	saved_pick_patterns[pattern_index].clear()
	if not _save_saved_pick_patterns():
		result_label.text = "Could not delete Pattern %d." % (pattern_index + 1)
		return

	result_label.text = "Deleted Pattern %d." % (pattern_index + 1)
	_refresh_saved_pattern_option()


func _on_saved_group_selected(index: int) -> void:
	if saved_group_option == null:
		return
	selected_saved_group_index = clampi(saved_group_option.get_item_id(index), 0, SAVED_KENO_GROUP_COUNT - 1)
	_sync_saved_group_name_edit()


func _on_group_name_submitted(_new_text: String) -> void:
	var group_index := _get_selected_group_index()
	var group: Dictionary = saved_card_groups[group_index]
	if not _card_group_cards_have_picks(group.get("cards", [])):
		return

	group["name"] = _get_group_name_for_save(group_index)
	saved_card_groups[group_index] = group
	if not _save_saved_card_groups():
		result_label.text = "Could not rename Group %d." % (group_index + 1)
		return

	result_label.text = "Renamed Group %d to %s." % [group_index + 1, str(group["name"])]
	_refresh_saved_group_option()


func _on_save_group_pressed() -> void:
	var cards := _snapshot_current_keno_cards()
	if not _card_group_cards_have_picks(cards):
		result_label.text = "Pick numbers on at least one card before saving a 20-card group."
		return

	var group_index := _get_selected_group_index()
	var group_name := _get_group_name_for_save(group_index)
	saved_card_groups[group_index] = {
		"name": group_name,
		"cards": cards,
		"saved_at": Time.get_datetime_string_from_system(),
	}
	if not _save_saved_card_groups():
		result_label.text = "Could not save Group %d." % (group_index + 1)
		return

	result_label.text = "Saved all 20 cards to Group %d: %s." % [group_index + 1, group_name]
	_refresh_saved_group_option()


func _on_load_group_pressed() -> void:
	_load_selected_card_group(true)


func _load_selected_card_group(show_message: bool) -> bool:
	var group_index := _get_selected_group_index()
	var group: Dictionary = saved_card_groups[group_index]
	var cards: Array = group.get("cards", [])
	if not _card_group_cards_have_picks(cards):
		if show_message:
			result_label.text = "Group %d is empty. Save all 20 cards to it first." % (group_index + 1)
		return false

	for i in CARD_COUNT:
		card_picks[i] = _sanitize_keno_pick_list(cards[i] if i < cards.size() else [])
	reveal_all_card_numbers = false
	if show_message:
		result_label.text = "Loaded Group %d: %s." % [group_index + 1, str(group.get("name", "Group"))]
	_refresh_all()
	return true


func _on_delete_group_pressed() -> void:
	var group_index := _get_selected_group_index()
	var group: Dictionary = saved_card_groups[group_index]
	if not _card_group_cards_have_picks(group.get("cards", [])):
		result_label.text = "Group %d is already empty." % (group_index + 1)
		return

	saved_card_groups[group_index] = _empty_keno_card_group(group_index)
	if not _save_saved_card_groups():
		result_label.text = "Could not delete Group %d." % (group_index + 1)
		return

	result_label.text = "Deleted Group %d." % (group_index + 1)
	_refresh_saved_group_option()


func _on_clear_all_cards_button_pressed() -> void:
	_on_clear_all_pressed()
	result_label.text = "All card picks cleared."


func _on_run_group_1000_pressed() -> void:
	if keno_batch_running:
		return

	var run_count := _get_batch_run_count()
	var group_index := _get_selected_group_index()
	var group: Dictionary = saved_card_groups[group_index]
	var group_name := str(group.get("name", "Group %02d" % (group_index + 1)))
	if _card_group_cards_have_picks(group.get("cards", [])):
		_load_selected_card_group(false)
	elif _get_active_cards().is_empty():
		result_label.text = "Save or load a group before running %d rounds." % run_count
		return
	else:
		group_index = -1
		group_name = "Current unsaved cards"

	_clear_keno_balls()
	if auto_play_button != null:
		auto_play_button.set_pressed_no_signal(false)
		_on_auto_play_toggled(false)

	keno_batch_running = true
	if run_group_button != null:
		run_group_button.disabled = true
		run_group_button.text = "Running..."
	if batch_run_count_spin != null:
		batch_run_count_spin.editable = false

	var total_paid := 0.0
	var total_wagered := 0.0
	var total_hits := 0
	var winning_batch_rounds := 0
	var completed_runs := 0
	for run_index in run_count:
		var result := _run_keno_round("batch", false, true, group_index, group_name, true)
		if not bool(result.get("ok", false)):
			result_label.text = str(result.get("message", "Batch run stopped."))
			break
		completed_runs += 1
		total_paid += float(result["paid"])
		total_wagered += float(result["wagered"])
		total_hits += int(result["hits"])
		winning_batch_rounds += int(result["wins"])
		if run_index % 50 == 49:
			result_label.text = "Running %s: %d/%d rounds logged..." % [group_name, run_index + 1, run_count]
			_refresh_all()
			await get_tree().process_frame

	keno_batch_running = false
	if run_group_button != null:
		run_group_button.disabled = false
		run_group_button.text = "Run"
	if batch_run_count_spin != null:
		batch_run_count_spin.editable = true

	var log_path := ProjectSettings.globalize_path(KENO_RUN_LOG_PATH)
	result_label.text = "%s ran %d rounds. Wins %d, hits %d, wagered $%.2f, paid $%.2f, net %s.\nLog: %s" % [
		group_name,
		completed_runs,
		winning_batch_rounds,
		total_hits,
		total_wagered,
		total_paid,
		_format_signed_money(total_paid - total_wagered),
		log_path,
	]
	_refresh_all()


func _get_batch_run_count() -> int:
	if batch_run_count_spin == null:
		return KENO_DEFAULT_BATCH_RUN_COUNT
	return clampi(int(batch_run_count_spin.value), 1, KENO_MAX_BATCH_RUN_COUNT)


func _on_build_best_group_pressed() -> void:
	var wheel_id := _get_selected_coverage_wheel_id()
	var best := _build_best_keno_group_for_wheel(wheel_id)
	var patch_size := int(best["patch_size"])
	var cards: Array = best["cards"]
	for i in CARD_COUNT:
		card_picks[i] = _sanitize_keno_pick_list(cards[i] if i < cards.size() else [])
	reveal_all_card_numbers = true

	var group_index := _get_selected_group_index()
	var group_name := "%s R%dC%d" % [
		str(best.get("wheel_name", "Best %dx%d %s patch" % [
			patch_size,
			patch_size,
			str(best.get("spot_label", "%d-spot" % int(best.get("pick_count", 0)))),
		])),
		int(best["row"]) + 1,
		int(best["column"]) + 1,
	]
	if group_name.length() > 48:
		group_name = group_name.left(48)
	saved_card_groups[group_index] = {
		"name": group_name,
		"cards": _snapshot_current_keno_cards(),
		"saved_at": Time.get_datetime_string_from_system(),
	}
	_save_saved_card_groups()
	_refresh_saved_group_option()

	var sheet_path := _write_keno_best_group_cheat_sheet(best, group_index, group_name)
	result_label.text = "Built and saved %s to Group %d. Cheat sheet: %s" % [
		group_name,
		group_index + 1,
		ProjectSettings.globalize_path(sheet_path),
	]
	_refresh_all()


func _build_best_keno_group_for_wheel(wheel_id: int) -> Dictionary:
	if wheel_id == KENO_WHEEL_AUTO:
		var patch_size := _get_selected_patch_size()
		var pick_count := _get_selected_optimizer_pick_count(patch_size)
		var auto_best := _build_best_keno_group_for_patch_size(patch_size, pick_count)
		auto_best["wheel_name"] = "Auto %dx%d %d-spot patch" % [
			patch_size,
			patch_size,
			int(auto_best["pick_count"]),
		]
		auto_best["spot_label"] = "%d-spot" % int(auto_best["pick_count"])
		return auto_best

	var config := _get_coverage_wheel_config(wheel_id)
	var patch_size := int(config["patch_size"])
	var best_patch := _find_best_patch(patch_size)
	var patch_numbers: Array = best_patch["numbers"]
	var cards := _build_coverage_wheel_cards(patch_numbers, config["patterns"])
	return {
		"patch_size": patch_size,
		"row": best_patch["row"],
		"column": best_patch["column"],
		"numbers": patch_numbers,
		"cards": cards,
		"pick_count": _common_card_pick_count(cards),
		"spot_label": _coverage_cards_spot_label(cards),
		"wheel_name": str(config["name"]),
		"expected_multiplier": _average_expected_payout_multiplier(cards),
	}


func _on_keno_reset_menu_id_pressed(id: int) -> void:
	match id:
		0:
			_on_reset_all_time_pressed()
		1:
			_on_reset_recent_runs_pressed()
		2:
			_on_reset_number_hits_pressed()
		3:
			_on_reset_selected_card_pressed()
		4:
			_on_reset_all_cards_pressed()
		5:
			_on_clear_card_pressed()
			result_label.text = "Card %s picks cleared." % _card_label(selected_card)
		6:
			_on_clear_all_pressed()
			result_label.text = "All card picks cleared."
		7:
			_on_reset_all_counters_pressed()


func _on_clear_card_pressed() -> void:
	reveal_all_card_numbers = false
	card_picks[selected_card].clear()
	_refresh_all()


func _on_clear_all_pressed() -> void:
	reveal_all_card_numbers = false
	for picks in card_picks:
		picks.clear()
	_refresh_all()


func _on_reset_all_time_pressed() -> void:
	_reset_all_time_counters()
	_reset_hit_tally()
	result_label.text = "All-time round and money counters reset."
	_refresh_all()


func _on_reset_recent_runs_pressed() -> void:
	recent_runs.clear()
	result_label.text = "Last 100 run tally reset."
	_refresh_all()


func _on_reset_number_hits_pressed() -> void:
	_reset_number_hit_counters()
	_reset_hit_tally()
	result_label.text = "Hit counters reset."
	_refresh_all()


func _on_reset_selected_card_pressed() -> void:
	_reset_card_counters(selected_card)
	result_label.text = "Card %s counters reset." % _card_label(selected_card)
	_refresh_all()


func _on_reset_all_cards_pressed() -> void:
	_reset_all_card_counters()
	result_label.text = "All card counters reset."
	_refresh_all()


func _on_reset_all_counters_pressed() -> void:
	_reset_all_time_counters()
	_reset_all_card_counters()
	_reset_number_hit_counters()
	_reset_hit_tally()
	recent_runs.clear()
	result_label.text = "All counters reset. Card picks were kept."
	_refresh_all()


func _refresh_all() -> void:
	_refresh_cards()
	_refresh_numbers()
	_refresh_labels()
	_refresh_keno_art_labels()


func _refresh_saved_pattern_option() -> void:
	if saved_pattern_option == null:
		return

	var selected_index := 0
	if saved_pattern_option.selected >= 0:
		selected_index = saved_pattern_option.get_selected_id()
	else:
		selected_index = selected_saved_pattern_index

	saved_pattern_option.clear()
	for i in SAVED_KENO_PATTERN_COUNT:
		var picks: Array = saved_pick_patterns[i]
		var label := "Pattern %d: Empty" % (i + 1)
		if not picks.is_empty():
			label = "Pattern %d: %s" % [i + 1, ", ".join(_stringify_numbers(picks, MAX_PICKS_PER_CARD))]
		saved_pattern_option.add_item(label, i)

	selected_saved_pattern_index = clampi(selected_index, 0, SAVED_KENO_PATTERN_COUNT - 1)
	saved_pattern_option.select(selected_saved_pattern_index)


func _get_selected_pattern_index() -> int:
	if saved_pattern_option == null or saved_pattern_option.selected < 0:
		return clampi(selected_saved_pattern_index, 0, SAVED_KENO_PATTERN_COUNT - 1)
	selected_saved_pattern_index = clampi(saved_pattern_option.get_selected_id(), 0, SAVED_KENO_PATTERN_COUNT - 1)
	return selected_saved_pattern_index


func _selected_pattern_display_name() -> String:
	var pattern_index := _get_selected_pattern_index()
	var picks: Array = saved_pick_patterns[pattern_index]
	if picks.is_empty():
		return "Pattern %d: Empty" % (pattern_index + 1)
	return "Pattern %d: %s" % [pattern_index + 1, ", ".join(_stringify_numbers(picks, MAX_PICKS_PER_CARD))]


func _load_saved_pick_patterns() -> void:
	var config := ConfigFile.new()
	var error := config.load(SAVED_KENO_PATTERNS_PATH)
	if error != OK:
		return

	for i in SAVED_KENO_PATTERN_COUNT:
		var key := "pattern_%02d" % (i + 1)
		saved_pick_patterns[i] = _sanitize_keno_pick_list(config.get_value("patterns", key, []))


func _save_saved_pick_patterns() -> bool:
	var config := ConfigFile.new()
	for i in SAVED_KENO_PATTERN_COUNT:
		var key := "pattern_%02d" % (i + 1)
		config.set_value("patterns", key, saved_pick_patterns[i])

	return config.save(SAVED_KENO_PATTERNS_PATH) == OK


func _refresh_saved_group_option() -> void:
	if saved_group_option == null:
		return

	var selected_index := selected_saved_group_index
	if saved_group_option.selected >= 0:
		selected_index = saved_group_option.get_selected_id()

	saved_group_option.clear()
	for i in SAVED_KENO_GROUP_COUNT:
		var group: Dictionary = saved_card_groups[i]
		var cards: Array = group.get("cards", [])
		var filled_cards := _count_filled_group_cards(cards)
		var label := "Group %d: Empty" % (i + 1)
		if filled_cards > 0:
			label = "Group %d: %s (%d cards)" % [
				i + 1,
				str(group.get("name", "Saved")),
				filled_cards,
			]
		saved_group_option.add_item(label, i)

	selected_saved_group_index = clampi(selected_index, 0, SAVED_KENO_GROUP_COUNT - 1)
	saved_group_option.select(selected_saved_group_index)
	_sync_saved_group_name_edit()


func _get_selected_group_index() -> int:
	if saved_group_option == null or saved_group_option.selected < 0:
		return clampi(selected_saved_group_index, 0, SAVED_KENO_GROUP_COUNT - 1)
	selected_saved_group_index = clampi(saved_group_option.get_selected_id(), 0, SAVED_KENO_GROUP_COUNT - 1)
	return selected_saved_group_index


func _sync_saved_group_name_edit() -> void:
	if saved_group_name_edit == null:
		return

	var group_index := clampi(selected_saved_group_index, 0, SAVED_KENO_GROUP_COUNT - 1)
	var group: Dictionary = saved_card_groups[group_index]
	saved_group_name_edit.text = _sanitize_saved_group_name(str(group.get("name", _default_group_name(group_index))), group_index)


func _get_group_name_for_save(group_index: int) -> String:
	var name := ""
	if saved_group_name_edit != null:
		name = saved_group_name_edit.text
	return _sanitize_saved_group_name(name, group_index)


func _sanitize_saved_group_name(name: String, group_index: int) -> String:
	var clean_name := name.strip_edges()
	if clean_name.is_empty():
		return _default_group_name(group_index)
	return clean_name.left(48)


func _default_group_name(group_index: int) -> String:
	return "Group %02d" % (group_index + 1)


func _empty_keno_card_group(index: int) -> Dictionary:
	return {
		"name": _default_group_name(index),
		"cards": _empty_keno_card_list(),
		"saved_at": "",
	}


func _empty_keno_card_list() -> Array:
	var cards := []
	for i in CARD_COUNT:
		cards.append([])
	return cards


func _snapshot_current_keno_cards() -> Array:
	var cards := []
	for i in CARD_COUNT:
		cards.append(_sanitize_keno_pick_list(card_picks[i]))
	return cards


func _card_group_cards_have_picks(cards: Array) -> bool:
	for i in min(CARD_COUNT, cards.size()):
		var picks := _sanitize_keno_pick_list(cards[i])
		if not picks.is_empty():
			return true
	return false


func _count_filled_group_cards(cards: Array) -> int:
	var filled := 0
	for i in min(CARD_COUNT, cards.size()):
		if not _sanitize_keno_pick_list(cards[i]).is_empty():
			filled += 1
	return filled


func _load_saved_card_groups() -> void:
	var config := ConfigFile.new()
	var error := config.load(SAVED_KENO_GROUPS_PATH)
	if error != OK:
		return

	for i in SAVED_KENO_GROUP_COUNT:
		var section := "group_%02d" % (i + 1)
		if not config.has_section(section):
			continue
		var cards := []
		for card_index in CARD_COUNT:
			var key := "card_%02d" % (card_index + 1)
			cards.append(_sanitize_keno_pick_list(config.get_value(section, key, [])))
		saved_card_groups[i] = {
			"name": _sanitize_saved_group_name(str(config.get_value(section, "name", _default_group_name(i))), i),
			"cards": cards,
			"saved_at": str(config.get_value(section, "saved_at", "")),
		}


func _save_saved_card_groups() -> bool:
	var config := ConfigFile.new()
	for i in SAVED_KENO_GROUP_COUNT:
		var group: Dictionary = saved_card_groups[i]
		var section := "group_%02d" % (i + 1)
		config.set_value(section, "name", _sanitize_saved_group_name(str(group.get("name", _default_group_name(i))), i))
		config.set_value(section, "saved_at", str(group.get("saved_at", "")))
		var cards: Array = group.get("cards", [])
		for card_index in CARD_COUNT:
			var key := "card_%02d" % (card_index + 1)
			config.set_value(section, key, _sanitize_keno_pick_list(cards[card_index] if card_index < cards.size() else []))

	return config.save(SAVED_KENO_GROUPS_PATH) == OK


func _sanitize_keno_pick_list(values) -> Array:
	var picks := []
	for value in values:
		var number := int(value)
		if number < 1 or number > NUMBER_MAX:
			continue
		if picks.has(number):
			continue
		picks.append(number)
		if picks.size() >= MAX_PICKS_PER_CARD:
			break
	picks.sort()
	return picks


func _get_selected_patch_size() -> int:
	if patch_size_option == null or patch_size_option.selected < 0:
		return 3
	return clampi(patch_size_option.get_selected_id(), 3, 4)


func _get_selected_coverage_wheel_id() -> int:
	if coverage_wheel_option == null or coverage_wheel_option.selected < 0:
		return KENO_WHEEL_AUTO
	return int(coverage_wheel_option.get_selected_id())


func _on_coverage_wheel_selected(_index: int) -> void:
	var wheel_id := _get_selected_coverage_wheel_id()
	if wheel_id == KENO_WHEEL_AUTO:
		if patch_size_option != null:
			patch_size_option.disabled = false
		if optimizer_pick_count_spin != null:
			optimizer_pick_count_spin.editable = true
		return

	var config := _get_coverage_wheel_config(wheel_id)
	if patch_size_option != null:
		patch_size_option.disabled = true
		for i in patch_size_option.item_count:
			if int(patch_size_option.get_item_id(i)) == int(config["patch_size"]):
				patch_size_option.select(i)
				break
	if optimizer_pick_count_spin != null:
		optimizer_pick_count_spin.editable = false
		var common_count := _common_pattern_pick_count(config["patterns"])
		if common_count > 0:
			optimizer_pick_count_spin.value = float(common_count)


func _get_coverage_wheel_config(wheel_id: int) -> Dictionary:
	match wheel_id:
		KENO_WHEEL_3X3_5:
			return {
				"name": "3x3 5-spot wheel",
				"patch_size": 3,
				"patterns": KENO_3X3_5_SPOT_COVERAGE_PATTERNS,
			}
		KENO_WHEEL_3X3_4:
			return {
				"name": "3x3 4-spot wheel",
				"patch_size": 3,
				"patterns": KENO_3X3_4_SPOT_COVERAGE_PATTERNS,
			}
		KENO_WHEEL_4X4_4:
			return {
				"name": "4x4 4-spot wheel",
				"patch_size": 4,
				"patterns": KENO_4X4_4_SPOT_COVERAGE_PATTERNS,
			}
		KENO_WHEEL_4X4_5:
			return {
				"name": "4x4 5-spot wheel",
				"patch_size": 4,
				"patterns": KENO_4X4_5_SPOT_COVERAGE_PATTERNS,
			}
		KENO_WHEEL_4X4_MIXED:
			return {
				"name": "4x4 mixed 4/5 wheel",
				"patch_size": 4,
				"patterns": KENO_4X4_MIXED_COVERAGE_PATTERNS,
			}
	return {
		"name": "3x3 5-spot wheel",
		"patch_size": 3,
		"patterns": KENO_3X3_5_SPOT_COVERAGE_PATTERNS,
	}


func _get_selected_optimizer_pick_count(patch_size: int) -> int:
	var max_spots := mini(MAX_PICKS_PER_CARD, patch_size * patch_size)
	if optimizer_pick_count_spin == null:
		return clampi(KENO_DEFAULT_OPTIMIZER_PICK_COUNT, 1, max_spots)
	return clampi(int(optimizer_pick_count_spin.value), 1, max_spots)


func _build_best_keno_group_for_patch_size(patch_size: int, requested_pick_count := KENO_DEFAULT_OPTIMIZER_PICK_COUNT) -> Dictionary:
	patch_size = clampi(patch_size, 3, 4)
	var best_patch := _find_best_patch(patch_size)
	var patch_numbers: Array = best_patch["numbers"]
	var pick_count := clampi(requested_pick_count, 1, mini(MAX_PICKS_PER_CARD, patch_numbers.size()))
	var candidates := _rank_patch_patterns(patch_numbers, pick_count, int(best_patch["row"]), int(best_patch["column"]), patch_size)
	var cards := []
	for i in CARD_COUNT:
		var pattern: Array = candidates[i % candidates.size()]
		cards.append(pattern.duplicate())

	return {
		"patch_size": patch_size,
		"row": best_patch["row"],
		"column": best_patch["column"],
		"numbers": patch_numbers,
		"cards": cards,
		"pick_count": pick_count,
		"expected_multiplier": _expected_payout_multiplier(pick_count),
	}


func _build_coverage_wheel_cards(patch_numbers: Array, patterns: Array) -> Array:
	var cards := []
	for pattern_value in patterns:
		var pattern: Array = pattern_value
		var picks := []
		for offset_value in pattern:
			var offset := int(offset_value)
			if offset >= 0 and offset < patch_numbers.size():
				picks.append(int(patch_numbers[offset]))
		picks.sort()
		if not picks.is_empty():
			cards.append(picks)
	while cards.size() < CARD_COUNT and not cards.is_empty():
		cards.append(cards[cards.size() % cards.size()].duplicate())
	return cards


func _common_pattern_pick_count(patterns: Array) -> int:
	if patterns.is_empty():
		return 0
	var first_size := -1
	for pattern_value in patterns:
		var pattern: Array = pattern_value
		if first_size < 0:
			first_size = pattern.size()
		elif pattern.size() != first_size:
			return 0
	return first_size


func _common_card_pick_count(cards: Array) -> int:
	if cards.is_empty():
		return 0
	var first_size := -1
	for picks_value in cards:
		var picks: Array = picks_value
		if first_size < 0:
			first_size = picks.size()
		elif picks.size() != first_size:
			return 0
	return first_size


func _coverage_cards_spot_label(cards: Array) -> String:
	var counts := {}
	for picks_value in cards:
		var picks: Array = picks_value
		var spots := picks.size()
		counts[spots] = int(counts.get(spots, 0)) + 1
	var spot_counts := counts.keys()
	spot_counts.sort()
	var parts := []
	for spots in spot_counts:
		parts.append("%d x %d-spot" % [int(counts[spots]), int(spots)])
	return ", ".join(parts)


func _average_expected_payout_multiplier(cards: Array) -> float:
	if cards.is_empty():
		return 0.0
	var total := 0.0
	for picks_value in cards:
		var picks: Array = picks_value
		total += _expected_payout_multiplier(picks.size())
	return total / float(cards.size())


func _find_best_patch(patch_size: int) -> Dictionary:
	var best := {
		"score": -INF,
		"row": 0,
		"column": 0,
		"numbers": [],
	}
	for row in range(0, 8 - patch_size + 1):
		for column in range(0, 10 - patch_size + 1):
			var numbers := _patch_numbers(row, column, patch_size)
			var score := _patch_history_score(numbers) - _patch_center_distance(row, column, patch_size) * 0.01
			if score > float(best["score"]):
				best = {
					"score": score,
					"row": row,
					"column": column,
					"numbers": numbers,
				}
	return best


func _patch_numbers(row: int, column: int, patch_size: int) -> Array:
	var numbers := []
	for r in range(row, row + patch_size):
		for c in range(column, column + patch_size):
			numbers.append(r * 10 + c + 1)
	return numbers


func _patch_history_score(numbers: Array) -> float:
	var score := 0.0
	for number in numbers:
		score += float(number_hit_counts[int(number)])
	return score


func _patch_center_distance(row: int, column: int, patch_size: int) -> float:
	var patch_center := Vector2(float(column) + float(patch_size - 1) * 0.5, float(row) + float(patch_size - 1) * 0.5)
	var board_center := Vector2(4.5, 3.5)
	return patch_center.distance_to(board_center)


func _rank_patch_patterns(patch_numbers: Array, pick_count: int, row: int, column: int, patch_size: int) -> Array:
	if patch_size == 3 and pick_count == 5:
		var stacked := _build_coverage_wheel_cards(patch_numbers, KENO_3X3_5_SPOT_COVERAGE_PATTERNS)
		if not stacked.is_empty():
			return stacked
	if patch_size == 3 and pick_count == 4:
		var stacked := _build_coverage_wheel_cards(patch_numbers, KENO_3X3_4_SPOT_COVERAGE_PATTERNS)
		if not stacked.is_empty():
			return stacked
	if patch_size == 4 and pick_count == 4:
		var stacked := _build_coverage_wheel_cards(patch_numbers, KENO_4X4_4_SPOT_COVERAGE_PATTERNS)
		if not stacked.is_empty():
			return stacked
	if patch_size == 4 and pick_count == 5:
		var stacked := _build_coverage_wheel_cards(patch_numbers, KENO_4X4_5_SPOT_COVERAGE_PATTERNS)
		if not stacked.is_empty():
			return stacked

	var weighted_numbers := patch_numbers.duplicate()
	weighted_numbers.sort_custom(func(a, b) -> bool:
		var score_a := _patch_number_weight(int(a), row, column, patch_size)
		var score_b := _patch_number_weight(int(b), row, column, patch_size)
		if is_equal_approx(score_a, score_b):
			return int(a) < int(b)
		return score_a > score_b
	)

	var core := weighted_numbers.slice(0, pick_count)
	core.sort()
	var combinations := []
	_collect_patch_combinations(weighted_numbers, pick_count, 0, [], combinations)
	combinations.sort_custom(func(a, b) -> bool:
		var overlap_a := _count_pattern_overlap(a, core)
		var overlap_b := _count_pattern_overlap(b, core)
		if overlap_a != overlap_b:
			return overlap_a > overlap_b
		var score_a := _pattern_weight(a, row, column, patch_size)
		var score_b := _pattern_weight(b, row, column, patch_size)
		if is_equal_approx(score_a, score_b):
			return _number_list_key(a) < _number_list_key(b)
		return score_a > score_b
	)

	var ranked := []
	for combo in combinations:
		var picks: Array = combo
		picks.sort()
		ranked.append(picks)
		if ranked.size() >= CARD_COUNT:
			break
	if ranked.is_empty():
		ranked.append(core)
	return ranked


func _build_3x3_5_spot_stack_patterns(patch_numbers: Array) -> Array:
	return _build_coverage_wheel_cards(patch_numbers, KENO_3X3_5_SPOT_COVERAGE_PATTERNS)


func _collect_patch_combinations(values: Array, pick_count: int, start: int, current: Array, output: Array) -> void:
	if current.size() == pick_count:
		output.append(current.duplicate())
		return
	var needed := pick_count - current.size()
	for i in range(start, values.size() - needed + 1):
		current.append(values[i])
		_collect_patch_combinations(values, pick_count, i + 1, current, output)
		current.pop_back()


func _patch_number_weight(number: int, row: int, column: int, patch_size: int) -> float:
	var local_row := int((number - 1) / 10) - row
	var local_column := int((number - 1) % 10) - column
	var center := (float(patch_size) - 1.0) * 0.5
	var distance := Vector2(float(local_column), float(local_row)).distance_to(Vector2(center, center))
	return float(number_hit_counts[number]) * 100.0 + (10.0 - distance)


func _pattern_weight(pattern: Array, row: int, column: int, patch_size: int) -> float:
	var score := 0.0
	for number in pattern:
		score += _patch_number_weight(int(number), row, column, patch_size)
	return score


func _count_pattern_overlap(a: Array, b: Array) -> int:
	var count := 0
	for number in a:
		if b.has(number):
			count += 1
	return count


func _number_list_key(numbers: Array) -> String:
	var parts := []
	var sorted := numbers.duplicate()
	sorted.sort()
	for number in sorted:
		parts.append("%02d" % int(number))
	return "-".join(parts)


func _expected_payout_multiplier(spots: int) -> float:
	var expected := 0.0
	for matches in range(0, spots + 1):
		var multiplier := _get_payout_multiplier(spots, matches)
		if multiplier <= 0:
			continue
		var probability := _combination_float(spots, matches) * _combination_float(NUMBER_MAX - spots, DRAW_COUNT - matches) / _combination_float(NUMBER_MAX, DRAW_COUNT)
		expected += probability * float(multiplier)
	return expected


func _combination_float(n: int, k: int) -> float:
	if k < 0 or k > n:
		return 0.0
	k = mini(k, n - k)
	if k == 0:
		return 1.0
	var result := 1.0
	for i in range(1, k + 1):
		result *= float(n - k + i) / float(i)
	return result


func _append_keno_run_log(entry: Dictionary) -> bool:
	var is_new := not FileAccess.file_exists(KENO_RUN_LOG_PATH)
	var file := FileAccess.open(KENO_RUN_LOG_PATH, FileAccess.WRITE if is_new else FileAccess.READ_WRITE)
	if file == null:
		return false
	if not is_new:
		file.seek_end()
	else:
		file.store_line(",".join([
			"timestamp",
			"mode",
			"group_index",
			"group_name",
			"round",
			"active_cards",
			"bet",
			"wagered",
			"paid",
			"net",
			"hits",
			"draw",
			"cards",
		]))

	file.store_line(",".join([
		_csv_cell(entry.get("timestamp", "")),
		_csv_cell(entry.get("mode", "")),
		_csv_cell(entry.get("group_index", -1)),
		_csv_cell(entry.get("group_name", "")),
		_csv_cell(entry.get("round", 0)),
		_csv_cell(entry.get("active_cards", 0)),
		_csv_cell("%.2f" % float(entry.get("bet", 0.0))),
		_csv_cell("%.2f" % float(entry.get("wagered", 0.0))),
		_csv_cell("%.2f" % float(entry.get("paid", 0.0))),
		_csv_cell("%.2f" % float(entry.get("net", 0.0))),
		_csv_cell(entry.get("hits", 0)),
		_csv_cell(_number_list_for_log(entry.get("draw", []))),
		_csv_cell(_card_results_for_log(entry.get("cards", []))),
	]))
	return true


func _csv_cell(value) -> String:
	var text := str(value)
	text = text.replace("\"", "\"\"")
	if text.contains(",") or text.contains("\"") or text.contains("\n") or text.contains("\r"):
		return "\"%s\"" % text
	return text


func _number_list_for_log(numbers: Array) -> String:
	var parts := []
	for number in numbers:
		parts.append(str(int(number)))
	return " ".join(parts)


func _card_results_for_log(cards: Array) -> String:
	var parts := []
	for card_value in cards:
		var card: Dictionary = card_value
		parts.append("%s:%d/%d:%.0fx:$%.2f:[%s]" % [
			str(card.get("card", "?")),
			int(card.get("matches", 0)),
			int(card.get("spots", 0)),
			float(card.get("multiplier", 0.0)),
			float(card.get("paid", 0.0)),
			_number_list_for_log(card.get("picks", [])),
		])
	return "; ".join(parts)


func _write_keno_best_group_cheat_sheet(best: Dictionary, group_index: int, group_name: String) -> String:
	var lines := []
	var patch_size := int(best["patch_size"])
	var row := int(best["row"])
	var column := int(best["column"])
	var patch_numbers: Array = best["numbers"]
	var cards: Array = best["cards"]
	lines.append("20 Card Keno Cheat Sheet")
	lines.append("Saved group: %d - %s" % [group_index + 1, group_name])
	lines.append("Patch: %dx%d, rows %d-%d, columns %d-%d" % [
		patch_size,
		patch_size,
		row + 1,
		row + patch_size,
		column + 1,
		column + patch_size,
	])
	lines.append("Patch numbers: %s" % _number_list_for_log(patch_numbers))
	lines.append("Cards: %s. Average expected pay multiplier per $1 card: %.4f" % [
		str(best.get("spot_label", "%d-spot" % int(best.get("pick_count", 0)))),
		float(best["expected_multiplier"]),
	])
	lines.append("")
	lines.append("Card patterns")
	for i in CARD_COUNT:
		var picks: Array = cards[i]
		lines.append("%s: %s" % [_card_label(i), _number_list_for_log(picks)])
	lines.append("")
	lines.append("Copy-ready ticket list")
	lines.append(_format_keno_ticket_copy_line(cards))
	lines.append("")
	lines.append("10 by 8 board map. Numbers in brackets are in the patch.")
	for r in range(0, 8):
		var row_parts := []
		for c in range(0, 10):
			var number := r * 10 + c + 1
			if patch_numbers.has(number):
				row_parts.append("[%02d]" % number)
			else:
				row_parts.append(" %02d " % number)
		lines.append(" ".join(row_parts))
	lines.append("")
	lines.append("Overlap count by number across all 20 cards")
	var overlap_counts := {}
	for picks in cards:
		for number in picks:
			overlap_counts[number] = int(overlap_counts.get(number, 0)) + 1
	var overlap_numbers := overlap_counts.keys()
	overlap_numbers.sort()
	var overlap_parts := []
	for number in overlap_numbers:
		overlap_parts.append("%02d:%d" % [int(number), int(overlap_counts[number])])
	lines.append(", ".join(overlap_parts))
	lines.append("")
	lines.append("Note: Keno draws are random, so no patch changes the true odds. This sheet favors maximum overlap and the highest payout spot count available inside the chosen patch.")

	var file := FileAccess.open(KENO_CHEAT_SHEET_PATH, FileAccess.WRITE)
	if file != null:
		file.store_string("\n".join(lines))
	return KENO_CHEAT_SHEET_PATH


func _format_keno_ticket_copy_line(cards: Array) -> String:
	var parts := []
	for i in min(CARD_COUNT, cards.size()):
		var picks: Array = cards[i]
		parts.append("[%s-%s]" % [_card_label(i), _number_list_for_copy(picks)])
	return " ".join(parts)


func _number_list_for_copy(numbers: Array) -> String:
	var parts := []
	for number in numbers:
		parts.append(str(int(number)))
	return ",".join(parts)


func _get_poker_hand_count() -> int:
	if poker_hand_count_option == null or poker_hand_count_option.selected < 0:
		return clampi(poker_hand_count, 1, SPIN_POKER_LINE_PATTERNS.size())
	poker_hand_count = int(poker_hand_count_option.get_selected_id())
	poker_hand_count = clampi(poker_hand_count, 1, SPIN_POKER_LINE_PATTERNS.size())
	return poker_hand_count


func _active_poker_line_count() -> int:
	return clampi(poker_hand_count, 1, SPIN_POKER_LINE_PATTERNS.size())


func _active_poker_hand_count() -> int:
	return _active_poker_line_count()


func _display_poker_hand_count() -> int:
	if not poker_cards.is_empty() or not poker_hands.is_empty():
		return SPIN_POKER_ROWS
	return 1


func _refresh_poker_hand_count_option() -> void:
	if poker_hand_count_option == null:
		return
	for i in poker_hand_count_option.item_count:
		if int(poker_hand_count_option.get_item_id(i)) == poker_hand_count:
			poker_hand_count_option.select(i)
			return


func _poker_card_size_for_hand_count(hand_count: int) -> Vector2:
	match hand_count:
		1:
			return Vector2(160, 240)
		3:
			return Vector2(125, 188)
		5:
			return Vector2(96, 144)
		_:
			return Vector2(78, 117)


func _poker_display_hand_for_index(hand_index: int) -> Array:
	if hand_index >= 0 and hand_index < poker_hands.size():
		if poker_waiting_for_draw:
			var waiting_row := []
			for card_index in POKER_HAND_SIZE:
				if hand_index == SPIN_POKER_CENTER_ROW or bool(poker_hold[card_index]):
					waiting_row.append(poker_cards[card_index])
				else:
					waiting_row.append({})
			return waiting_row
		return poker_hands[hand_index]
	return []


func _spin_poker_line_cards(line_index: int) -> Array:
	var cards := []
	if line_index < 0 or line_index >= SPIN_POKER_LINE_PATTERNS.size():
		return cards
	var pattern: Array = SPIN_POKER_LINE_PATTERNS[line_index]
	for card_index in POKER_HAND_SIZE:
		var row_index := int(pattern[card_index])
		if row_index < 0 or row_index >= poker_hands.size():
			continue
		var row: Array = poker_hands[row_index]
		if card_index < row.size():
			cards.append(row[card_index])
	return cards


func _refresh_poker() -> void:
	if poker_bankroll_label == null:
		return

	var net := poker_total_paid - poker_total_wagered
	poker_bankroll_label.text = "Credits: $%.2f  |  Lines played: %d  |  Net: %s" % [
		poker_credits,
		poker_hands_played,
		_format_signed_money(net),
	]

	poker_deal_button.disabled = poker_waiting_for_draw
	poker_draw_button.disabled = not poker_waiting_for_draw
	poker_bet_spin.editable = not poker_waiting_for_draw
	if poker_hand_count_option != null:
		poker_hand_count_option.disabled = poker_waiting_for_draw
		_refresh_poker_hand_count_option()
	_refresh_poker_action_button_styles()

	var active_line_count := _active_poker_line_count()
	var display_hand_count := _display_poker_hand_count()
	if poker_card_grid != null:
		poker_card_grid.add_theme_constant_override("h_separation", 10 if display_hand_count <= 3 else 7)
		poker_card_grid.add_theme_constant_override("v_separation", 8 if display_hand_count <= 3 else 5)
	if poker_hands.is_empty():
		poker_status_label.text = "Deal the middle row for %d active line%s." % [active_line_count, "" if active_line_count == 1 else "s"]
	else:
		poker_status_label.text = "Choose holds on the middle row; held cards copy to the top and bottom rows." if poker_waiting_for_draw else "Spin complete. Deal again when ready."

	var tip := _get_poker_strategy_tip(poker_cards) if poker_waiting_for_draw else {}
	var suggested_holds: Array = tip.get("holds", [])
	if poker_tip_label != null:
		if poker_waiting_for_draw and not tip.is_empty():
			poker_tip_label.text = str(tip["text"])
		elif poker_hands.is_empty():
			poker_tip_label.text = "Tip: deal a hand to get a hold suggestion."
		else:
			poker_tip_label.text = "Tip: deal again for the next hand suggestion."

	for i in poker_card_buttons.size():
		var button: Button = poker_card_buttons[i]
		var hand_index := int(i / POKER_HAND_SIZE)
		var card_index := int(i % POKER_HAND_SIZE)
		var display_hand: Array = _poker_display_hand_for_index(hand_index)
		var card: Dictionary = {}
		if card_index < display_hand.size() and display_hand[card_index] is Dictionary:
			card = display_hand[card_index]
		var has_card: bool = not card.is_empty()
		var visible_slot: bool = hand_index < max(1, display_hand_count)
		var can_choose_hold := has_card and poker_waiting_for_draw
		button.visible = visible_slot
		button.disabled = not has_card
		button.mouse_filter = Control.MOUSE_FILTER_STOP if can_choose_hold else Control.MOUSE_FILTER_IGNORE
		button.focus_mode = Control.FOCUS_ALL if can_choose_hold else Control.FOCUS_NONE
		button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND if can_choose_hold else Control.CURSOR_ARROW
		button.custom_minimum_size = _poker_card_size_for_hand_count(display_hand_count)
		button.pivot_offset = button.size * 0.5
		button.rotation_degrees = 0.0 if display_hand_count > 1 else (POKER_CARD_ROTATIONS[card_index] if card_index < POKER_CARD_ROTATIONS.size() else 0.0)
		button.scale = Vector2(1.0, 1.0)
		if has_card:
			var held: bool = bool(poker_hold[card_index])
			var texture := _get_poker_card_texture(card)
			var suit_color := _poker_suit_color(str(card["suit"]))
			var bg := Color("#f7f1e7") if not held else Color("#ffdc74")
			var border := suit_color if not held else Color("#fff7c9")
			var suggested: bool = poker_waiting_for_draw and suggested_holds.has(card_index)
			if suggested and not held:
				border = Color("#69e3ff")
			if held and display_hand_count <= 5:
				button.scale = Vector2(1.035, 1.035)
			if texture != null:
				button.icon = texture
				button.text = ""
			else:
				button.icon = null
				button.text = "%s\n%s" % [_rank_label(int(card["rank"])), str(card["suit"])]
			button.tooltip_text = "%s of %s%s" % [
				_rank_label(int(card["rank"])),
				_poker_suit_name(str(card["suit"])),
				" held" if held else "",
			]
			button.add_theme_stylebox_override("normal", _poker_card_style(bg, border, 4 if suggested or held else 2, held or suggested))
			button.add_theme_stylebox_override("hover", _poker_card_style(bg.lightened(0.04), Color("#ffffff"), 4, true))
			button.add_theme_stylebox_override("pressed", _poker_card_style(bg.darkened(0.04), Color("#ffffff"), 4, true, true))
			button.add_theme_color_override("font_color", suit_color)
			button.add_theme_font_size_override("font_size", max(16, int(button.custom_minimum_size.y * 0.12)))
		else:
			button.icon = null
			button.text = "" if not poker_hands.is_empty() or not poker_cards.is_empty() else "CARD\n%d" % (card_index + 1)
			button.tooltip_text = "Empty card slot"
			button.add_theme_stylebox_override("normal", _poker_card_style(Color("#25352f"), Color("#4a5f55"), 2, false))
			button.add_theme_stylebox_override("hover", _poker_card_style(Color("#2d4038"), Color("#f6f0df"), 3, false))
			button.add_theme_stylebox_override("pressed", _poker_card_style(Color("#2d4038"), Color("#ffffff"), 3, false, true))
			button.add_theme_color_override("font_color", Color("#cad1df"))
			button.add_theme_font_size_override("font_size", max(14, int(button.custom_minimum_size.y * 0.12)))
		_apply_button_text_depth(button)

	poker_paytable_label.text = _format_poker_paytable()


func _refresh_poker_action_button_styles() -> void:
	if poker_deal_button == null or poker_draw_button == null:
		return

	_apply_poker_action_button_style(poker_deal_button, not poker_deal_button.disabled, Color("#2f8f5b"))
	_apply_poker_action_button_style(poker_draw_button, not poker_draw_button.disabled, Color("#336b9d"))


func _apply_poker_action_button_style(button: Button, active: bool, color: Color) -> void:
	var bg := color if active else Color("#2a3038")
	var border := Color("#f6f0df") if active else Color("#3b4450")
	button.add_theme_stylebox_override("normal", _poker_action_button_style(bg, border, active))
	button.add_theme_stylebox_override("hover", _poker_action_button_style(bg.lightened(0.08), Color("#ffffff"), active))
	button.add_theme_stylebox_override("pressed", _poker_action_button_style(bg.darkened(0.08), Color("#ffffff"), active, true))
	button.add_theme_color_override("font_color", Color("#ffffff") if active else Color("#8f98a8"))


func _refresh_pai_gow() -> void:
	if pai_gow_bankroll_label == null:
		return

	var net := pai_gow_total_paid - pai_gow_total_wagered
	pai_gow_bankroll_label.text = "Credits: $%.2f  |  Hands: %d  |  Net: %s" % [
		pai_gow_credits,
		pai_gow_hands_played,
		_format_signed_money(net),
	]

	pai_gow_deal_button.disabled = pai_gow_in_round
	pai_gow_house_way_button.disabled = not pai_gow_in_round
	pai_gow_set_button.disabled = not pai_gow_in_round or pai_gow_low_indices.size() != 2
	pai_gow_bet_spin.editable = not pai_gow_in_round
	_apply_poker_action_button_style(pai_gow_deal_button, not pai_gow_deal_button.disabled, Color("#2f8f5b"))
	_apply_poker_action_button_style(pai_gow_house_way_button, not pai_gow_house_way_button.disabled, Color("#9d6b33"))
	_apply_poker_action_button_style(pai_gow_set_button, not pai_gow_set_button.disabled, Color("#336b9d"))

	if pai_gow_player_cards.is_empty():
		pai_gow_status_label.text = "Deal seven cards, then set a two-card Low hand."
		pai_gow_tip_label.text = "Tip: House Way will make a balanced automatic split."
		pai_gow_player_low_label.text = "Player Low"
		pai_gow_player_high_label.text = "Player High"
		pai_gow_dealer_low_label.text = "Dealer Low"
		pai_gow_dealer_high_label.text = "Dealer High"
	else:
		pai_gow_status_label.text = "Click two cards for Low. The other five become High." if pai_gow_in_round else "Hand complete. Deal again when ready."
		pai_gow_tip_label.text = _pai_gow_tip_text()

	var player_split := _pai_gow_split_from_indices(pai_gow_player_cards, pai_gow_low_indices)
	var dealer_split := {}
	if pai_gow_reveal_dealer and not pai_gow_dealer_cards.is_empty():
		dealer_split = _pai_gow_split_from_indices(pai_gow_dealer_cards, _pai_gow_house_way_low_indices(pai_gow_dealer_cards))

	if not player_split.is_empty():
		pai_gow_player_low_label.text = "Player Low: %s" % _pai_gow_eval_name(_pai_gow_evaluate_two_card(player_split["low"]))
		pai_gow_player_high_label.text = "Player High: %s" % _pai_gow_eval_name(_pai_gow_evaluate_five_card(player_split["high"]))
	else:
		pai_gow_player_low_label.text = "Player Low: choose 2 cards"
		pai_gow_player_high_label.text = "Player High: remaining 5 cards"

	if dealer_split.is_empty():
		pai_gow_dealer_low_label.text = "Dealer Low: hidden"
		pai_gow_dealer_high_label.text = "Dealer High: hidden"
	else:
		pai_gow_dealer_low_label.text = "Dealer Low: %s" % _pai_gow_eval_name(_pai_gow_evaluate_two_card(dealer_split["low"]))
		pai_gow_dealer_high_label.text = "Dealer High: %s" % _pai_gow_eval_name(_pai_gow_evaluate_five_card(dealer_split["high"]))

	_refresh_pai_gow_selection_row()
	_refresh_pai_gow_split_row(pai_gow_player_low_row, player_split.get("low", []), false)
	_refresh_pai_gow_split_row(pai_gow_player_high_row, player_split.get("high", []), false)
	_refresh_pai_gow_split_row(pai_gow_dealer_low_row, dealer_split.get("low", []), not pai_gow_reveal_dealer)
	_refresh_pai_gow_split_row(pai_gow_dealer_high_row, dealer_split.get("high", []), not pai_gow_reveal_dealer)


func _refresh_pai_gow_selection_row() -> void:
	for child in pai_gow_selection_row.get_children():
		pai_gow_selection_row.remove_child(child)
		child.queue_free()

	if pai_gow_player_cards.is_empty():
		pai_gow_selection_row.add_child(_build_pai_gow_placeholder_card("PAI GOW"))
		return

	for i in pai_gow_player_cards.size():
		pai_gow_selection_row.add_child(_build_pai_gow_card_button(pai_gow_player_cards[i], i, pai_gow_low_indices.has(i), pai_gow_in_round))


func _refresh_pai_gow_split_row(row: HBoxContainer, cards: Array, hidden: bool) -> void:
	for child in row.get_children():
		row.remove_child(child)
		child.queue_free()

	if cards.is_empty():
		row.add_child(_build_pai_gow_placeholder_card("HIDDEN" if hidden else "WAITING"))
		return

	for i in cards.size():
		row.add_child(_build_pai_gow_card_button(cards[i], i, false, false, hidden))


func _build_pai_gow_card_button(card: Dictionary, index: int, selected: bool, selectable: bool, hidden := false) -> Button:
	var button := Button.new()
	button.custom_minimum_size = PAI_GOW_CARD_DISPLAY_SIZE
	button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	button.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	button.disabled = not selectable
	button.expand_icon = true
	button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	button.vertical_icon_alignment = VERTICAL_ALIGNMENT_CENTER
	button.pivot_offset = PAI_GOW_CARD_DISPLAY_SIZE * 0.5
	button.rotation_degrees = PAI_GOW_CARD_ROTATIONS[index] if index < PAI_GOW_CARD_ROTATIONS.size() else 0.0
	if selectable:
		button.pressed.connect(_on_pai_gow_card_pressed.bind(index))

	if hidden:
		button.text = "?"
		button.icon = null
		button.tooltip_text = "Dealer card"
		button.add_theme_font_size_override("font_size", 42)
		button.add_theme_color_override("font_color", Color("#f6f0df"))
		button.add_theme_stylebox_override("normal", _poker_card_style(Color("#26314a"), Color("#6576b4"), 3, true))
	else:
		var texture := _get_poker_card_texture(card)
		if texture != null:
			button.icon = texture
			button.text = ""
		else:
			button.text = "%s\n%s" % [_rank_label(int(card["rank"])), str(card["suit"])]
		button.tooltip_text = "%s of %s%s" % [
			_rank_label(int(card["rank"])),
			_poker_suit_name(str(card["suit"])),
			" in Low" if selected else "",
		]
		var bg := Color("#ffdc74") if selected else Color("#f7f1e7")
		var border := Color("#fff7c9") if selected else _poker_suit_color(str(card["suit"]))
		button.add_theme_color_override("font_color", _poker_suit_color(str(card["suit"])))
		button.add_theme_font_size_override("font_size", 24)
		button.add_theme_stylebox_override("normal", _poker_card_style(bg, border, 4 if selected else 2, selected))
		button.add_theme_stylebox_override("hover", _poker_card_style(bg.lightened(0.04), Color("#ffffff"), 4, true))
		button.add_theme_stylebox_override("pressed", _poker_card_style(bg.darkened(0.04), Color("#ffffff"), 4, true, true))
	_apply_button_text_depth(button)
	return button


func _build_pai_gow_placeholder_card(text: String) -> Button:
	var button := Button.new()
	button.custom_minimum_size = PAI_GOW_CARD_DISPLAY_SIZE
	button.disabled = true
	button.text = text
	button.add_theme_font_size_override("font_size", 18)
	button.add_theme_color_override("font_color", Color("#cad1df"))
	button.add_theme_stylebox_override("normal", _poker_card_style(Color("#25352f"), Color("#4a5f55"), 2, false))
	_apply_button_text_depth(button)
	return button


func _refresh_blackjack() -> void:
	if blackjack_bankroll_label == null:
		return

	var net := blackjack_total_paid - blackjack_total_wagered
	blackjack_bankroll_label.text = "Credits: $%.2f  |  Hands: %d  |  Net: %s" % [
		blackjack_credits,
		blackjack_hands_played,
		_format_signed_money(net),
	]

	blackjack_deal_button.disabled = blackjack_in_round
	blackjack_hit_button.disabled = not blackjack_in_round
	blackjack_stand_button.disabled = not blackjack_in_round
	blackjack_bet_spin.editable = not blackjack_in_round
	_refresh_blackjack_action_button_styles()

	if blackjack_player_cards.is_empty():
		blackjack_status_label.text = "Deal a Blackjack hand."
	else:
		blackjack_status_label.text = "Dealer stands on 17. Blackjack pays 3:2." if blackjack_in_round else "Hand complete. Deal again when ready."

	blackjack_dealer_total_label.text = _blackjack_dealer_total_text()
	blackjack_player_total_label.text = _blackjack_hand_total_text("Player", blackjack_player_cards)
	blackjack_tip_label.text = _get_blackjack_strategy_tip()
	_refresh_blackjack_card_row(blackjack_dealer_row, blackjack_dealer_cards, blackjack_in_round, true)
	_refresh_blackjack_card_row(blackjack_player_row, blackjack_player_cards, false, false)


func _refresh_blackjack_card_row(row: HBoxContainer, cards: Array, hide_second_card: bool, dealer: bool) -> void:
	for child in row.get_children():
		row.remove_child(child)
		child.queue_free()

	if cards.is_empty():
		row.add_child(_build_blackjack_placeholder_card("DEALER" if dealer else "PLAYER"))
		return

	for i in cards.size():
		row.add_child(_build_blackjack_card_button(cards[i], hide_second_card and i == 1, i))


func _build_blackjack_card_button(card: Dictionary, hidden: bool, index: int) -> Button:
	var button := Button.new()
	button.custom_minimum_size = BLACKJACK_CARD_DISPLAY_SIZE
	button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	button.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	button.disabled = true
	button.expand_icon = true
	button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	button.vertical_icon_alignment = VERTICAL_ALIGNMENT_CENTER
	button.pivot_offset = BLACKJACK_CARD_DISPLAY_SIZE * 0.5
	button.rotation_degrees = BLACKJACK_CARD_ROTATIONS[index] if index < BLACKJACK_CARD_ROTATIONS.size() else 0.0
	if hidden:
		button.icon = null
		button.text = "?"
		button.tooltip_text = "Dealer hole card"
		button.add_theme_font_size_override("font_size", 42)
		button.add_theme_color_override("font_color", Color("#f6f0df"))
		button.add_theme_stylebox_override("normal", _poker_card_style(Color("#26314a"), Color("#6576b4"), 3, true))
	else:
		var texture := _get_poker_card_texture(card)
		if texture != null:
			button.icon = texture
			button.text = ""
		else:
			button.text = "%s\n%s" % [_rank_label(int(card["rank"])), str(card["suit"])]
		button.tooltip_text = "%s of %s" % [_rank_label(int(card["rank"])), _poker_suit_name(str(card["suit"]))]
		button.add_theme_color_override("font_color", _poker_suit_color(str(card["suit"])))
		button.add_theme_font_size_override("font_size", 28)
		button.add_theme_stylebox_override("normal", _poker_card_style(Color("#f7f1e7"), _poker_suit_color(str(card["suit"])), 2, false))
	_apply_button_text_depth(button)
	return button


func _build_blackjack_placeholder_card(text: String) -> Button:
	var button := Button.new()
	button.custom_minimum_size = BLACKJACK_CARD_DISPLAY_SIZE
	button.disabled = true
	button.text = text
	button.add_theme_font_size_override("font_size", 20)
	button.add_theme_color_override("font_color", Color("#cad1df"))
	button.add_theme_stylebox_override("normal", _poker_card_style(Color("#25352f"), Color("#4a5f55"), 2, false))
	_apply_button_text_depth(button)
	return button


func _refresh_blackjack_action_button_styles() -> void:
	if blackjack_deal_button == null:
		return

	_apply_poker_action_button_style(blackjack_deal_button, not blackjack_deal_button.disabled, Color("#2f8f5b"))
	_apply_poker_action_button_style(blackjack_hit_button, not blackjack_hit_button.disabled, Color("#336b9d"))
	_apply_poker_action_button_style(blackjack_stand_button, not blackjack_stand_button.disabled, Color("#9d6b33"))


func _refresh_three_card() -> void:
	if three_card_bankroll_label == null:
		return

	var net := three_card_total_paid - three_card_total_wagered
	three_card_bankroll_label.text = "Credits: $%.2f  |  Hands: %d  |  Net: %s" % [
		three_card_credits,
		three_card_hands_played,
		_format_signed_money(net),
	]

	three_card_deal_button.disabled = three_card_in_round
	three_card_play_button.disabled = not three_card_in_round
	three_card_fold_button.disabled = not three_card_in_round
	three_card_ante_spin.editable = not three_card_in_round
	three_card_pair_plus_spin.editable = not three_card_in_round
	_refresh_three_card_action_button_styles()

	if three_card_player_cards.is_empty():
		three_card_status_label.text = "Deal a 3 Card Poker hand."
		three_card_tip_label.text = "Tip: deal a hand to get a Play/Fold suggestion."
	else:
		three_card_status_label.text = "Dealer qualifies with Queen-high or better." if three_card_in_round else "Hand complete. Deal again when ready."
		three_card_tip_label.text = _get_three_card_strategy_tip()

	three_card_dealer_label.text = _three_card_hand_label("Dealer", three_card_dealer_cards, not three_card_reveal_dealer)
	three_card_player_label.text = _three_card_hand_label("Player", three_card_player_cards, false)
	_refresh_three_card_row(three_card_dealer_row, three_card_dealer_cards, not three_card_reveal_dealer)
	_refresh_three_card_row(three_card_player_row, three_card_player_cards, false)


func _refresh_three_card_row(row: HBoxContainer, cards: Array, hidden: bool) -> void:
	for child in row.get_children():
		row.remove_child(child)
		child.queue_free()

	if cards.is_empty():
		row.add_child(_build_three_card_placeholder_card())
		return

	for i in cards.size():
		row.add_child(_build_three_card_card_button(cards[i], hidden, i))


func _build_three_card_card_button(card: Dictionary, hidden: bool, index: int) -> Button:
	var button := Button.new()
	button.custom_minimum_size = THREE_CARD_DISPLAY_SIZE
	button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	button.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	button.disabled = true
	button.expand_icon = true
	button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	button.vertical_icon_alignment = VERTICAL_ALIGNMENT_CENTER
	button.pivot_offset = THREE_CARD_DISPLAY_SIZE * 0.5
	button.rotation_degrees = THREE_CARD_ROTATIONS[index] if index < THREE_CARD_ROTATIONS.size() else 0.0
	if hidden:
		button.text = "?"
		button.add_theme_font_size_override("font_size", 42)
		button.add_theme_color_override("font_color", Color("#f6f0df"))
		button.add_theme_stylebox_override("normal", _poker_card_style(Color("#26314a"), Color("#6576b4"), 3, true))
	else:
		var texture := _get_poker_card_texture(card)
		if texture != null:
			button.icon = texture
			button.text = ""
		else:
			button.text = "%s\n%s" % [_rank_label(int(card["rank"])), str(card["suit"])]
		button.add_theme_color_override("font_color", _poker_suit_color(str(card["suit"])))
		button.add_theme_font_size_override("font_size", 28)
		button.add_theme_stylebox_override("normal", _poker_card_style(Color("#f7f1e7"), _poker_suit_color(str(card["suit"])), 2, false))
	_apply_button_text_depth(button)
	return button


func _build_three_card_placeholder_card() -> Button:
	var button := Button.new()
	button.custom_minimum_size = THREE_CARD_DISPLAY_SIZE
	button.disabled = true
	button.text = "3 CARD"
	button.add_theme_font_size_override("font_size", 20)
	button.add_theme_color_override("font_color", Color("#cad1df"))
	button.add_theme_stylebox_override("normal", _poker_card_style(Color("#25352f"), Color("#4a5f55"), 2, false))
	_apply_button_text_depth(button)
	return button


func _refresh_three_card_action_button_styles() -> void:
	if three_card_deal_button == null:
		return

	_apply_poker_action_button_style(three_card_deal_button, not three_card_deal_button.disabled, Color("#2f8f5b"))
	_apply_poker_action_button_style(three_card_play_button, not three_card_play_button.disabled, Color("#336b9d"))
	_apply_poker_action_button_style(three_card_fold_button, not three_card_fold_button.disabled, Color("#9d4a33"))


func _refresh_criss_cross() -> void:
	if criss_cross_bankroll_label == null:
		return

	var net := criss_cross_total_paid - criss_cross_total_wagered
	criss_cross_bankroll_label.text = "Credits: $%.2f  |  Hands: %d  |  Net: %s" % [
		criss_cross_credits,
		criss_cross_hands_played,
		_format_signed_money(net),
	]

	var in_hand := [CRISS_CROSS_STAGE_ACROSS, CRISS_CROSS_STAGE_DOWN, CRISS_CROSS_STAGE_MIDDLE].has(criss_cross_stage)
	criss_cross_deal_button.disabled = in_hand
	criss_cross_across_button.disabled = criss_cross_stage != CRISS_CROSS_STAGE_ACROSS
	criss_cross_down_button.disabled = criss_cross_stage != CRISS_CROSS_STAGE_DOWN
	criss_cross_middle_button.disabled = criss_cross_stage != CRISS_CROSS_STAGE_MIDDLE
	criss_cross_fold_button.disabled = not in_hand
	criss_cross_ante_spin.editable = not in_hand
	criss_cross_bonus_spin.editable = not in_hand
	criss_cross_across_mult_spin.editable = criss_cross_stage == CRISS_CROSS_STAGE_ACROSS
	criss_cross_down_mult_spin.editable = criss_cross_stage == CRISS_CROSS_STAGE_DOWN
	criss_cross_middle_mult_spin.editable = criss_cross_stage == CRISS_CROSS_STAGE_MIDDLE

	_apply_poker_action_button_style(criss_cross_deal_button, not criss_cross_deal_button.disabled, Color("#2f8f5b"))
	_apply_poker_action_button_style(criss_cross_across_button, not criss_cross_across_button.disabled, Color("#336b9d"))
	_apply_poker_action_button_style(criss_cross_down_button, not criss_cross_down_button.disabled, Color("#336b9d"))
	_apply_poker_action_button_style(criss_cross_middle_button, not criss_cross_middle_button.disabled, Color("#9d6b33"))
	_apply_poker_action_button_style(criss_cross_fold_button, not criss_cross_fold_button.disabled, Color("#9d4a33"))

	match criss_cross_stage:
		CRISS_CROSS_STAGE_READY:
			criss_cross_status_label.text = "Deal two player cards and a five-card community cross."
			criss_cross_tip_label.text = "Tip: the two required antes are equal. The 5-Card Bonus is optional."
		CRISS_CROSS_STAGE_ACROSS:
			criss_cross_status_label.text = "Across decision: bet 1x-3x or fold before the horizontal outside cards are revealed."
			criss_cross_tip_label.text = _criss_cross_across_tip()
		CRISS_CROSS_STAGE_DOWN:
			criss_cross_status_label.text = "Down decision: left and right are up. Bet 1x-3x or fold."
			criss_cross_tip_label.text = "Tip: use your two cards plus the revealed horizontal cards to judge the draw."
		CRISS_CROSS_STAGE_MIDDLE:
			criss_cross_status_label.text = "Middle decision: top and bottom are up. Bet 1x-3x or fold before the center card."
			criss_cross_tip_label.text = "Tip: the Middle bet pays from the better qualifying final hand."
		_:
			criss_cross_status_label.text = "Hand complete. Deal again when ready."
			criss_cross_tip_label.text = "Tip: pairs of 6s-10s push main wagers; Jacks or Better wins."

	_refresh_criss_cross_player_row()
	_refresh_criss_cross_community_grid()
	_refresh_criss_cross_summary_labels()


func _refresh_criss_cross_player_row() -> void:
	for child in criss_cross_player_row.get_children():
		criss_cross_player_row.remove_child(child)
		child.queue_free()

	if criss_cross_player_cards.is_empty():
		criss_cross_player_row.add_child(_build_criss_cross_placeholder_card("PLAYER"))
		criss_cross_player_row.add_child(_build_criss_cross_placeholder_card("CARDS"))
		return

	for i in criss_cross_player_cards.size():
		criss_cross_player_row.add_child(_build_criss_cross_card_button(criss_cross_player_cards[i], false, i))


func _refresh_criss_cross_community_grid() -> void:
	for child in criss_cross_community_grid.get_children():
		criss_cross_community_grid.remove_child(child)
		child.queue_free()

	var grid_map := [-1, 3, -1, 0, 1, 2, -1, 4, -1]
	for cell in grid_map:
		var card_index := int(cell)
		if card_index < 0:
			criss_cross_community_grid.add_child(_build_criss_cross_blank_cell())
		elif card_index < criss_cross_community_cards.size():
			criss_cross_community_grid.add_child(_build_criss_cross_card_button(criss_cross_community_cards[card_index], not _criss_cross_community_visible(card_index), card_index))
		else:
			criss_cross_community_grid.add_child(_build_criss_cross_placeholder_card("CROSS"))


func _refresh_criss_cross_summary_labels() -> void:
	if criss_cross_community_cards.size() == 5 and criss_cross_player_cards.size() == 2 and criss_cross_stage == CRISS_CROSS_STAGE_COMPLETE:
		var across_eval := _criss_cross_across_eval()
		var down_eval := _criss_cross_down_eval()
		var bonus_eval := _criss_cross_eval_five(criss_cross_community_cards)
		criss_cross_across_label.text = "Across: %s\nAnte %s | Bet %s" % [
			str(across_eval["name"]),
			_criss_cross_outcome_text(across_eval),
			_criss_cross_play_text(across_eval),
		]
		criss_cross_down_label.text = "Down: %s\nAnte %s | Bet %s" % [
			str(down_eval["name"]),
			_criss_cross_outcome_text(down_eval),
			_criss_cross_play_text(down_eval),
		]
		criss_cross_bonus_label.text = "5-Card Bonus: %s\n%s" % [
			str(bonus_eval["name"]),
			_criss_cross_bonus_text(bonus_eval),
		]
	else:
		criss_cross_across_label.text = "Across: hidden\nUses left, center, right plus your two cards."
		criss_cross_down_label.text = "Down: hidden\nUses top, center, bottom plus your two cards."
		criss_cross_bonus_label.text = "5-Card Bonus: hidden\nUses the five community cards only."


func _build_criss_cross_card_button(card: Dictionary, hidden: bool, index: int) -> Button:
	var button := Button.new()
	button.custom_minimum_size = CRISS_CROSS_CARD_DISPLAY_SIZE
	button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	button.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	button.disabled = true
	button.expand_icon = true
	button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	button.vertical_icon_alignment = VERTICAL_ALIGNMENT_CENTER
	button.pivot_offset = CRISS_CROSS_CARD_DISPLAY_SIZE * 0.5
	if hidden:
		button.text = "?"
		button.tooltip_text = "Hidden community card"
		button.add_theme_font_size_override("font_size", 40)
		button.add_theme_color_override("font_color", Color("#f6f0df"))
		button.add_theme_stylebox_override("normal", _poker_card_style(Color("#26314a"), Color("#6576b4"), 3, true))
	else:
		var texture := _get_poker_card_texture(card)
		if texture != null:
			button.icon = texture
			button.text = ""
		else:
			button.text = "%s\n%s" % [_rank_label(int(card["rank"])), str(card["suit"])]
		button.tooltip_text = "%s of %s" % [_rank_label(int(card["rank"])), _poker_suit_name(str(card["suit"]))]
		button.add_theme_color_override("font_color", _poker_suit_color(str(card["suit"])))
		button.add_theme_font_size_override("font_size", 24)
		button.add_theme_stylebox_override("normal", _poker_card_style(Color("#f7f1e7"), _poker_suit_color(str(card["suit"])), 2, false))
	_apply_button_text_depth(button)
	return button


func _build_criss_cross_placeholder_card(text: String) -> Button:
	var button := Button.new()
	button.custom_minimum_size = CRISS_CROSS_CARD_DISPLAY_SIZE
	button.disabled = true
	button.text = text
	button.add_theme_font_size_override("font_size", 18)
	button.add_theme_color_override("font_color", Color("#cad1df"))
	button.add_theme_stylebox_override("normal", _poker_card_style(Color("#25352f"), Color("#4a5f55"), 2, false))
	_apply_button_text_depth(button)
	return button


func _build_criss_cross_blank_cell() -> Control:
	var blank := Control.new()
	blank.custom_minimum_size = CRISS_CROSS_CARD_DISPLAY_SIZE
	return blank


func _criss_cross_community_visible(index: int) -> bool:
	if criss_cross_stage == CRISS_CROSS_STAGE_COMPLETE:
		return true
	if criss_cross_stage == CRISS_CROSS_STAGE_DOWN and [0, 2].has(index):
		return true
	if criss_cross_stage == CRISS_CROSS_STAGE_MIDDLE and [0, 2, 3, 4].has(index):
		return true
	return false


func _refresh_baccarat() -> void:
	if baccarat_bankroll_label == null:
		return

	var net := baccarat_total_paid - baccarat_total_wagered
	baccarat_bankroll_label.text = "Credits: $%.2f  |  Hands: %d  |  Net: %s" % [
		baccarat_credits,
		baccarat_hands_played,
		_format_signed_money(net),
	]
	baccarat_status_label.text = "Choose Player, Banker, or Tie, then deal."
	baccarat_tip_label.text = "Tip: Banker has the lowest house edge. Tie pays more but hits rarely."
	baccarat_player_label.text = "Player: %s" % ("-" if baccarat_player_cards.is_empty() else str(_baccarat_total(baccarat_player_cards)))
	baccarat_banker_label.text = "Banker: %s" % ("-" if baccarat_banker_cards.is_empty() else str(_baccarat_total(baccarat_banker_cards)))
	_apply_poker_action_button_style(baccarat_deal_button, true, Color("#2f8f5b"))
	_refresh_baccarat_card_row(baccarat_player_row, baccarat_player_cards)
	_refresh_baccarat_card_row(baccarat_banker_row, baccarat_banker_cards)


func _refresh_baccarat_card_row(row: HBoxContainer, cards: Array) -> void:
	for child in row.get_children():
		row.remove_child(child)
		child.queue_free()

	if cards.is_empty():
		row.add_child(_build_baccarat_placeholder_card())
		return

	for i in cards.size():
		row.add_child(_build_baccarat_card_button(cards[i], i))


func _build_baccarat_card_button(card: Dictionary, index: int) -> Button:
	var button := Button.new()
	button.custom_minimum_size = BACCARAT_CARD_DISPLAY_SIZE
	button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	button.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	button.disabled = true
	button.expand_icon = true
	button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	button.vertical_icon_alignment = VERTICAL_ALIGNMENT_CENTER
	button.pivot_offset = BACCARAT_CARD_DISPLAY_SIZE * 0.5
	button.rotation_degrees = BACCARAT_CARD_ROTATIONS[index] if index < BACCARAT_CARD_ROTATIONS.size() else 0.0
	var texture := _get_poker_card_texture(card)
	if texture != null:
		button.icon = texture
		button.text = ""
	else:
		button.text = "%s\n%s" % [_rank_label(int(card["rank"])), str(card["suit"])]
	button.add_theme_color_override("font_color", _poker_suit_color(str(card["suit"])))
	button.add_theme_font_size_override("font_size", 28)
	button.add_theme_stylebox_override("normal", _poker_card_style(Color("#f7f1e7"), _poker_suit_color(str(card["suit"])), 2, false))
	_apply_button_text_depth(button)
	return button


func _build_baccarat_placeholder_card() -> Button:
	var button := Button.new()
	button.custom_minimum_size = BACCARAT_CARD_DISPLAY_SIZE
	button.disabled = true
	button.text = "BACCARAT"
	button.add_theme_font_size_override("font_size", 18)
	button.add_theme_color_override("font_color", Color("#cad1df"))
	button.add_theme_stylebox_override("normal", _poker_card_style(Color("#25352f"), Color("#4a5f55"), 2, false))
	_apply_button_text_depth(button)
	return button


func _refresh_craps() -> void:
	if craps_bankroll_label == null:
		return

	var net := craps_total_paid - craps_total_wagered
	craps_bankroll_label.text = "Credits: $%.2f  |  Rolls: %d  |  Net: %s" % [
		craps_credits,
		craps_rolls_played,
		_format_signed_money(net),
	]
	craps_status_label.text = "Come-out roll: set the table and hunt for 7 or 11." if craps_point == 0 else "Point is %d. Make the point before seven-out." % craps_point
	craps_point_label.text = "POINT OFF" if craps_point == 0 else "POINT %d" % craps_point
	craps_tip_label.text = _craps_strategy_tip()
	craps_bets_label.text = _craps_active_bets_text()
	craps_history_label.text = _craps_history_text()
	craps_roll_button.disabled = craps_roll_in_progress or _craps_total_active_bets() <= 0.0
	_apply_poker_action_button_style(craps_roll_button, not craps_roll_button.disabled, Color("#2f8f5b"))
	_apply_poker_action_button_style(craps_reset_button, true, Color("#8f3535"))
	_refresh_craps_chip_selector()

	for number in CRAPS_POINT_NUMBERS:
		if not craps_point_markers.has(number):
			continue
		var marker: Button = craps_point_markers[number]
		var active := craps_point == int(number)
		marker.add_theme_stylebox_override("normal", _craps_point_style(active))
		marker.add_theme_stylebox_override("disabled", _craps_point_style(active))
		marker.add_theme_color_override("font_color", Color("#101317") if active else Color("#f6f0df"))

	for key in craps_bet_labels.keys():
		var amount := float(craps_bets.get(key, 0.0))
		var disabled: bool = craps_roll_in_progress \
			or (craps_point != 0 and (key == "pass" or key == "dont_pass")) \
			or (craps_point == 0 and (key == "come" or key == "dont_come"))
		var buttons: Array = craps_bet_labels[key]
		for button_value in buttons:
			var button: Button = button_value
			button.disabled = disabled
			_apply_craps_zone_style(button, amount > 0.0, disabled)

	_refresh_craps_chips()


func _refresh_roulette() -> void:
	if roulette_bankroll_label == null:
		return

	var net := roulette_total_paid - roulette_total_wagered
	roulette_bankroll_label.text = "Credits: $%.2f  |  Spins: %d  |  Net: %s" % [
		roulette_credits,
		roulette_spins_played,
		_format_signed_money(net),
	]

	var active_total := _roulette_total_active_bets()
	var can_spin := active_total > 0.0 and not roulette_spin_in_progress
	roulette_spin_button.disabled = not can_spin
	_apply_poker_action_button_style(roulette_spin_button, can_spin, Color("#2f8f5b"))
	_apply_poker_action_button_style(roulette_reset_button, true, Color("#8f3535"))
	_refresh_roulette_chip_selector()

	var selected_bet := roulette_bet_option.get_item_text(roulette_bet_option.selected) if roulette_bet_option != null else "Red"
	roulette_status_label.text = "Select a chip, place it on the layout, then spin the single-zero wheel."
	roulette_tip_label.text = "Selected chip: %s | Table chips: %s | Last spot: %s" % [
		_format_craps_chip_amount(roulette_selected_chip_value),
		_format_craps_chip_amount(active_total),
		selected_bet,
	]
	if roulette_result_label.text.is_empty():
		roulette_result_label.text = "Choose a chip and click the roulette table."

	if roulette_history_label != null:
		if roulette_spin_history.is_empty():
			roulette_history_label.text = "%s\n\nSpin history will appear here." % _roulette_active_bets_text()
		else:
			roulette_history_label.text = "%s\n\n%s" % [_roulette_active_bets_text(), "\n".join(roulette_spin_history)]

	for key in roulette_bet_zone_buttons.keys():
		var amount := float(roulette_bets.get(key, 0.0))
		var button: Button = roulette_bet_zone_buttons[key]
		button.disabled = roulette_spin_in_progress
		_apply_roulette_zone_style(button, amount > 0.0, roulette_spin_in_progress)

	_refresh_roulette_chips()
	_position_roulette_ball()


func _set_craps_dice(die_a: int, die_b: int, rolling: bool, roll_frame := 0) -> void:
	craps_last_roll = [die_a, die_b]
	if craps_die_one != null:
		var texture_a := _get_craps_roll_texture(0, roll_frame) if rolling else _get_craps_die_texture(die_a)
		if texture_a == null:
			texture_a = _get_craps_die_texture(die_a)
		craps_die_one.texture = texture_a
		craps_die_one.rotation_degrees = randf_range(-18.0, 18.0) if rolling else -7.0
		craps_die_one.scale = Vector2(1.08, 1.08) if rolling else Vector2.ONE
	if craps_die_two != null:
		var texture_b := _get_craps_roll_texture(1, roll_frame + 7) if rolling else _get_craps_die_texture(die_b)
		if texture_b == null:
			texture_b = _get_craps_die_texture(die_b)
		craps_die_two.texture = texture_b
		craps_die_two.rotation_degrees = randf_range(-18.0, 18.0) if rolling else 8.0
		craps_die_two.scale = Vector2(1.08, 1.08) if rolling else Vector2.ONE


func _resolve_craps_roll(die_a: int, die_b: int) -> void:
	var total := die_a + die_b
	craps_rolls_played += 1
	craps_roll_history.push_front("%d + %d = %d%s" % [die_a, die_b, total, " HARD" if die_a == die_b else ""])
	if craps_roll_history.size() > 10:
		craps_roll_history.pop_back()

	var lines := ["Rolled %d + %d = %d." % [die_a, die_b, total]]
	_resolve_craps_line_bets(total, lines)
	_resolve_craps_come_point_bets(total, lines)
	_resolve_craps_pending_come_bets(total, lines)
	_resolve_craps_one_roll_bets(total, lines)
	_resolve_craps_big_six_eight(total, lines)
	_resolve_craps_hardways(die_a, die_b, total, lines)
	craps_result_label.text = "\n".join(lines)


func _resolve_craps_line_bets(total: int, lines: Array) -> void:
	if craps_point == 0:
		if total == 7 or total == 11:
			_craps_pay_bet("pass", 1.0, lines)
			_craps_lose_bet("dont_pass", lines)
		elif total == 2 or total == 3:
			_craps_lose_bet("pass", lines)
			_craps_pay_bet("dont_pass", 1.0, lines)
		elif total == 12:
			_craps_lose_bet("pass", lines)
			_craps_push_bet("dont_pass", lines)
		elif CRAPS_POINT_NUMBERS.has(total):
			if float(craps_bets["pass"]) > 0.0 or float(craps_bets["dont_pass"]) > 0.0:
				craps_point = total
				lines.append("Point is ON: %d." % craps_point)
			else:
				lines.append("No line bet was working, so the point stays off.")
		return

	if total == craps_point:
		_craps_pay_bet("pass", 1.0, lines)
		_craps_lose_bet("dont_pass", lines)
		lines.append("Point made. Puck is off.")
		craps_point = 0
	elif total == 7:
		_craps_lose_bet("pass", lines)
		_craps_pay_bet("dont_pass", 1.0, lines)
		lines.append("Seven-out. New come-out roll.")
		craps_point = 0


func _resolve_craps_come_point_bets(total: int, lines: Array) -> void:
	if total == 7:
		for point_number in CRAPS_POINT_NUMBERS:
			_craps_lose_point_bet(craps_come_points, int(point_number), "Come %d" % int(point_number), lines)
			_craps_pay_point_bet(craps_dont_come_points, int(point_number), "Don't Come %d" % int(point_number), 1.0, lines)
		return

	if not CRAPS_POINT_NUMBERS.has(total):
		return

	_craps_pay_point_bet(craps_come_points, total, "Come %d" % total, 1.0, lines)
	_craps_lose_point_bet(craps_dont_come_points, total, "Don't Come %d" % total, lines)


func _resolve_craps_pending_come_bets(total: int, lines: Array) -> void:
	if float(craps_bets["come"]) > 0.0:
		if total == 7 or total == 11:
			_craps_pay_bet("come", 1.0, lines)
		elif total == 2 or total == 3 or total == 12:
			_craps_lose_bet("come", lines)
		elif CRAPS_POINT_NUMBERS.has(total):
			_move_craps_bet_to_point("come", craps_come_points, total, lines)

	if float(craps_bets["dont_come"]) > 0.0:
		if total == 7 or total == 11:
			_craps_lose_bet("dont_come", lines)
		elif total == 2 or total == 3:
			_craps_pay_bet("dont_come", 1.0, lines)
		elif total == 12:
			_craps_push_bet("dont_come", lines)
		elif CRAPS_POINT_NUMBERS.has(total):
			_move_craps_bet_to_point("dont_come", craps_dont_come_points, total, lines)


func _resolve_craps_one_roll_bets(total: int, lines: Array) -> void:
	var field := float(craps_bets["field"])
	if field > 0.0:
		if total == 2:
			_craps_pay_bet("field", 2.0, lines)
		elif total == 12:
			_craps_pay_bet("field", 3.0, lines)
		elif [3, 4, 9, 10, 11].has(total):
			_craps_pay_bet("field", 1.0, lines)
		else:
			_craps_lose_bet("field", lines)

	if float(craps_bets["any_craps"]) > 0.0:
		if total == 2 or total == 3 or total == 12:
			_craps_pay_bet("any_craps", 7.0, lines)
		else:
			_craps_lose_bet("any_craps", lines)

	if float(craps_bets["any_seven"]) > 0.0:
		if total == 7:
			_craps_pay_bet("any_seven", 4.0, lines)
		else:
			_craps_lose_bet("any_seven", lines)

	if float(craps_bets["aces"]) > 0.0:
		if total == 2:
			_craps_pay_bet("aces", 30.0, lines)
		else:
			_craps_lose_bet("aces", lines)

	if float(craps_bets["ace_deuce"]) > 0.0:
		if total == 3:
			_craps_pay_bet("ace_deuce", 15.0, lines)
		else:
			_craps_lose_bet("ace_deuce", lines)

	if float(craps_bets["yo"]) > 0.0:
		if total == 11:
			_craps_pay_bet("yo", 15.0, lines)
		else:
			_craps_lose_bet("yo", lines)

	if float(craps_bets["boxcars"]) > 0.0:
		if total == 12:
			_craps_pay_bet("boxcars", 30.0, lines)
		else:
			_craps_lose_bet("boxcars", lines)


func _resolve_craps_big_six_eight(total: int, lines: Array) -> void:
	if float(craps_bets["big_6_8"]) <= 0.0:
		return

	if total == 6 or total == 8:
		_craps_pay_bet("big_6_8", 1.0, lines)
	elif total == 7:
		_craps_lose_bet("big_6_8", lines)


func _resolve_craps_hardways(die_a: int, die_b: int, total: int, lines: Array) -> void:
	if total == 7:
		for hardway in CRAPS_HARDWAYS:
			_craps_lose_bet("hard_%d" % hardway, lines)
		return

	if not CRAPS_HARDWAYS.has(total):
		return

	var key := "hard_%d" % total
	if die_a == die_b:
		_craps_pay_bet(key, 9.0 if total == 6 or total == 8 else 7.0, lines)
	else:
		_craps_lose_bet(key, lines)


func _craps_pay_bet(key: String, odds: float, lines: Array) -> void:
	var stake := float(craps_bets.get(key, 0.0))
	if stake <= 0.0:
		return
	var paid := stake * (odds + 1.0)
	craps_credits += paid
	craps_total_paid += paid
	craps_bets[key] = 0.0
	lines.append("%s wins: paid $%.2f." % [_craps_bet_display_name(key), paid])


func _craps_push_bet(key: String, lines: Array) -> void:
	var stake := float(craps_bets.get(key, 0.0))
	if stake <= 0.0:
		return
	craps_credits += stake
	craps_total_paid += stake
	craps_bets[key] = 0.0
	lines.append("%s pushes: $%.2f returned." % [_craps_bet_display_name(key), stake])


func _craps_lose_bet(key: String, lines: Array) -> void:
	var stake := float(craps_bets.get(key, 0.0))
	if stake <= 0.0:
		return
	craps_bets[key] = 0.0
	lines.append("%s loses $%.2f." % [_craps_bet_display_name(key), stake])


func _move_craps_bet_to_point(key: String, point_bets: Dictionary, point_number: int, lines: Array) -> void:
	var stake := float(craps_bets.get(key, 0.0))
	if stake <= 0.0:
		return
	craps_bets[key] = 0.0
	point_bets[point_number] = float(point_bets.get(point_number, 0.0)) + stake
	lines.append("%s travels to %d." % [_craps_bet_display_name(key), point_number])


func _craps_pay_point_bet(point_bets: Dictionary, point_number: int, label: String, odds: float, lines: Array) -> void:
	var stake := float(point_bets.get(point_number, 0.0))
	if stake <= 0.0:
		return
	var paid := stake * (odds + 1.0)
	craps_credits += paid
	craps_total_paid += paid
	point_bets[point_number] = 0.0
	lines.append("%s wins: paid $%.2f." % [label, paid])


func _craps_lose_point_bet(point_bets: Dictionary, point_number: int, label: String, lines: Array) -> void:
	var stake := float(point_bets.get(point_number, 0.0))
	if stake <= 0.0:
		return
	point_bets[point_number] = 0.0
	lines.append("%s loses $%.2f." % [label, stake])


func _craps_total_active_bets() -> float:
	var total := 0.0
	for key in craps_bets.keys():
		total += float(craps_bets[key])
	for amount in craps_come_points.values():
		total += float(amount)
	for amount in craps_dont_come_points.values():
		total += float(amount)
	return total


func _craps_active_bets_text() -> String:
	var lines := ["Active bets:"]
	var has_bet := false
	for key in craps_bets.keys():
		var amount := float(craps_bets[key])
		if amount <= 0.0:
			continue
		has_bet = true
		lines.append("%s: $%.2f" % [_craps_bet_display_name(key), amount])
	for point_number in CRAPS_POINT_NUMBERS:
		var come_amount := float(craps_come_points.get(point_number, 0.0))
		if come_amount > 0.0:
			has_bet = true
			lines.append("Come %d: $%.2f" % [int(point_number), come_amount])
		var dont_come_amount := float(craps_dont_come_points.get(point_number, 0.0))
		if dont_come_amount > 0.0:
			has_bet = true
			lines.append("Don't Come %d: $%.2f" % [int(point_number), dont_come_amount])
	if not has_bet:
		lines.append("No chips on the felt yet.")
	return "\n".join(lines)


func _craps_history_text() -> String:
	if craps_roll_history.is_empty():
		return "Roll history:\nNo rolls yet."
	var lines := ["Roll history:"]
	for entry in craps_roll_history:
		lines.append(str(entry))
	return "\n".join(lines)


func _craps_rules_text() -> String:
	return "Goal\n" \
		+ "Bet on the outcome of two dice. The main game is Pass Line or Don't Pass, built around the point.\n\n" \
		+ "Basic Flow\n" \
		+ "1. Choose a chip amount at the top.\n" \
		+ "2. Click a betting spot to place that chip.\n" \
		+ "3. Press Roll Dice.\n" \
		+ "4. On the come-out roll, 7 or 11 wins Pass Line. 2, 3, or 12 loses Pass Line. 4, 5, 6, 8, 9, or 10 becomes the point.\n\n" \
		+ "Point On\n" \
		+ "Pass Line wants the point to roll again before 7. Don't Pass wants 7 before the point repeats. When either happens, the point turns off and a new come-out roll begins.\n\n" \
		+ "Pass Line\n" \
		+ "Wins on come-out 7 or 11. Loses on 2, 3, or 12. After a point is set, wins if the point repeats before 7.\n\n" \
		+ "Don't Pass\n" \
		+ "Wins on come-out 2 or 3, pushes on 12, loses on 7 or 11. After a point is set, wins if 7 rolls before the point.\n\n" \
		+ "Come and Don't Come\n" \
		+ "Available after the main point is on. Come works like a new Pass Line bet: 7 or 11 wins, 2, 3, or 12 loses, and a point number travels to that number. Don't Come works like Don't Pass: 2 or 3 wins, 12 pushes, 7 or 11 loses, and a point number travels to that number.\n\n" \
		+ "Field\n" \
		+ "One-roll bet. 3, 4, 9, 10, and 11 pay even money. 2 pays 2:1. 12 pays 3:1. 5, 6, 7, and 8 lose.\n\n" \
		+ "Big 6/8\n" \
		+ "Working bet. 6 or 8 wins even money before a 7. Other numbers do not resolve it.\n\n" \
		+ "Any Craps\n" \
		+ "One-roll bet. 2, 3, or 12 wins and pays 7:1.\n\n" \
		+ "Any Seven\n" \
		+ "One-roll bet. Any 7 wins and pays 4:1.\n\n" \
		+ "Aces, Ace-Deuce, Yo, and Boxcars\n" \
		+ "One-roll bets. Aces and Boxcars pay 30:1. Ace-Deuce and Yo 11 pay 15:1.\n\n" \
		+ "Hardways\n" \
		+ "Hard 4 is 2+2, Hard 6 is 3+3, Hard 8 is 4+4, and Hard 10 is 5+5. A hardway wins if the double rolls before an easy version of that number or a 7. Hard 4 and Hard 10 pay 7:1. Hard 6 and Hard 8 pay 9:1.\n\n" \
		+ "Beginner Play\n" \
		+ "Start with Pass Line, roll until a point or instant result, then keep rolling until the point repeats or 7 appears. Use Field, Yo, Any Craps, and Hardways as higher-risk side bets."


func _craps_strategy_tip() -> String:
	if craps_roll_in_progress:
		return "Dice are moving..."
	if craps_point == 0:
		return "Tip: Pass Line is the friendly default. Don't Pass is leaner and moodier."
	if float(craps_bets["pass"]) > 0.0:
		return "Tip: the point is %d. Keep away from 7 and bring that number back." % craps_point
	if float(craps_bets["dont_pass"]) > 0.0:
		return "Tip: the point is %d. A 7 wins Don't Pass before the point repeats." % craps_point
	return "Tip: Big 6/8 and hardways stay working; field and proposition bets are one-roll shots."


func _craps_bet_display_name(key: String) -> String:
	match key:
		"pass":
			return "Pass Line"
		"dont_pass":
			return "Don't Pass"
		"come":
			return "Come"
		"dont_come":
			return "Don't Come"
		"field":
			return "Field"
		"big_6_8":
			return "Big 6/8"
		"any_seven":
			return "Any Seven"
		"any_craps":
			return "Any Craps"
		"aces":
			return "Aces"
		"boxcars":
			return "Boxcars"
		"ace_deuce":
			return "Ace-Deuce"
		"yo":
			return "Yo 11"
		"hard_4":
			return "Hard 4"
		"hard_6":
			return "Hard 6"
		"hard_8":
			return "Hard 8"
		"hard_10":
			return "Hard 10"
	return key.capitalize()


func _roulette_selected_bet_id() -> String:
	if roulette_bet_option == null or roulette_bet_option.item_count <= 0:
		return "red"
	return str(roulette_bet_option.get_item_metadata(roulette_bet_option.selected))


func _animate_roulette_spin(pocket: int) -> void:
	var spin_duration := 5.0
	var wheel_turns := randf_range(1260.0, 1620.0)
	var final_wheel_rotation := roulette_wheel_texture.rotation_degrees - wheel_turns if roulette_wheel_texture != null else 0.0
	var target_angle := _roulette_visual_pocket_angle(pocket, final_wheel_rotation)
	if roulette_wheel_texture == null or roulette_ball == null:
		roulette_ball_angle = target_angle
		roulette_ball_track_offset = 0.0
		await get_tree().create_timer(0.35).timeout
		return

	var start_ball_angle := roulette_ball_angle
	var final_ball_angle := _roulette_unwrapped_angle_after_turns(start_ball_angle, target_angle, randi_range(5, 6))
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		roulette_wheel_texture,
		"rotation_degrees",
		final_wheel_rotation,
		spin_duration
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_method(
		Callable(self, "_set_roulette_ball_spin_progress").bind(start_ball_angle, final_ball_angle),
		0.0,
		1.0,
		spin_duration
	).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	await tween.finished
	roulette_ball_track_offset = 0.0
	_set_roulette_ball_angle(target_angle)


func _set_roulette_ball_angle(angle: float) -> void:
	roulette_ball_angle = fposmod(angle, TAU)
	_position_roulette_ball()


func _set_roulette_ball_spin_progress(progress: float, start_angle: float, end_angle: float) -> void:
	var bounce_fade := pow(1.0 - progress, 0.85)
	var bump_offset := sin(progress * TAU * ROULETTE_BALL_BUMP_COUNT) * ROULETTE_BALL_BUMP_BOUNCE * bounce_fade
	roulette_ball_track_offset = bump_offset
	roulette_ball_angle = fposmod(lerpf(start_angle, end_angle, progress), TAU)
	_position_roulette_ball()


func _roulette_unwrapped_angle_after_turns(start_angle: float, target_angle: float, turns: int) -> float:
	var start := fposmod(start_angle, TAU)
	var target := fposmod(target_angle, TAU)
	return start + fposmod(target - start, TAU) + TAU * float(turns)


func _roulette_visual_pocket_angle(pocket: int, wheel_rotation_degrees: float) -> float:
	return _roulette_pocket_angle(pocket) + deg_to_rad(wheel_rotation_degrees)


func _roulette_pocket_angle(pocket: int) -> float:
	var wheel_order := [0, 32, 15, 19, 4, 21, 2, 25, 17, 34, 6, 27, 13, 36, 11, 30, 8, 23, 10, 5, 24, 16, 33, 1, 20, 14, 31, 9, 22, 18, 29, 7, 28, 12, 35, 3, 26]
	var index := 0
	if pocket == -1:
		index = 18
	else:
		index = max(0, wheel_order.find(pocket))
	return -PI * 0.5 + (float(index) / float(wheel_order.size())) * TAU


func _refresh_roulette_chip_selector() -> void:
	if roulette_chip_selector_buttons.is_empty():
		return

	for amount_value in roulette_chip_selector_buttons.keys():
		var amount := float(amount_value)
		var button: Button = roulette_chip_selector_buttons[amount]
		var selected := is_equal_approx(amount, roulette_selected_chip_value)
		var unavailable := amount > roulette_credits
		button.set_pressed_no_signal(selected)
		button.disabled = roulette_spin_in_progress or unavailable
		button.add_theme_stylebox_override("normal", _craps_selector_chip_style(selected, false))
		button.add_theme_stylebox_override("hover", _craps_selector_chip_style(true, false))
		button.add_theme_stylebox_override("pressed", _craps_selector_chip_style(true, true))
		button.add_theme_stylebox_override("disabled", _craps_selector_chip_style(selected, false, true))
		button.add_theme_color_override("font_color", Color("#101317") if selected else Color("#f6f0df"))
		button.add_theme_color_override("font_hover_color", Color("#101317"))
		button.add_theme_color_override("font_pressed_color", Color("#101317"))
		button.add_theme_color_override("font_disabled_color", Color("#b9c0c9"))


func _roulette_total_active_bets() -> float:
	var total := 0.0
	for key in roulette_bets.keys():
		total += float(roulette_bets[key])
	return total


func _roulette_active_bets_text() -> String:
	var lines := ["Active roulette chips:"]
	var has_bet := false
	for key in roulette_bets.keys():
		var amount := float(roulette_bets[key])
		if amount <= 0.0:
			continue
		has_bet = true
		lines.append("%s: $%.2f" % [_roulette_bet_display_name(str(key)), amount])
	if not has_bet:
		lines.append("No chips on the layout yet.")
	return "\n".join(lines)


func _select_roulette_bet_option(key: String) -> void:
	if roulette_bet_option == null:
		return
	for index in roulette_bet_option.item_count:
		if str(roulette_bet_option.get_item_metadata(index)) == key:
			roulette_bet_option.select(index)
			return


func _roulette_bet_wins(bet_id: String, pocket: int) -> bool:
	if bet_id.begins_with("straight_"):
		return _roulette_pocket_text(pocket) == bet_id.substr("straight_".length())

	if pocket <= 0:
		return false

	var is_red := ROULETTE_RED_NUMBERS.has(pocket)
	match bet_id:
		"red":
			return is_red
		"black":
			return not is_red
		"odd":
			return pocket % 2 == 1
		"even":
			return pocket % 2 == 0
		"low":
			return pocket >= 1 and pocket <= 18
		"high":
			return pocket >= 19 and pocket <= 36
		"first_dozen":
			return pocket >= 1 and pocket <= 12
		"second_dozen":
			return pocket >= 13 and pocket <= 24
		"third_dozen":
			return pocket >= 25 and pocket <= 36
		"column_1":
			return pocket % 3 == 1
		"column_2":
			return pocket % 3 == 2
		"column_3":
			return pocket % 3 == 0
	return false


func _roulette_bet_payout_multiplier(bet_id: String) -> int:
	if bet_id.begins_with("straight_"):
		return 35

	match bet_id:
		"first_dozen", "second_dozen", "third_dozen", "column_1", "column_2", "column_3":
			return 2
	return 1


func _roulette_bet_display_name(bet_id: String) -> String:
	if bet_id.begins_with("straight_"):
		return "Straight %s" % bet_id.substr("straight_".length())
	match bet_id:
		"red":
			return "Red"
		"black":
			return "Black"
		"odd":
			return "Odd"
		"even":
			return "Even"
		"low":
			return "1-18"
		"high":
			return "19-36"
		"first_dozen":
			return "1 to 12"
		"second_dozen":
			return "13 to 24"
		"third_dozen":
			return "25 to 36"
		"column_1":
			return "Column 1"
		"column_2":
			return "Column 2"
		"column_3":
			return "Column 3"
	return bet_id.capitalize()


func _roulette_pocket_text(pocket: int) -> String:
	if pocket == -1:
		return "00"
	return str(pocket)


func _roulette_pocket_color_name(pocket: int) -> String:
	if pocket <= 0:
		return "green"
	return "red" if ROULETTE_RED_NUMBERS.has(pocket) else "black"


func _roulette_rules_text() -> String:
	return "Goal\n" \
		+ "Bet on where the ball lands on a single-zero roulette wheel with 0 and 1-36.\n\n" \
		+ "Basic Flow\n" \
		+ "1. Choose a chip in front of you.\n" \
		+ "2. Click the roulette layout to place that chip.\n" \
		+ "3. Press Spin to send the wheel and ball around.\n\n" \
		+ "Even Money Bets\n" \
		+ "Red/black, odd/even, and 1-18/19-36 pay 1:1. Green 0 loses these bets.\n\n" \
		+ "Dozens and Columns\n" \
		+ "Each dozen or column pays 2:1. Green 0 loses.\n\n" \
		+ "Straight Bets\n" \
		+ "Pick one exact pocket: 0, 00, or 1-36. A hit pays 35:1.\n\n" \
		+ "Beginner Play\n" \
		+ "Red or black is the simplest starting bet. Straight numbers are fun long shots, but they miss much more often."


func _refresh_cards() -> void:
	for i in CARD_COUNT:
		if i >= card_buttons.size():
			continue
		var button: Button = card_buttons[i]
		button.text = ""
		button.set_pressed_no_signal(i == selected_card)
		var border := Color("#f6f0df") if i == selected_card else Color("#00000000")
		var border_width := 5 if i == selected_card else 0
		button.add_theme_stylebox_override("normal", _transparent_button_style(Color("#00000000"), border, border_width))
		button.add_theme_stylebox_override("hover", _transparent_button_style(Color("#f5d06722"), Color("#f6f0df"), 4))
		button.add_theme_stylebox_override("pressed", _transparent_button_style(Color("#ffffff22"), Color("#ffffff"), 5, true))


func _refresh_numbers() -> void:
	for number in range(1, NUMBER_MAX + 1):
		var button: Button = number_buttons[number]
		var owners := _owners_for_number(number)
		if not reveal_all_card_numbers and not owners.has(selected_card):
			owners = []
		elif not reveal_all_card_numbers:
			owners = [selected_card]
		var bg := Color("#050505")
		var border := Color("#fff200")
		var border_width := 2

		if owners.size() == 1:
			var owner_color: Color = CARD_COLORS[owners[0]]
			bg = Color(owner_color.r, owner_color.g, owner_color.b, 0.82)
			border = owner_color.lightened(0.45)
			border_width = 3
		elif owners.size() > 1:
			bg = Color(0.78, 0.6, 0.18, 0.88)
			border = Color("#f6d45d")
			border_width = 3

		if last_draw.has(number):
			if owners.is_empty():
				bg = Color("#082b2a")
			border = Color("#f6f0df")
			border_width = max(border_width, 4)

		button.text = str(number)
		button.tooltip_text = _number_tooltip(number, owners, last_draw.has(number))
		button.add_theme_stylebox_override("normal", _keno_board_button_style(bg, border, border_width))
		button.add_theme_stylebox_override("hover", _keno_board_button_style(bg.lightened(0.12), Color("#f6f0df"), max(border_width, 2)))
		button.add_theme_stylebox_override("pressed", _keno_board_button_style(bg.lightened(0.2), Color("#ffffff"), max(border_width, 3), true))
		button.add_theme_stylebox_override("focus", _keno_board_button_style(Color("#00000000"), Color("#00000000"), 0))
		button.add_theme_color_override("font_color", Color("#fff8dc"))
		button.add_theme_color_override("font_hover_color", Color("#ffffff"))
		button.add_theme_color_override("font_pressed_color", Color("#ffffff"))
		button.add_theme_color_override("font_shadow_color", Color("#00000000"))

	_refresh_keno_ball_colors()


func _refresh_keno_art_labels() -> void:
	if keno_current_value_label == null:
		return

	var bet := float(bet_spin.value) if bet_spin != null else 0.0
	keno_current_value_label.text = _card_label(selected_card)
	keno_pattern_value_label.text = _selected_pattern_art_display_name()
	keno_bottom_win_label.text = "$%.2f" % keno_last_round_paid
	keno_bottom_cards_played_label.text = str(keno_last_cards_played)
	keno_bottom_bet_label.text = "$%.2f" % keno_last_round_wagered
	keno_bottom_credit_label.text = "$%.2f" % keno_credits

	for i in min(CARD_COUNT, keno_summary_labels.size()):
		var labels: Dictionary = keno_summary_labels[i]
		var active: bool = not card_picks[i].is_empty()
		var card_bet: float = bet if active else 0.0
		var hit_count := int(card_last_hits[i])
		var paid := float(card_last_paid[i])
		labels["bet"].text = "%.0f" % card_bet
		labels["marked"].text = str(card_picks[i].size())
		labels["hit"].text = str(hit_count)
		labels["pay"].text = "%.0f" % paid


func _selected_pattern_art_display_name() -> String:
	var pattern_index := _get_selected_pattern_index()
	var picks: Array = saved_pick_patterns[pattern_index]
	if picks.is_empty():
		return "Pattern %d empty" % (pattern_index + 1)
	return "P%d: %s" % [pattern_index + 1, ",".join(_stringify_numbers(picks, MAX_PICKS_PER_CARD))]


func _fit_keno_board_to_scroll() -> void:
	if keno_board_scroll == null or keno_board_control == null:
		return

	var available_size := keno_board_scroll.size
	var viewport_size := get_viewport_rect().size
	var scroll_global_rect := keno_board_scroll.get_global_rect()
	if viewport_size.x > 0.0 and viewport_size.y > 0.0:
		var visible_width: float = viewport_size.x - scroll_global_rect.position.x - 12.0
		var visible_height: float = viewport_size.y - scroll_global_rect.position.y - 72.0
		available_size.x = minf(available_size.x, visible_width)
		available_size.y = minf(available_size.y, visible_height)
	if available_size.x <= 0.0 or available_size.y <= 0.0:
		return

	var scale: float = minf(
		available_size.x / KENO_BOARD_REFERENCE_SIZE.x,
		available_size.y / KENO_BOARD_REFERENCE_SIZE.y
	)
	if scale <= 0.0:
		return

	var display_size := Vector2(
		floor(KENO_BOARD_REFERENCE_SIZE.x * scale),
		floor(KENO_BOARD_REFERENCE_SIZE.y * scale)
	)
	keno_board_control.custom_minimum_size = display_size
	keno_board_control.size = display_size
	_layout_keno_card_overlays()


func _layout_keno_card_overlays() -> void:
	_layout_keno_reference_controls()
	_layout_keno_board_buttons()


func _layout_keno_reference_controls() -> void:
	if keno_board_control == null:
		return

	var board_size := keno_board_control.size
	if board_size.x <= 0.0 or board_size.y <= 0.0:
		return

	var scale := Vector2(board_size.x / KENO_BOARD_REFERENCE_SIZE.x, board_size.y / KENO_BOARD_REFERENCE_SIZE.y)
	for child in keno_board_control.get_children():
		if not child.has_meta("keno_reference_rect"):
			continue
		var control := child as Control
		if control == null:
			continue
		var rect: Rect2 = child.get_meta("keno_reference_rect")
		control.position = Vector2(rect.position.x * scale.x, rect.position.y * scale.y)
		control.size = Vector2(rect.size.x * scale.x, rect.size.y * scale.y)
		if control is Label and control.has_meta("keno_reference_font_size"):
			var reference_font_size := int(control.get_meta("keno_reference_font_size"))
			(control as Label).add_theme_font_size_override("font_size", max(10, int(float(reference_font_size) * min(scale.x, scale.y))))


func _layout_keno_board_buttons() -> void:
	if keno_board_control == null:
		return

	var board_size := keno_board_control.size
	if board_size.x <= 0.0 or board_size.y <= 0.0:
		return

	var inset: float = max(1.0, min(board_size.x, board_size.y) * 0.004)
	for number in range(1, NUMBER_MAX + 1):
		if not number_buttons.has(number):
			continue

		var cell_rect := _keno_board_cell_rect(number)
		if cell_rect.size == Vector2.ZERO:
			continue

		var button: Button = number_buttons[number]
		button.position = cell_rect.position + Vector2(inset, inset)
		button.size = Vector2(max(1.0, cell_rect.size.x - inset * 2.0), max(1.0, cell_rect.size.y - inset * 2.0))
		button.add_theme_font_size_override("font_size", max(10, int(button.size.y * 0.34)))


func _keno_board_cell_rect(number: int) -> Rect2:
	if keno_board_control == null:
		return Rect2()

	var board_size := keno_board_control.size
	if board_size.x <= 0.0 or board_size.y <= 0.0:
		return Rect2()

	var row := int((number - 1) / 10)
	var column := int((number - 1) % 10)
	if row < 0 or row >= KENO_BOARD_ROW_TOPS.size() or column < 0 or column + 1 >= KENO_BOARD_COL_EDGES.size():
		return Rect2()

	var scale := Vector2(board_size.x / KENO_BOARD_REFERENCE_SIZE.x, board_size.y / KENO_BOARD_REFERENCE_SIZE.y)
	var left: float = float(KENO_BOARD_COL_EDGES[column]) * scale.x
	var right: float = float(KENO_BOARD_COL_EDGES[column + 1]) * scale.x
	var top: float = float(KENO_BOARD_ROW_TOPS[row]) * scale.y
	var bottom: float = float(KENO_BOARD_ROW_BOTTOMS[row]) * scale.y
	return Rect2(Vector2(left, top), Vector2(right - left, bottom - top))


func _layout_keno_board_stat_labels() -> void:
	pass


func _layout_keno_board_label(label: Label, reference_rect: Rect2) -> void:
	pass


func _layout_keno_ball_tube() -> void:
	if keno_ball_stage == null or keno_ball_tube == null or keno_ball_spout == null:
		return

	var stage_width := keno_ball_stage.size.x
	if stage_width <= 0.0:
		return

	keno_ball_tube.size = Vector2(250, 34)
	keno_ball_tube.position = Vector2((stage_width - keno_ball_tube.size.x) * 0.5, 8)
	keno_ball_spout.size = Vector2(58, 42)
	keno_ball_spout.position = Vector2((stage_width - keno_ball_spout.size.x) * 0.5, 32)


func _animate_keno_balls() -> void:
	if keno_ball_stage == null or keno_board_control == null or last_draw.is_empty():
		return

	await get_tree().process_frame
	if keno_ball_stage == null or keno_board_control == null or last_draw.is_empty():
		return

	_clear_keno_balls()

	var start := _keno_ball_start_position()
	keno_ball_tween = create_tween()
	keno_ball_tween.set_parallel(true)
	keno_ball_animating = true

	for i in last_draw.size():
		var number := int(last_draw[i])
		if not number_buttons.has(number):
			continue
		var ball := _make_keno_ball(number)
		var target := _keno_ball_target_for_number(number)
		ball.position = start + Vector2(randf_range(-10.0, 10.0), randf_range(-4.0, 4.0))
		ball.scale = Vector2(0.75, 0.75)
		ball.rotation = randf_range(-0.4, 0.4)
		ball.modulate.a = 0.0
		keno_ball_stage.add_child(ball)
		keno_ball_nodes.append(ball)

		var delay := float(i) * 0.05
		keno_ball_tween.tween_property(ball, "modulate:a", 1.0, 0.12).set_delay(delay)
		keno_ball_tween.tween_property(ball, "position", target, 0.56).set_delay(delay).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
		keno_ball_tween.tween_property(ball, "rotation", randf_range(-0.08, 0.08), 0.56).set_delay(delay).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		keno_ball_tween.tween_property(ball, "scale", Vector2.ONE, 0.28).set_delay(delay).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	if keno_ball_nodes.is_empty():
		keno_ball_animating = false
	else:
		keno_ball_tween.finished.connect(_on_keno_ball_animation_finished)


func _keno_ball_start_position() -> Vector2:
	if keno_board_control == null:
		return Vector2.ZERO
	var scale := Vector2(keno_board_control.size.x / KENO_BOARD_REFERENCE_SIZE.x, keno_board_control.size.y / KENO_BOARD_REFERENCE_SIZE.y)
	var reference_start := Vector2(2840.0, 430.0)
	return Vector2(reference_start.x * scale.x, reference_start.y * scale.y) - Vector2(KENO_BALL_SIZE, KENO_BALL_SIZE) * 0.5


func _keno_ball_target_for_number(number: int) -> Vector2:
	var cell_rect := _keno_board_cell_rect(number)
	if cell_rect.size == Vector2.ZERO:
		return Vector2.ZERO

	return cell_rect.get_center() - Vector2(KENO_BALL_SIZE, KENO_BALL_SIZE) * 0.5


func _keno_global_point_to_overlay(point: Vector2) -> Vector2:
	return point - global_position


func _clear_keno_balls() -> void:
	keno_ball_animating = false
	if keno_ball_tween != null and keno_ball_tween.is_valid():
		keno_ball_tween.kill()
	for ball in keno_ball_nodes:
		if is_instance_valid(ball):
			ball.queue_free()
	keno_ball_nodes.clear()


func _on_keno_ball_animation_finished() -> void:
	keno_ball_animating = false


func _make_keno_ball(number: int) -> Control:
	var ball := Control.new()
	ball.custom_minimum_size = Vector2(KENO_BALL_SIZE, KENO_BALL_SIZE)
	ball.size = Vector2(KENO_BALL_SIZE, KENO_BALL_SIZE)
	ball.pivot_offset = Vector2(KENO_BALL_SIZE, KENO_BALL_SIZE) * 0.5
	ball.mouse_filter = Control.MOUSE_FILTER_IGNORE
	ball.z_index = 100
	ball.set_meta("number", number)

	var ring := PanelContainer.new()
	ring.name = "MatchRing"
	ring.set_anchors_preset(Control.PRESET_FULL_RECT)
	ring.mouse_filter = Control.MOUSE_FILTER_IGNORE
	ball.add_child(ring)

	var texture := TextureRect.new()
	texture.name = "BallTexture"
	texture.set_anchors_preset(Control.PRESET_FULL_RECT)
	texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	texture.mouse_filter = Control.MOUSE_FILTER_IGNORE
	texture.texture = keno_ball_textures.get(number, null)
	ball.add_child(texture)

	if texture.texture == null:
		var fallback := Label.new()
		fallback.name = "FallbackNumber"
		fallback.text = str(number)
		fallback.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		fallback.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		fallback.set_anchors_preset(Control.PRESET_FULL_RECT)
		fallback.add_theme_font_size_override("font_size", 16)
		fallback.mouse_filter = Control.MOUSE_FILTER_IGNORE
		ball.add_child(fallback)

	_apply_keno_ball_color(ball)
	return ball


func _refresh_keno_ball_colors() -> void:
	for ball in keno_ball_nodes:
		if is_instance_valid(ball):
			_apply_keno_ball_color(ball)


func _apply_keno_ball_color(ball: Control) -> void:
	var number := int(ball.get_meta("number", 0))
	var matched: bool = card_picks[selected_card].has(number)
	var ring := ball.get_node_or_null("MatchRing") as PanelContainer
	var texture := ball.get_node_or_null("BallTexture") as TextureRect
	var fallback := ball.get_node_or_null("FallbackNumber") as Label
	if ring != null:
		ring.visible = matched
		ring.add_theme_stylebox_override("panel", _keno_ball_match_ring_style())
	if texture != null:
		texture.modulate = Color("#baffd2") if matched else Color.WHITE
	if fallback == null:
		return
	var bg := Color("#eef4ff")
	var border := Color("#7fa7d8")
	var font := Color("#17202c")
	if matched:
		bg = Color("#27b86c")
		border = Color("#f5d067")
		font = Color("#ffffff")
	fallback.add_theme_stylebox_override("normal", _keno_ball_style(bg, border, matched))
	fallback.add_theme_color_override("font_color", font)
	fallback.add_theme_color_override("font_shadow_color", Color("#00000077"))
	fallback.add_theme_constant_override("shadow_offset_x", 1)
	fallback.add_theme_constant_override("shadow_offset_y", 1)


func _refresh_labels() -> void:
	var selected_picks: Array = card_picks[selected_card]
	if selected_label != null:
		selected_label.text = "Selected Card %s  |  %d/%d picks  |  Credits $%.2f" % [_card_label(selected_card), selected_picks.size(), MAX_PICKS_PER_CARD, keno_credits]

	if last_draw_label != null:
		if last_draw.is_empty():
			last_draw_label.text = "Last draw: play a round to draw 20 numbers."
		else:
			last_draw_label.text = "Last draw: %s" % ", ".join(_stringify_numbers(last_draw, DRAW_COUNT))

	var win_rate := 0.0
	var loss_rate := 0.0
	if rounds_played > 0:
		win_rate = float(winning_rounds) / float(rounds_played) * 100.0
		loss_rate = float(losing_rounds) / float(rounds_played) * 100.0
	if stats_label != null:
		stats_label.text = "Rounds played: %d\nWins: %d (%.1f%%)\nLosses: %d (%.1f%%)\nTotal wagered: $%.2f\nTotal paid: $%.2f\nNet: %s" % [
			rounds_played,
			winning_rounds,
			win_rate,
			losing_rounds,
			loss_rate,
			total_wagered,
			total_paid,
			_format_signed_money(total_paid - total_wagered),
		]
	if hit_tally_label != null:
		hit_tally_label.text = _format_hit_tally()
	if recent_runs_label != null:
		recent_runs_label.text = _format_recent_runs_tally()

	var hot := _get_hot_numbers(10)
	var cold := _get_cold_numbers(10)
	if hot_label != null:
		hot_label.text = "Most hits: %s" % _format_count_list(hot)
	if cold_label != null:
		cold_label.text = "Least hits: %s" % _format_count_list(cold)

	if suggestion_label != null:
		if rounds_played == 0:
			suggestion_label.text = "Trend picks: play a few rounds to build live hit data. Keno draws are random, so hot numbers do not change the true odds."
		else:
			suggestion_label.text = "Trend picks for Card %s: %s\nOdds note: the game still draws randomly; this is based only on your live history." % [
				_card_label(selected_card),
				", ".join(_stringify_numbers(hot, 10)),
			]


func _record_recent_run(round_number: int, active_card_count: int, hits: int, paid: float, wagered: float) -> void:
	recent_runs.append({
		"round": round_number,
		"cards": active_card_count,
		"hits": hits,
		"paid": paid,
		"net": paid - wagered,
	})
	while recent_runs.size() > RECENT_RUN_LIMIT:
		recent_runs.pop_front()


func _record_hit_tally(spots: int, matches: int) -> void:
	if not hit_tally.has(spots):
		hit_tally[spots] = {}

	var spot_tally: Dictionary = hit_tally[spots]
	spot_tally[matches] = int(spot_tally.get(matches, 0)) + 1


func _reset_all_time_counters() -> void:
	rounds_played = 0
	winning_rounds = 0
	losing_rounds = 0
	total_wagered = 0.0
	total_paid = 0.0
	keno_credits = KENO_STARTING_CREDITS
	keno_last_round_paid = 0.0
	keno_last_round_wagered = 0.0
	keno_last_cards_played = 0


func _reset_card_counters(card_index: int) -> void:
	card_plays[card_index] = 0
	card_wins[card_index] = 0
	card_profit[card_index] = 0.0
	card_last_hits[card_index] = 0
	card_last_paid[card_index] = 0.0


func _reset_all_card_counters() -> void:
	for i in CARD_COUNT:
		_reset_card_counters(i)


func _reset_number_hit_counters() -> void:
	for i in number_hit_counts.size():
		number_hit_counts[i] = 0
	last_draw.clear()
	_clear_keno_balls()


func _reset_hit_tally() -> void:
	hit_tally.clear()


func _get_active_cards() -> Array:
	var cards := []
	for i in CARD_COUNT:
		if not card_picks[i].is_empty():
			cards.append(i)
	return cards


func _get_quick_pick_count() -> int:
	return clampi(int(quick_pick_count_spin.value), 1, MAX_PICKS_PER_CARD)


func _load_keno_ball_textures() -> void:
	keno_ball_textures.clear()
	var files := DirAccess.get_files_at(KENO_BALL_DIR)
	for file in files:
		if not file.to_lower().ends_with(".png"):
			continue
		var number := _keno_ball_number_from_filename(file)
		if number < 1 or number > NUMBER_MAX:
			continue
		var texture := _load_image_texture(KENO_BALL_DIR.path_join(file))
		if texture != null:
			keno_ball_textures[number] = texture


func _load_craps_dice_textures() -> void:
	craps_dice_textures.clear()
	for i in CRAPS_DICE_FACE_FILES.size():
		var texture := _load_image_texture(CRAPS_DICE_DIR.path_join(str(CRAPS_DICE_FACE_FILES[i])))
		if texture != null:
			craps_dice_textures[i + 1] = texture


func _load_craps_chip_textures() -> void:
	craps_chip_textures.clear()
	for denomination in CRAPS_CHIP_DENOMINATIONS:
		var amount := int(denomination)
		var texture := _load_image_texture(CRAPS_CHIP_DIR.path_join("%d.png" % amount))
		if texture != null:
			craps_chip_textures[amount] = texture


func _load_craps_roll_textures() -> void:
	craps_roll_sequences.clear()
	var files := DirAccess.get_files_at(CRAPS_DICE_ROLL_DIR)
	if files.is_empty():
		return

	var groups := {}
	for file in files:
		if not file.to_lower().ends_with(".png"):
			continue
		var parts := file.split("_0000s_")
		if parts.size() < 2:
			continue
		var group_key := str(parts[0])
		if not groups.has(group_key):
			groups[group_key] = []
		groups[group_key].append(file)

	var group_keys := groups.keys()
	group_keys.sort()
	for key in group_keys:
		var sequence_files: Array = groups[key]
		sequence_files.sort_custom(func(a, b) -> bool:
			return _craps_roll_frame_number(str(a)) < _craps_roll_frame_number(str(b))
		)
		var sequence := []
		for file in sequence_files:
			var texture := _load_image_texture(CRAPS_DICE_ROLL_DIR.path_join(str(file)))
			if texture != null:
				sequence.append(texture)
		if not sequence.is_empty():
			craps_roll_sequences.append(sequence)


func _craps_roll_frame_number(file: String) -> int:
	var marker := "_0000s_"
	var marker_index := file.find(marker)
	if marker_index < 0:
		return 0
	var start := marker_index + marker.length()
	var end := file.find("_", start)
	if end < 0:
		return 0
	return int(file.substr(start, end - start))


func _get_craps_die_texture(value: int) -> Texture2D:
	return craps_dice_textures.get(clampi(value, 1, 6), null)


func _get_craps_roll_texture(die_slot: int, frame: int) -> Texture2D:
	if craps_roll_sequences.is_empty():
		return null
	var sequence: Array = craps_roll_sequences[die_slot % craps_roll_sequences.size()]
	if sequence.is_empty():
		return null
	return sequence[frame % sequence.size()]


func _get_craps_chip_texture(amount: float) -> Texture2D:
	var amount_key := _craps_chip_texture_key(amount)
	if amount_key > 0 and craps_chip_textures.has(amount_key):
		return craps_chip_textures[amount_key]

	var fallback_key := _largest_craps_chip_key(amount)
	if fallback_key > 0:
		return craps_chip_textures.get(fallback_key, null)

	return null


func _has_exact_craps_chip_texture(amount: float) -> bool:
	var amount_key := _craps_chip_texture_key(amount)
	return amount_key > 0 and craps_chip_textures.has(amount_key)


func _craps_chip_texture_key(amount: float) -> int:
	if not is_equal_approx(amount, roundf(amount)):
		return 0

	var amount_key := int(roundf(amount))
	if craps_chip_textures.has(amount_key):
		return amount_key
	return 0


func _largest_craps_chip_key(amount: float) -> int:
	var best_key := 0
	for key_value in craps_chip_textures.keys():
		var key := int(key_value)
		if float(key) <= amount and key > best_key:
			best_key = key
	return best_key


func _keno_ball_number_from_filename(file: String) -> int:
	var parts := file.get_basename().split("_")
	if parts.is_empty():
		return 0
	return int(str(parts[parts.size() - 1]))


func _load_image_texture(path: String) -> Texture2D:
	var resource = load(path)
	if resource is Texture2D:
		return resource

	var image := Image.new()
	var err := image.load(path)
	if err == OK:
		return ImageTexture.create_from_image(image)
	return null


func _draw_numbers() -> Array:
	return _draw_unique(DRAW_COUNT, NUMBER_MAX)


func _draw_unique(count: int, max_number: int) -> Array:
	var pool := []
	for number in range(1, max_number + 1):
		pool.append(number)
	pool.shuffle()
	var picked := pool.slice(0, count)
	picked.sort()
	return picked


func _build_poker_deck() -> Array:
	var deck := []
	for suit in POKER_SUITS:
		for rank in POKER_RANKS:
			deck.append({
				"rank": rank,
				"suit": suit,
				"image_path": _poker_card_image_path(suit, rank),
			})
	return deck


func _build_poker_deck_excluding(excluded_cards: Array) -> Array:
	var deck := []
	for card in _build_poker_deck():
		if not _poker_card_list_has(excluded_cards, card):
			deck.append(card)
	return deck


func _poker_card_list_has(cards: Array, target_card: Dictionary) -> bool:
	for card_value in cards:
		var card: Dictionary = card_value
		if int(card["rank"]) == int(target_card["rank"]) and str(card["suit"]) == str(target_card["suit"]):
			return true
	return false


func _duplicate_poker_cards(cards: Array) -> Array:
	var duplicate := []
	for card_value in cards:
		var card: Dictionary = card_value
		duplicate.append(card.duplicate())
	return duplicate


func _draw_poker_card() -> Dictionary:
	if poker_deck.is_empty():
		poker_deck = _build_poker_deck()
		poker_deck.shuffle()
	var card: Dictionary = poker_deck.pop_back()
	return card


func _draw_blackjack_card() -> Dictionary:
	if blackjack_deck.is_empty():
		blackjack_deck = _build_poker_deck()
		blackjack_deck.shuffle()
	var card: Dictionary = blackjack_deck.pop_back()
	return card


func _draw_three_card() -> Dictionary:
	if three_card_deck.is_empty():
		three_card_deck = _build_poker_deck()
		three_card_deck.shuffle()
	var card: Dictionary = three_card_deck.pop_back()
	return card


func _draw_pai_gow_card() -> Dictionary:
	if pai_gow_deck.is_empty():
		pai_gow_deck = _build_poker_deck()
		pai_gow_deck.shuffle()
	var card: Dictionary = pai_gow_deck.pop_back()
	return card


func _draw_baccarat_card() -> Dictionary:
	if baccarat_deck.is_empty():
		baccarat_deck = _build_poker_deck()
		baccarat_deck.shuffle()
	var card: Dictionary = baccarat_deck.pop_back()
	return card


func _draw_criss_cross_card() -> Dictionary:
	if criss_cross_deck.is_empty():
		criss_cross_deck = _build_poker_deck()
		criss_cross_deck.shuffle()
	var card: Dictionary = criss_cross_deck.pop_back()
	return card


func _apply_baccarat_draw_rules() -> void:
	var player_total := _baccarat_total(baccarat_player_cards)
	var banker_total := _baccarat_total(baccarat_banker_cards)
	if player_total >= 8 or banker_total >= 8:
		return

	var player_third := -1
	if player_total <= 5:
		var card := _draw_baccarat_card()
		baccarat_player_cards.append(card)
		player_third = _baccarat_card_value(card)

	banker_total = _baccarat_total(baccarat_banker_cards)
	if player_third == -1:
		if banker_total <= 5:
			baccarat_banker_cards.append(_draw_baccarat_card())
		return

	if _baccarat_banker_draws(banker_total, player_third):
		baccarat_banker_cards.append(_draw_baccarat_card())


func _baccarat_banker_draws(banker_total: int, player_third: int) -> bool:
	if banker_total <= 2:
		return true
	if banker_total == 3:
		return player_third != 8
	if banker_total == 4:
		return player_third >= 2 and player_third <= 7
	if banker_total == 5:
		return player_third >= 4 and player_third <= 7
	if banker_total == 6:
		return player_third == 6 or player_third == 7
	return false


func _baccarat_total(cards: Array) -> int:
	var total := 0
	for card in cards:
		total += _baccarat_card_value(card)
	return total % 10


func _baccarat_card_value(card: Dictionary) -> int:
	var rank := int(card["rank"])
	if rank == 14:
		return 1
	if rank >= 10:
		return 0
	return rank


func _baccarat_payout(bet: float, bet_side: String, winner: String) -> float:
	if bet_side != winner:
		return 0.0
	if winner == "Player":
		return bet * 2.0
	if winner == "Banker":
		return bet * 1.95
	return bet * 9.0


func _finish_three_card_round(message: String, payout: float) -> void:
	three_card_credits += payout
	three_card_total_paid += payout
	three_card_in_round = false
	three_card_reveal_dealer = true
	three_card_result_label.text = "%s Total paid $%.2f." % [message, payout]
	_refresh_three_card()


func _finish_blackjack_round(message: String, payout: float) -> void:
	blackjack_credits += payout
	blackjack_total_paid += payout
	blackjack_in_round = false
	blackjack_round_over = true
	blackjack_result_label.text = "%s Paid $%.2f." % [message, payout]
	_refresh_blackjack()


func _blackjack_hand_value(cards: Array) -> Dictionary:
	var total := 0
	var aces := 0
	for card_value in cards:
		var card: Dictionary = card_value
		var rank := int(card["rank"])
		if rank == 14:
			total += 11
			aces += 1
		else:
			total += min(rank, 10)

	while total > 21 and aces > 0:
		total -= 10
		aces -= 1

	return {
		"total": total,
		"soft": aces > 0,
	}


func _is_blackjack(cards: Array) -> bool:
	return cards.size() == 2 and int(_blackjack_hand_value(cards)["total"]) == 21


func _blackjack_dealer_total_text() -> String:
	if blackjack_dealer_cards.is_empty():
		return "Dealer"
	if blackjack_in_round and blackjack_dealer_cards.size() > 1:
		var showing := _blackjack_card_value(blackjack_dealer_cards[0])
		return "Dealer: showing %d" % showing
	return _blackjack_hand_total_text("Dealer", blackjack_dealer_cards)


func _blackjack_hand_total_text(name: String, cards: Array) -> String:
	if cards.is_empty():
		return name
	var value := _blackjack_hand_value(cards)
	return "%s: %d%s" % [
		name,
		int(value["total"]),
		" soft" if bool(value["soft"]) else "",
	]


func _blackjack_card_value(card: Dictionary) -> int:
	var rank := int(card["rank"])
	if rank == 14:
		return 11
	return min(rank, 10)


func _get_blackjack_strategy_tip() -> String:
	if blackjack_player_cards.is_empty():
		return "Tip: deal a hand to get a basic-strategy suggestion."
	if not blackjack_in_round:
		return "Tip: deal again for the next hand suggestion."

	var player := _blackjack_hand_value(blackjack_player_cards)
	var total := int(player["total"])
	var soft := bool(player["soft"])
	var dealer_up := _blackjack_card_value(blackjack_dealer_cards[0]) if not blackjack_dealer_cards.is_empty() else 10

	if total > 21:
		return "Tip: busted."
	if total == 21:
		return "Tip: stand on 21."
	if soft:
		if total >= 19:
			return "Tip: Stand. Soft %d is strong." % total
		if total == 18:
			if dealer_up >= 9 or dealer_up == 11:
				return "Tip: Hit soft 18 against a strong dealer card."
			return "Tip: Stand on soft 18."
		return "Tip: Hit soft %d." % total

	if total >= 17:
		return "Tip: Stand on hard %d." % total
	if total >= 13 and total <= 16:
		if dealer_up >= 2 and dealer_up <= 6:
			return "Tip: Stand. Dealer is showing %d." % dealer_up
		return "Tip: Hit hard %d against dealer %d." % [total, dealer_up]
	if total == 12:
		if dealer_up >= 4 and dealer_up <= 6:
			return "Tip: Stand on 12 against dealer %d." % dealer_up
		return "Tip: Hit hard 12."
	return "Tip: Hit hard %d." % total


func _pai_gow_split_from_indices(cards: Array, low_indices: Array) -> Dictionary:
	if cards.is_empty():
		return {}

	var low := []
	var high := []
	for i in cards.size():
		var card: Dictionary = cards[i]
		if low_indices.has(i):
			low.append(card)
		else:
			high.append(card)

	if low.size() != 2 or high.size() != 5:
		return {}

	return {
		"low": low,
		"high": high,
	}


func _pai_gow_house_way_low_indices(cards: Array) -> Array:
	if cards.size() != 7:
		return []

	var best_indices := [0, 1]
	var best_balance := -1
	var best_high := -1
	var best_low := -1
	for a in range(0, cards.size() - 1):
		for b in range(a + 1, cards.size()):
			var low_indices := [a, b]
			var split := _pai_gow_split_from_indices(cards, low_indices)
			if split.is_empty() or _pai_gow_split_is_foul(split):
				continue

			var low_score := _pai_gow_hand_score(_pai_gow_evaluate_two_card(split["low"]))
			var high_score := _pai_gow_hand_score(_pai_gow_evaluate_five_card(split["high"]))
			var balance: int = min(low_score, high_score)
			if balance > best_balance or (balance == best_balance and high_score > best_high) or (balance == best_balance and high_score == best_high and low_score > best_low):
				best_balance = balance
				best_high = high_score
				best_low = low_score
				best_indices = low_indices
	return best_indices


func _pai_gow_split_is_foul(split: Dictionary) -> bool:
	if split.is_empty():
		return false
	return _compare_pai_gow_evals(_pai_gow_evaluate_five_card(split["high"]), _pai_gow_evaluate_two_card(split["low"])) < 0


func _pai_gow_tip_text() -> String:
	if pai_gow_player_cards.is_empty():
		return "Tip: deal a hand to begin."
	if not pai_gow_in_round:
		return "Tip: deal again for a fresh seven-card puzzle."
	if pai_gow_low_indices.size() != 2:
		return "Tip: pick exactly two cards for Low, or use House Way."

	var split := _pai_gow_split_from_indices(pai_gow_player_cards, pai_gow_low_indices)
	if split.is_empty():
		return "Tip: pick exactly two cards for Low."
	if _pai_gow_split_is_foul(split):
		return "Tip: foul split. Move strength back to High."
	return "Tip: Low is %s. High is %s." % [
		_pai_gow_eval_name(_pai_gow_evaluate_two_card(split["low"])),
		_pai_gow_eval_name(_pai_gow_evaluate_five_card(split["high"])),
	]


func _pai_gow_evaluate_two_card(cards: Array) -> Dictionary:
	if cards.size() != 2:
		return {"name": "No Hand", "category": -1, "tiebreakers": []}

	var ranks := [int(cards[0]["rank"]), int(cards[1]["rank"])]
	ranks.sort()
	ranks.reverse()
	if int(ranks[0]) == int(ranks[1]):
		return {
			"name": "Pair of %s" % _rank_plural(int(ranks[0])),
			"category": 1,
			"tiebreakers": [int(ranks[0])],
		}

	return {
		"name": "%s-%s" % [_rank_label(int(ranks[0])), _rank_label(int(ranks[1]))],
		"category": 0,
		"tiebreakers": ranks,
	}


func _pai_gow_evaluate_five_card(cards: Array) -> Dictionary:
	if cards.size() != 5:
		return {"name": "No Hand", "category": -1, "tiebreakers": []}

	var ranks := []
	var suits := []
	var rank_counts := {}
	for card_value in cards:
		var card: Dictionary = card_value
		var rank := int(card["rank"])
		ranks.append(rank)
		suits.append(str(card["suit"]))
		rank_counts[rank] = int(rank_counts.get(rank, 0)) + 1

	ranks.sort()
	var is_flush := true
	for suit in suits:
		if suit != suits[0]:
			is_flush = false
			break

	var unique_ranks := []
	for rank in ranks:
		if not unique_ranks.has(rank):
			unique_ranks.append(rank)

	var straight_high := _pai_gow_straight_high(unique_ranks)
	var is_straight := straight_high > 0
	var count_values := []
	for count in rank_counts.values():
		count_values.append(int(count))
	count_values.sort()
	count_values.reverse()

	if is_flush and is_straight:
		return {"name": "Straight Flush", "category": 8, "tiebreakers": [straight_high]}
	if count_values[0] == 4:
		var quad := _rank_with_count(rank_counts, 4)
		return {"name": "Four of a Kind", "category": 7, "tiebreakers": [quad, _highest_except(ranks, [quad])]}
	if count_values[0] == 3 and count_values.size() > 1 and count_values[1] == 2:
		return {"name": "Full House", "category": 6, "tiebreakers": [_rank_with_count(rank_counts, 3), _rank_with_count(rank_counts, 2)]}
	if is_flush:
		return {"name": "Flush", "category": 5, "tiebreakers": _sorted_desc(ranks)}
	if is_straight:
		return {"name": "Straight", "category": 4, "tiebreakers": [straight_high]}
	if count_values[0] == 3:
		var trip := _rank_with_count(rank_counts, 3)
		var trip_breakers := [trip]
		trip_breakers.append_array(_sorted_except(ranks, [trip]))
		return {"name": "Three of a Kind", "category": 3, "tiebreakers": trip_breakers}
	if count_values[0] == 2 and count_values.size() > 1 and count_values[1] == 2:
		var pairs := []
		for rank in rank_counts.keys():
			if int(rank_counts[rank]) == 2:
				pairs.append(int(rank))
		pairs.sort()
		pairs.reverse()
		return {"name": "Two Pair", "category": 2, "tiebreakers": [pairs[0], pairs[1], _highest_except(ranks, pairs)]}
	if count_values[0] == 2:
		var pair := _rank_with_count(rank_counts, 2)
		var pair_breakers := [pair]
		pair_breakers.append_array(_sorted_except(ranks, [pair]))
		return {"name": "Pair of %s" % _rank_plural(pair), "category": 1, "tiebreakers": pair_breakers}

	return {"name": "High Card", "category": 0, "tiebreakers": _sorted_desc(ranks)}


func _pai_gow_straight_high(unique_ranks: Array) -> int:
	if unique_ranks.size() != 5:
		return 0
	if unique_ranks == [2, 3, 4, 5, 14]:
		return 5
	var high_rank := int(unique_ranks[unique_ranks.size() - 1])
	var low_rank := int(unique_ranks[0])
	if high_rank - low_rank == 4:
		return high_rank
	return 0


func _compare_pai_gow_evals(left: Dictionary, right: Dictionary) -> int:
	var left_category := int(left["category"])
	var right_category := int(right["category"])
	if left_category > right_category:
		return 1
	if left_category < right_category:
		return -1

	var left_breakers: Array = left["tiebreakers"]
	var right_breakers: Array = right["tiebreakers"]
	for i in range(0, min(left_breakers.size(), right_breakers.size())):
		if int(left_breakers[i]) > int(right_breakers[i]):
			return 1
		if int(left_breakers[i]) < int(right_breakers[i]):
			return -1
	if left_breakers.size() > right_breakers.size():
		return 1
	if left_breakers.size() < right_breakers.size():
		return -1
	return 0


func _pai_gow_hand_score(eval: Dictionary) -> int:
	var score := int(eval["category"])
	var breakers: Array = eval["tiebreakers"]
	for i in range(0, 5):
		score *= 15
		if i < breakers.size():
			score += int(breakers[i])
	return score


func _pai_gow_eval_name(eval: Dictionary) -> String:
	return str(eval.get("name", "No Hand"))


func _criss_cross_across_eval() -> Dictionary:
	return _criss_cross_eval_five(_criss_cross_across_cards())


func _criss_cross_down_eval() -> Dictionary:
	return _criss_cross_eval_five(_criss_cross_down_cards())


func _criss_cross_across_cards() -> Array:
	var cards := _duplicate_poker_cards(criss_cross_player_cards)
	for index in [0, 1, 2]:
		if index < criss_cross_community_cards.size():
			cards.append(criss_cross_community_cards[index])
	return cards


func _criss_cross_down_cards() -> Array:
	var cards := _duplicate_poker_cards(criss_cross_player_cards)
	for index in [3, 1, 4]:
		if index < criss_cross_community_cards.size():
			cards.append(criss_cross_community_cards[index])
	return cards


func _criss_cross_eval_five(cards: Array) -> Dictionary:
	if cards.size() != 5:
		return {"name": "No Hand", "category": -1, "tiebreakers": [], "pair_rank": 0}

	var eval := _pai_gow_evaluate_five_card(cards)
	var result := eval.duplicate(true)
	var category := int(result["category"])
	var tiebreakers: Array = result["tiebreakers"]
	var pair_rank := 0
	if category == 1 and not tiebreakers.is_empty():
		pair_rank = int(tiebreakers[0])
	result["pair_rank"] = pair_rank
	if str(result["name"]) == "Straight Flush" and not tiebreakers.is_empty() and int(tiebreakers[0]) == 14:
		result["name"] = "Royal Flush"
		result["category"] = 9
	return result


func _criss_cross_outcome(eval: Dictionary) -> String:
	var category := int(eval["category"])
	if category >= 2:
		return "win"
	if category == 1:
		var pair_rank := int(eval.get("pair_rank", 0))
		if pair_rank >= 11:
			return "win"
		if pair_rank >= 6:
			return "push"
	return "lose"


func _criss_cross_main_pay_key(eval: Dictionary) -> String:
	var category := int(eval["category"])
	if category == 1:
		var pair_rank := int(eval.get("pair_rank", 0))
		if pair_rank >= 11:
			return "Jacks or Better"
		if pair_rank >= 6:
			return "Pair 6s through 10s"
		return "Nothing"
	return str(eval["name"])


func _criss_cross_bonus_pay_key(eval: Dictionary) -> String:
	var category := int(eval["category"])
	if category == 1:
		return "Sixes or Better" if int(eval.get("pair_rank", 0)) >= 6 else "Nothing"
	return str(eval["name"])


func _criss_cross_ante_return(ante: float, eval: Dictionary) -> float:
	var outcome := _criss_cross_outcome(eval)
	if outcome == "win":
		return ante * 2.0
	if outcome == "push":
		return ante
	return 0.0


func _criss_cross_play_return(bet: float, eval: Dictionary) -> float:
	var outcome := _criss_cross_outcome(eval)
	if outcome == "push":
		return bet
	if outcome != "win":
		return 0.0
	var pay_key := _criss_cross_main_pay_key(eval)
	return bet * float(int(CRISS_CROSS_MAIN_PAYOUTS.get(pay_key, 0)) + 1)


func _criss_cross_middle_return(bet: float, across_eval: Dictionary, down_eval: Dictionary) -> float:
	var across_outcome := _criss_cross_outcome(across_eval)
	var down_outcome := _criss_cross_outcome(down_eval)
	if across_outcome == "win" or down_outcome == "win":
		var best_eval := across_eval if _compare_pai_gow_evals(across_eval, down_eval) >= 0 else down_eval
		var pay_key := _criss_cross_main_pay_key(best_eval)
		return bet * float(int(CRISS_CROSS_MAIN_PAYOUTS.get(pay_key, 0)) + 1)
	if across_outcome == "push" or down_outcome == "push":
		return bet
	return 0.0


func _criss_cross_bonus_return() -> float:
	if criss_cross_current_bonus <= 0.0 or criss_cross_community_cards.size() != 5:
		return 0.0
	var eval := _criss_cross_eval_five(criss_cross_community_cards)
	var pay_key := _criss_cross_bonus_pay_key(eval)
	if not CRISS_CROSS_BONUS_PAYOUTS.has(pay_key):
		return 0.0
	return criss_cross_current_bonus * float(int(CRISS_CROSS_BONUS_PAYOUTS[pay_key]) + 1)


func _criss_cross_outcome_text(eval: Dictionary) -> String:
	match _criss_cross_outcome(eval):
		"win":
			return "wins"
		"push":
			return "pushes"
	return "loses"


func _criss_cross_play_text(eval: Dictionary) -> String:
	var outcome := _criss_cross_outcome(eval)
	if outcome == "push":
		return "push"
	if outcome != "win":
		return "lose"
	return "%d:1" % int(CRISS_CROSS_MAIN_PAYOUTS.get(_criss_cross_main_pay_key(eval), 0))


func _criss_cross_bonus_text(eval: Dictionary) -> String:
	var pay_key := _criss_cross_bonus_pay_key(eval)
	if not CRISS_CROSS_BONUS_PAYOUTS.has(pay_key):
		return "loses"
	return "%s pays %d:1" % [pay_key, int(CRISS_CROSS_BONUS_PAYOUTS[pay_key])]


func _criss_cross_across_tip() -> String:
	if criss_cross_player_cards.size() != 2:
		return "Tip: deal a hand to start."
	var ranks := [int(criss_cross_player_cards[0]["rank"]), int(criss_cross_player_cards[1]["rank"])]
	ranks.sort()
	if ranks[0] == ranks[1]:
		return "Tip: any pair is a strong start for the Across bet."
	if str(criss_cross_player_cards[0]["suit"]) == str(criss_cross_player_cards[1]["suit"]) and ranks[0] >= 11:
		return "Tip: suited high cards have strong royal and flush potential."
	if ranks[1] <= 5:
		return "Tip: weak low cards are the usual fold candidate."
	return "Tip: most playable starts continue with at least a 1x Across bet."


func _highest_except(ranks: Array, excluded: Array) -> int:
	for rank in _sorted_desc(ranks):
		if not excluded.has(int(rank)):
			return int(rank)
	return 0


func _sorted_except(ranks: Array, excluded: Array) -> Array:
	var kept := []
	for rank in ranks:
		if not excluded.has(int(rank)):
			kept.append(int(rank))
	return _sorted_desc(kept)


func _evaluate_three_card_hand(cards: Array) -> Dictionary:
	var ranks := []
	var suits := []
	var rank_counts := {}
	for card_value in cards:
		var card: Dictionary = card_value
		var rank := int(card["rank"])
		ranks.append(rank)
		suits.append(str(card["suit"]))
		rank_counts[rank] = int(rank_counts.get(rank, 0)) + 1

	ranks.sort()
	var is_flush: bool = suits.size() == 3 and suits[0] == suits[1] and suits[1] == suits[2]
	var straight_high := _three_card_straight_high(ranks)
	var is_straight := straight_high > 0
	var counts := rank_counts.values()
	var name := "High Card"
	var category := 0
	var tiebreakers := _sorted_desc(ranks)

	if is_flush and is_straight:
		name = "Straight Flush"
		category = 5
		tiebreakers = [straight_high]
	elif counts.has(3):
		name = "Three of a Kind"
		category = 4
		tiebreakers = [_rank_with_count(rank_counts, 3)]
	elif is_straight:
		name = "Straight"
		category = 3
		tiebreakers = [straight_high]
	elif is_flush:
		name = "Flush"
		category = 2
	elif counts.has(2):
		name = "Pair"
		category = 1
		var pair_rank := _rank_with_count(rank_counts, 2)
		tiebreakers = [pair_rank]
		for rank in _sorted_desc(ranks):
			if rank != pair_rank:
				tiebreakers.append(rank)
	else:
		tiebreakers = _sorted_desc(ranks)

	return {
		"name": name,
		"category": category,
		"tiebreakers": tiebreakers,
	}


func _compare_three_card_hands(player_eval: Dictionary, dealer_eval: Dictionary) -> int:
	var player_category := int(player_eval["category"])
	var dealer_category := int(dealer_eval["category"])
	if player_category > dealer_category:
		return 1
	if player_category < dealer_category:
		return -1

	var player_breakers: Array = player_eval["tiebreakers"]
	var dealer_breakers: Array = dealer_eval["tiebreakers"]
	for i in range(0, min(player_breakers.size(), dealer_breakers.size())):
		if int(player_breakers[i]) > int(dealer_breakers[i]):
			return 1
		if int(player_breakers[i]) < int(dealer_breakers[i]):
			return -1
	return 0


func _three_card_dealer_qualifies(dealer_eval: Dictionary) -> bool:
	if int(dealer_eval["category"]) > 0:
		return true
	var tiebreakers: Array = dealer_eval["tiebreakers"]
	return not tiebreakers.is_empty() and int(tiebreakers[0]) >= 12


func _three_card_pair_plus_payout(player_eval: Dictionary) -> float:
	if three_card_current_pair_plus <= 0.0:
		return 0.0
	var hand_name := str(player_eval["name"])
	if not THREE_CARD_PAIR_PLUS_PAYOUTS.has(hand_name):
		return 0.0
	return three_card_current_pair_plus * float(int(THREE_CARD_PAIR_PLUS_PAYOUTS[hand_name]) + 1)


func _three_card_ante_bonus(player_eval: Dictionary) -> float:
	var hand_name := str(player_eval["name"])
	if not THREE_CARD_ANTE_BONUS.has(hand_name):
		return 0.0
	return three_card_current_ante * float(int(THREE_CARD_ANTE_BONUS[hand_name]))


func _get_three_card_strategy_tip() -> String:
	if three_card_player_cards.is_empty():
		return "Tip: deal a hand to get a Play/Fold suggestion."
	if not three_card_in_round:
		return "Tip: deal again for the next hand."

	var player_eval := _evaluate_three_card_hand(three_card_player_cards)
	if int(player_eval["category"]) > 0:
		return "Tip: Play. %s is worth continuing." % str(player_eval["name"])

	var tiebreakers: Array = player_eval["tiebreakers"]
	var q64_or_better := tiebreakers.size() == 3 and int(tiebreakers[0]) >= 12 and int(tiebreakers[1]) >= 6 and int(tiebreakers[2]) >= 4
	if q64_or_better:
		return "Tip: Play. Queen-6-4 or better is the usual cutoff."
	return "Tip: Fold. Below Queen-6-4 is usually too weak."


func _three_card_hand_label(name: String, cards: Array, hidden: bool) -> String:
	if cards.is_empty():
		return name
	if hidden:
		return "%s: hidden" % name
	var eval := _evaluate_three_card_hand(cards)
	return "%s: %s" % [name, str(eval["name"])]


func _three_card_straight_high(ranks: Array) -> int:
	var unique := []
	for rank in ranks:
		if not unique.has(rank):
			unique.append(rank)
	if unique.size() != 3:
		return 0
	if unique == [2, 3, 14]:
		return 3
	if int(unique[2]) - int(unique[0]) == 2:
		return int(unique[2])
	return 0


func _rank_with_count(rank_counts: Dictionary, count: int) -> int:
	for rank in rank_counts.keys():
		if int(rank_counts[rank]) == count:
			return int(rank)
	return 0


func _sorted_desc(values: Array) -> Array:
	var sorted := values.duplicate()
	sorted.sort()
	sorted.reverse()
	return sorted


func _get_poker_strategy_tip(cards: Array) -> Dictionary:
	if cards.size() != POKER_HAND_SIZE:
		return {}

	var all_cards := [0, 1, 2, 3, 4]
	var hand_name := str(_evaluate_poker_hand(cards)["hand"])
	if hand_name == "Royal Flush" or hand_name == "Straight Flush":
		return _build_poker_tip("Best made hand. Hold all five cards.", all_cards, cards)
	if hand_name == "Four of a Kind":
		return _build_poker_tip("Hold the four of a kind and draw one.", _indices_for_rank_count(cards, 4), cards)

	var four_royal := _royal_flush_draw_indices(cards, 4)
	if not four_royal.is_empty():
		return _build_poker_tip("Strong draw. Hold four to a Royal Flush.", four_royal, cards)

	if hand_name == "Full House" or hand_name == "Flush" or hand_name == "Straight":
		return _build_poker_tip("Made paying hand. Hold all five cards.", all_cards, cards)
	if hand_name == "Three of a Kind":
		return _build_poker_tip("Hold the three of a kind and draw two.", _indices_for_rank_count(cards, 3), cards)

	var straight_flush_draw := _straight_flush_draw_indices(cards)
	if not straight_flush_draw.is_empty():
		return _build_poker_tip("Good draw. Hold four to a Straight Flush.", straight_flush_draw, cards)
	if hand_name == "Two Pair":
		return _build_poker_tip("Hold both pairs and draw one.", _indices_for_all_pairs(cards), cards)
	if hand_name == "Jacks or Better":
		return _build_poker_tip("Hold the high pair.", _indices_for_high_pair(cards), cards)

	var three_royal := _royal_flush_draw_indices(cards, 3)
	if not three_royal.is_empty():
		return _build_poker_tip("Worth chasing. Hold three to a Royal Flush.", three_royal, cards)

	var flush_draw := _flush_draw_indices(cards)
	if not flush_draw.is_empty():
		return _build_poker_tip("Hold four to a Flush.", flush_draw, cards)

	var low_pair := _indices_for_rank_count(cards, 2)
	if not low_pair.is_empty():
		return _build_poker_tip("Hold the pair and draw three.", low_pair, cards)

	var outside_straight := _outside_straight_draw_indices(cards)
	if not outside_straight.is_empty():
		return _build_poker_tip("Hold four to an outside Straight.", outside_straight, cards)

	var high_suited := _suited_high_card_indices(cards)
	if high_suited.size() >= 2:
		return _build_poker_tip("Hold the two suited high cards.", high_suited, cards)

	var high_cards := _high_card_indices(cards)
	if not high_cards.is_empty():
		return _build_poker_tip("No strong draw. Hold the highest card.", [high_cards[0]], cards)

	return _build_poker_tip("No strong keep. Draw five new cards.", [], cards)


func _build_poker_tip(reason: String, holds: Array, cards: Array) -> Dictionary:
	if holds.is_empty():
		return {
			"text": "Tip: %s" % reason,
			"holds": holds,
		}

	return {
		"text": "Tip: %s Hold %s." % [reason, _format_poker_hold_cards(holds, cards)],
		"holds": holds,
	}


func _get_poker_card_texture(card: Dictionary) -> Texture2D:
	var path := str(card.get("image_path", ""))
	if path.is_empty():
		return null
	if poker_card_textures.has(path):
		return poker_card_textures[path]

	var texture: Texture2D = null
	if ResourceLoader.exists(path):
		texture = load(path)
	if texture == null and FileAccess.file_exists(path):
		var image := Image.load_from_file(path)
		if image != null and not image.is_empty():
			texture = ImageTexture.create_from_image(image)
	poker_card_textures[path] = texture
	return texture


func _poker_card_image_path(suit: String, rank: int) -> String:
	var prefix := _poker_suit_file_prefix(suit)
	var preferred_path := "%s/%s_%s.png" % [POKER_CARD_DIR, prefix, _poker_rank_file_name(rank)]
	if ResourceLoader.exists(preferred_path) or FileAccess.file_exists(preferred_path):
		return preferred_path

	var existing_path := _find_poker_card_image_path(prefix, rank)
	if not existing_path.is_empty():
		return existing_path

	return preferred_path


func _poker_suit_file_prefix(suit: String) -> String:
	match suit:
		"S":
			return "SPADES"
		"H":
			return "HEARTS"
		"D":
			return "DIAMONDS"
		"C":
			return "CLUBS"
	return suit


func _poker_rank_file_name(rank: int) -> String:
	match rank:
		11:
			return "JACK"
		12:
			return "QUEEN"
		13:
			return "KING"
		14:
			return "ACE"
	return str(rank)


func _find_poker_card_image_path(suit_prefix: String, rank: int) -> String:
	var files := DirAccess.get_files_at(POKER_CARD_DIR)
	var suit_key := suit_prefix.to_upper()
	var long_rank_key := _poker_rank_file_name(rank).to_upper()
	var short_rank_key := _rank_label(rank).to_upper()

	for file in files:
		if not str(file).to_lower().ends_with(".png"):
			continue

		var basename := str(file).get_basename().to_upper().replace(" ", "")
		var suit_marker := "%s_" % suit_key
		if not basename.begins_with(suit_marker):
			continue

		var rank_suffix := basename.substr(suit_marker.length())
		if _poker_rank_suffix_matches(rank_suffix, long_rank_key, short_rank_key, rank):
			return "%s/%s" % [POKER_CARD_DIR, file]

	return ""


func _poker_rank_suffix_matches(rank_suffix: String, long_rank_key: String, short_rank_key: String, rank: int) -> bool:
	if rank_suffix == long_rank_key or rank_suffix == short_rank_key:
		return true
	if rank_suffix.ends_with("_%s" % long_rank_key) or rank_suffix.ends_with("_%s" % short_rank_key):
		return true
	return rank == 6 and rank_suffix.is_empty()


func _indices_for_rank_count(cards: Array, count: int) -> Array:
	var rank_indices := _rank_indices(cards)
	for rank in rank_indices.keys():
		var indices: Array = rank_indices[rank]
		if indices.size() == count:
			return indices
	return []


func _indices_for_all_pairs(cards: Array) -> Array:
	var holds := []
	var rank_indices := _rank_indices(cards)
	for rank in rank_indices.keys():
		var indices: Array = rank_indices[rank]
		if indices.size() == 2:
			holds.append_array(indices)
	holds.sort()
	return holds


func _indices_for_high_pair(cards: Array) -> Array:
	var rank_indices := _rank_indices(cards)
	for rank in rank_indices.keys():
		var indices: Array = rank_indices[rank]
		if int(rank) >= 11 and indices.size() == 2:
			return indices
	return []


func _royal_flush_draw_indices(cards: Array, needed: int) -> Array:
	var royal_ranks := [10, 11, 12, 13, 14]
	for suit in POKER_SUITS:
		var indices := []
		for i in cards.size():
			var card: Dictionary = cards[i]
			if str(card["suit"]) == suit and royal_ranks.has(int(card["rank"])):
				indices.append(i)
		if indices.size() >= needed:
			return indices.slice(0, needed)
	return []


func _straight_flush_draw_indices(cards: Array) -> Array:
	for suit in POKER_SUITS:
		var suited_indices := []
		for i in cards.size():
			var card: Dictionary = cards[i]
			if str(card["suit"]) == suit:
				suited_indices.append(i)
		var combo := _first_four_card_straight_draw(cards, suited_indices)
		if not combo.is_empty():
			return combo
	return []


func _flush_draw_indices(cards: Array) -> Array:
	for suit in POKER_SUITS:
		var indices := []
		for i in cards.size():
			var card: Dictionary = cards[i]
			if str(card["suit"]) == suit:
				indices.append(i)
		if indices.size() >= 4:
			return indices.slice(0, 4)
	return []


func _outside_straight_draw_indices(cards: Array) -> Array:
	return _first_four_card_straight_draw(cards, [0, 1, 2, 3, 4], true)


func _suited_high_card_indices(cards: Array) -> Array:
	for suit in POKER_SUITS:
		var indices := []
		for i in cards.size():
			var card: Dictionary = cards[i]
			if str(card["suit"]) == suit and int(card["rank"]) >= 11:
				indices.append(i)
		if indices.size() >= 2:
			return indices.slice(0, 2)
	return []


func _high_card_indices(cards: Array) -> Array:
	var indices := []
	for i in cards.size():
		var card: Dictionary = cards[i]
		if int(card["rank"]) >= 11:
			indices.append(i)
	indices.sort_custom(func(a, b) -> bool:
		return int(cards[a]["rank"]) > int(cards[b]["rank"])
	)
	return indices


func _first_four_card_straight_draw(cards: Array, candidate_indices: Array, outside_only := false) -> Array:
	if candidate_indices.size() < 4:
		return []

	for a in range(0, candidate_indices.size() - 3):
		for b in range(a + 1, candidate_indices.size() - 2):
			for c in range(b + 1, candidate_indices.size() - 1):
				for d in range(c + 1, candidate_indices.size()):
					var combo := [
						candidate_indices[a],
						candidate_indices[b],
						candidate_indices[c],
						candidate_indices[d],
					]
					if outside_only:
						if _is_outside_straight_draw(cards, combo):
							return combo
					elif _is_straight_draw(cards, combo):
						return combo
	return []


func _is_straight_draw(cards: Array, indices: Array) -> bool:
	var ranks := _unique_ranks_for_indices(cards, indices)
	if ranks.size() != 4:
		return false

	for straight in _straight_rank_sets():
		var hits := 0
		for rank in ranks:
			if straight.has(rank):
				hits += 1
		if hits == 4:
			return true
	return false


func _is_outside_straight_draw(cards: Array, indices: Array) -> bool:
	var ranks := _unique_ranks_for_indices(cards, indices)
	if ranks.size() != 4:
		return false
	ranks.sort()
	return int(ranks[3]) - int(ranks[0]) == 3


func _straight_rank_sets() -> Array:
	return [
		[14, 2, 3, 4, 5],
		[2, 3, 4, 5, 6],
		[3, 4, 5, 6, 7],
		[4, 5, 6, 7, 8],
		[5, 6, 7, 8, 9],
		[6, 7, 8, 9, 10],
		[7, 8, 9, 10, 11],
		[8, 9, 10, 11, 12],
		[9, 10, 11, 12, 13],
		[10, 11, 12, 13, 14],
	]


func _unique_ranks_for_indices(cards: Array, indices: Array) -> Array:
	var ranks := []
	for index in indices:
		var card: Dictionary = cards[index]
		var rank := int(card["rank"])
		if not ranks.has(rank):
			ranks.append(rank)
	return ranks


func _rank_indices(cards: Array) -> Dictionary:
	var rank_indices := {}
	for i in cards.size():
		var card: Dictionary = cards[i]
		var rank := int(card["rank"])
		if not rank_indices.has(rank):
			rank_indices[rank] = []
		rank_indices[rank].append(i)
	return rank_indices


func _evaluate_poker_hand(cards: Array) -> Dictionary:
	var ranks := []
	var suits := []
	var rank_counts := {}
	for card_value in cards:
		var card: Dictionary = card_value
		var rank := int(card["rank"])
		ranks.append(rank)
		suits.append(str(card["suit"]))
		rank_counts[rank] = int(rank_counts.get(rank, 0)) + 1

	ranks.sort()
	var is_flush := true
	for suit in suits:
		if suit != suits[0]:
			is_flush = false
			break

	var unique_ranks := []
	for rank in ranks:
		if not unique_ranks.has(rank):
			unique_ranks.append(rank)

	var is_wheel := unique_ranks == [2, 3, 4, 5, 14]
	var high_rank := int(unique_ranks[unique_ranks.size() - 1])
	var low_rank := int(unique_ranks[0])
	var is_straight := unique_ranks.size() == POKER_HAND_SIZE and (high_rank - low_rank == 4 or is_wheel)
	var count_values := []
	for count in rank_counts.values():
		count_values.append(int(count))
	count_values.sort()
	count_values.reverse()

	var hand_name := "Nothing"
	if is_flush and unique_ranks == [10, 11, 12, 13, 14]:
		hand_name = "Royal Flush"
	elif is_flush and is_straight:
		hand_name = "Straight Flush"
	elif count_values[0] == 4:
		hand_name = "Four of a Kind"
	elif count_values[0] == 3 and count_values.size() > 1 and count_values[1] == 2:
		hand_name = "Full House"
	elif is_flush:
		hand_name = "Flush"
	elif is_straight:
		hand_name = "Straight"
	elif count_values[0] == 3:
		hand_name = "Three of a Kind"
	elif count_values[0] == 2 and count_values.size() > 1 and count_values[1] == 2:
		hand_name = "Two Pair"
	elif _has_jacks_or_better_pair(rank_counts):
		hand_name = "Jacks or Better"

	return {
		"hand": hand_name,
		"multiplier": int(POKER_PAYOUTS[hand_name]),
	}


func _has_jacks_or_better_pair(rank_counts: Dictionary) -> bool:
	for rank in rank_counts.keys():
		if int(rank) >= 11 and int(rank_counts[rank]) == 2:
			return true
	return false


func _count_matches(picks: Array, draw: Array) -> int:
	var matches := 0
	for number in picks:
		if draw.has(number):
			matches += 1
	return matches


func _get_payout_multiplier(spots: int, matches: int) -> int:
	if not PAYOUT_TABLE.has(spots):
		return 0
	var row: Dictionary = PAYOUT_TABLE[spots]
	return int(row.get(matches, 0))


func _owners_for_number(number: int) -> Array:
	var owners := []
	for i in CARD_COUNT:
		if card_picks[i].has(number):
			owners.append(i)
	return owners


func _get_hot_numbers(count: int) -> Array:
	var numbers := _numbers_sorted_by_hits(false)
	return numbers.slice(0, min(count, numbers.size()))


func _get_cold_numbers(count: int) -> Array:
	var numbers := _numbers_sorted_by_hits(true)
	return numbers.slice(0, min(count, numbers.size()))


func _numbers_sorted_by_hits(ascending: bool) -> Array:
	var numbers := []
	for number in range(1, NUMBER_MAX + 1):
		numbers.append(number)
	numbers.sort_custom(func(a, b) -> bool:
		if number_hit_counts[a] == number_hit_counts[b]:
			return a < b
		if ascending:
			return number_hit_counts[a] < number_hit_counts[b]
		return number_hit_counts[a] > number_hit_counts[b]
	)
	return numbers


func _format_count_list(numbers: Array) -> String:
	var parts := []
	for number in numbers:
		parts.append("%d (%d)" % [number, number_hit_counts[number]])
	return ", ".join(parts)


func _format_hit_tally() -> String:
	if hit_tally.is_empty():
		return "Hit Tally: no card results yet."

	var spots_played := hit_tally.keys()
	spots_played.sort()

	var lines := ["Hit Tally (all played cards):"]
	for spots in spots_played:
		var spot_tally: Dictionary = hit_tally[spots]
		var plays := 0
		for matches in range(0, int(spots) + 1):
			plays += int(spot_tally.get(matches, 0))

		lines.append("%d-spot, %d plays" % [int(spots), plays])

		var match_parts := []
		for matches in range(int(spots), -1, -1):
			match_parts.append("%d/%d: %d" % [
				matches,
				int(spots),
				int(spot_tally.get(matches, 0)),
			])
		lines.append("  %s" % ", ".join(match_parts))

	return "\n".join(lines)


func _card_label(index: int) -> String:
	if index >= 0 and index < CARD_LABELS.size():
		return CARD_LABELS[index]
	return str(index + 1)


func _format_card_pick_text(picks: Array) -> String:
	if picks.is_empty():
		return ""

	var first_line := []
	var second_line := []
	for i in picks.size():
		if i < 5:
			first_line.append(str(picks[i]))
		else:
			second_line.append(str(picks[i]))

	if second_line.is_empty():
		return ", ".join(first_line)
	return "%s\n%s" % [", ".join(first_line), ", ".join(second_line)]


func _format_recent_runs_tally() -> String:
	if recent_runs.is_empty():
		return "Last 100 runs: no runs yet."

	var total_hits := 0
	var total_won := 0.0
	var total_net := 0.0
	for run_value in recent_runs:
		var run: Dictionary = run_value
		total_hits += int(run["hits"])
		total_won += float(run["paid"])
		total_net += float(run["net"])

	var lines := []
	lines.append("Last %d runs: %d hits, won $%.2f, net %s" % [
		recent_runs.size(),
		total_hits,
		total_won,
		_format_signed_money(total_net),
	])

	var start_index := recent_runs.size() - 12
	if start_index < 0:
		start_index = 0

	lines.append("Recent:")
	for i in range(recent_runs.size() - 1, start_index - 1, -1):
		var run: Dictionary = recent_runs[i]
		lines.append("R%d: %d hits, won $%.2f, net %s" % [
			int(run["round"]),
			int(run["hits"]),
			float(run["paid"]),
			_format_signed_money(float(run["net"])),
		])

	return "\n".join(lines)


func _format_signed_money(value: float) -> String:
	if value >= 0.0:
		return "+$%.2f" % value
	return "-$%.2f" % abs(value)


func _format_signed_whole(value: float) -> String:
	if value >= 0.0:
		return "+%.0f" % value
	return "%.0f" % value


func _stringify_numbers(numbers: Array, limit: int) -> Array:
	var parts := []
	var max_count: int = min(limit, numbers.size())
	for i in max_count:
		parts.append(str(numbers[i]))
	if numbers.size() > limit:
		parts.append("...")
	return parts


func _number_tooltip(number: int, owners: Array, is_drawn: bool) -> String:
	var text := "Number %d" % number
	if not owners.is_empty():
		var cards := []
		for owner in owners:
			cards.append("Card %s" % _card_label(owner))
		text += "\nPicked on %s" % ", ".join(cards)
	if owners.size() > 1:
		text += "\n* means this number is picked on more than one card."
	if is_drawn:
		text += "\nHit in the last draw."
	text += "\nTotal hits: %d" % number_hit_counts[number]
	return text


func _format_payout_table() -> String:
	var lines := []
	for spots in range(1, 11):
		var row: Dictionary = PAYOUT_TABLE[spots]
		var hits := row.keys()
		hits.sort()
		var parts := []
		for hit_count in hits:
			parts.append("%d hit %.0fx" % [hit_count, row[hit_count]])
		lines.append("%d spot: %s" % [spots, ", ".join(parts)])
	return "\n".join(lines)


func _format_poker_paytable() -> String:
	var hands := [
		"Royal Flush",
		"Straight Flush",
		"Four of a Kind",
		"Full House",
		"Flush",
		"Straight",
		"Three of a Kind",
		"Two Pair",
		"Jacks or Better",
	]
	var lines := []
	for i in hands.size():
		var hand := str(hands[i])
		lines.append("%d  %s  %.0fx" % [i + 1, hand.to_upper(), POKER_PAYOUTS[hand]])
	lines.append("")
	lines.append("Pays are per active line.")
	return "\n".join(lines)


func _format_poker_hold_cards(indices: Array, cards: Array) -> String:
	var names := []
	for index in indices:
		var card: Dictionary = cards[index]
		names.append("%s of %s" % [_rank_label(int(card["rank"])), _poker_suit_name(str(card["suit"]))])
	return ", ".join(names)


func _rank_label(rank: int) -> String:
	match rank:
		11:
			return "J"
		12:
			return "Q"
		13:
			return "K"
		14:
			return "A"
	return str(rank)


func _rank_plural(rank: int) -> String:
	match rank:
		11:
			return "Jacks"
		12:
			return "Queens"
		13:
			return "Kings"
		14:
			return "Aces"
	return "%ds" % rank


func _poker_suit_color(suit: String) -> Color:
	if suit == "H" or suit == "D":
		return Color("#b02f34")
	return Color("#1d2329")


func _poker_suit_name(suit: String) -> String:
	match suit:
		"S":
			return "Spades"
		"H":
			return "Hearts"
		"D":
			return "Diamonds"
		"C":
			return "Clubs"
	return suit


func _poker_table_style() -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color("#163f34")
	style.border_color = Color("#315f50")
	style.border_blend = true
	style.set_border_width_all(3)
	style.set_corner_radius_all(8)
	style.shadow_color = Color("#000000c0")
	style.shadow_size = 18
	style.shadow_offset = Vector2(7, 10)
	style.content_margin_left = 10
	style.content_margin_right = 10
	style.content_margin_top = 10
	style.content_margin_bottom = 12
	return style


func _craps_table_style() -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color("#11523d")
	style.border_color = Color("#d4b45c")
	style.border_blend = true
	style.set_border_width_all(4)
	style.set_corner_radius_all(8)
	style.shadow_color = Color("#000000c8")
	style.shadow_size = 22
	style.shadow_offset = Vector2(8, 12)
	style.content_margin_left = 10
	style.content_margin_right = 10
	style.content_margin_top = 10
	style.content_margin_bottom = 12
	return style


func _craps_bet_spot_style(color: Color, border: Color, active := false, pressed := false) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = color.lightened(0.08) if active else color
	style.border_color = border
	style.border_blend = true
	style.set_border_width_all(4 if active else 2)
	style.set_corner_radius_all(7)
	style.shadow_color = Color("#000000bb")
	style.shadow_size = 8 if pressed else 18
	style.shadow_offset = Vector2(2, 4) if pressed else Vector2(7, 11)
	style.content_margin_left = 10
	style.content_margin_right = 10
	style.content_margin_top = 10 if pressed else 8
	style.content_margin_bottom = 8 if pressed else 10
	return style


func _apply_craps_zone_style(button: Button, has_chip: bool, disabled: bool) -> void:
	button.add_theme_stylebox_override("normal", _craps_zone_style(false, has_chip, disabled))
	button.add_theme_stylebox_override("hover", _craps_zone_style(true, has_chip, disabled))
	button.add_theme_stylebox_override("pressed", _craps_zone_style(true, true, disabled))
	button.add_theme_stylebox_override("disabled", _craps_zone_style(false, has_chip, true))
	var clear := Color(0, 0, 0, 0)
	button.add_theme_color_override("font_color", clear)
	button.add_theme_color_override("font_hover_color", clear)
	button.add_theme_color_override("font_pressed_color", clear)
	button.add_theme_color_override("font_disabled_color", clear)


func _apply_roulette_zone_style(button: Button, has_chip: bool, disabled: bool) -> void:
	button.add_theme_stylebox_override("normal", _roulette_zone_style(false, has_chip, disabled))
	button.add_theme_stylebox_override("hover", _roulette_zone_style(true, has_chip, disabled))
	button.add_theme_stylebox_override("pressed", _roulette_zone_style(true, true, disabled))
	button.add_theme_stylebox_override("disabled", _roulette_zone_style(false, has_chip, true))
	var clear := Color(0, 0, 0, 0)
	button.add_theme_color_override("font_color", clear)
	button.add_theme_color_override("font_hover_color", clear)
	button.add_theme_color_override("font_pressed_color", clear)
	button.add_theme_color_override("font_disabled_color", clear)


func _roulette_zone_style(hovered: bool, has_chip: bool, disabled: bool) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color("#d7b84922") if hovered and not disabled else Color(0, 0, 0, 0)
	style.border_color = Color("#f6d85abf") if hovered and not disabled else Color(0, 0, 0, 0)
	if has_chip and not disabled:
		style.border_color = Color("#f6d85a7a")
		style.set_border_width_all(2)
	else:
		style.set_border_width_all(2 if hovered and not disabled else 0)
	style.set_corner_radius_all(4)
	return style


func _craps_zone_style(hovered: bool, has_chip: bool, disabled: bool) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color("#f5d0671e") if hovered and not disabled else Color(0, 0, 0, 0)
	style.border_color = Color("#f5d067bf") if hovered and not disabled else Color(0, 0, 0, 0)
	if has_chip and not disabled:
		style.border_color = Color("#f5d06766")
	style.set_border_width_all(2 if hovered and not disabled else 0)
	style.set_corner_radius_all(10)
	return style


func _craps_chip_style() -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color("#f8f3df")
	style.border_color = Color("#b61e2e")
	style.set_border_width_all(8)
	style.set_corner_radius_all(39)
	style.shadow_color = Color("#00000099")
	style.shadow_size = 14
	style.shadow_offset = Vector2(5, 8)
	style.content_margin_left = 4
	style.content_margin_right = 4
	style.content_margin_top = 4
	style.content_margin_bottom = 4
	return style


func _craps_selector_chip_style(selected: bool, pressed := false, disabled := false) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color("#f8f3df") if selected else Color("#3f4650dd")
	if disabled:
		style.bg_color = style.bg_color.darkened(0.22)
	style.border_color = Color("#f5d067") if selected else Color("#9aa4b2")
	style.set_border_width_all(5 if selected else 2)
	style.set_corner_radius_all(29)
	style.shadow_color = Color("#00000088")
	style.shadow_size = 7 if pressed else 13
	style.shadow_offset = Vector2(2, 4) if pressed else Vector2(5, 8)
	style.content_margin_left = 6
	style.content_margin_right = 6
	style.content_margin_top = 6
	style.content_margin_bottom = 6
	return style


func _craps_point_style(active: bool) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color("#f5d067") if active else Color("#1c2c29")
	style.border_color = Color("#fff4bd") if active else Color("#51766b")
	style.border_blend = true
	style.set_border_width_all(3 if active else 2)
	style.set_corner_radius_all(21)
	style.shadow_color = Color("#f5d06790") if active else Color("#00000088")
	style.shadow_size = 14 if active else 6
	style.shadow_offset = Vector2.ZERO if active else Vector2(2, 4)
	style.content_margin_left = 8
	style.content_margin_right = 8
	style.content_margin_top = 5
	style.content_margin_bottom = 5
	return style


func _poker_card_style(color: Color, border: Color, border_width: int, held := false, pressed := false) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.border_color = border.lightened(0.2)
	style.border_blend = true
	style.set_border_width_all(max(border_width, 2))
	style.set_corner_radius_all(7)
	style.shadow_color = Color("#000000c4")
	style.shadow_size = 12 if pressed else 24
	style.shadow_offset = Vector2(4, 6) if pressed else Vector2(12, 18)
	if held:
		style.shadow_color = Color("#000000dc")
		style.shadow_size = 30 if not pressed else 16
		style.shadow_offset = Vector2(14, 22) if not pressed else Vector2(5, 8)
	style.content_margin_left = 8
	style.content_margin_right = 8
	style.content_margin_top = 8
	style.content_margin_bottom = 8
	return style


func _poker_action_button_style(color: Color, border: Color, active := true, pressed := false) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.border_color = border.lightened(0.12)
	style.border_blend = true
	style.set_border_width_all(3 if active else 2)
	style.set_corner_radius_all(8)
	style.shadow_color = Color("#000000aa") if active else Color("#00000066")
	style.shadow_size = 7 if pressed else 16
	style.shadow_offset = Vector2(2, 3) if pressed else Vector2(6, 9)
	style.content_margin_left = 16
	style.content_margin_right = 16
	style.content_margin_top = 9 if pressed else 7
	style.content_margin_bottom = 7 if pressed else 9
	return style


func _panel_style(color: Color) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.border_color = color.lightened(0.28)
	style.border_blend = true
	style.set_border_width_all(2)
	style.set_corner_radius_all(8)
	style.shadow_color = Color("#00000099")
	style.shadow_size = 12
	style.shadow_offset = Vector2(5, 7)
	style.content_margin_left = 6
	style.content_margin_right = 6
	style.content_margin_top = 6
	style.content_margin_bottom = 6
	return style


func _button_style(color: Color, border: Color, border_width: int, pressed := false) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.border_color = border.lightened(0.18)
	style.border_blend = true
	style.set_border_width_all(max(border_width, 2))
	style.set_corner_radius_all(6)
	style.shadow_color = Color("#00000088")
	style.shadow_size = 2 if pressed else 7
	style.shadow_offset = Vector2(1, 1) if pressed else Vector2(3, 5)
	style.content_margin_left = 6
	style.content_margin_right = 6
	style.content_margin_top = 5 if pressed else 3
	style.content_margin_bottom = 3 if pressed else 5
	return style


func _keno_tube_style() -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color("#53606e")
	style.border_color = Color("#c2ccd8")
	style.border_blend = true
	style.set_border_width_all(3)
	style.set_corner_radius_all(17)
	style.shadow_color = Color("#00000099")
	style.shadow_size = 10
	style.shadow_offset = Vector2(4, 6)
	return style


func _keno_spout_style() -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color("#3b4654")
	style.border_color = Color("#a8b4c4")
	style.border_blend = true
	style.set_border_width_all(3)
	style.set_corner_radius_all(10)
	style.shadow_color = Color("#00000088")
	style.shadow_size = 8
	style.shadow_offset = Vector2(3, 5)
	return style


func _keno_ball_style(color: Color, border: Color, matched: bool) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.border_color = border
	style.border_blend = true
	style.set_border_width_all(3 if matched else 2)
	style.set_corner_radius_all(KENO_BALL_SIZE / 2)
	style.shadow_color = Color("#000000aa")
	style.shadow_size = 12 if matched else 8
	style.shadow_offset = Vector2(3, 5)
	style.content_margin_left = 4
	style.content_margin_right = 4
	style.content_margin_top = 4
	style.content_margin_bottom = 4
	return style


func _keno_ball_match_ring_style() -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color("#27b86c66")
	style.border_color = Color("#f5d067")
	style.border_blend = true
	style.set_border_width_all(4)
	style.set_corner_radius_all(KENO_BALL_SIZE / 2)
	style.shadow_color = Color("#f5d067aa")
	style.shadow_size = 14
	style.shadow_offset = Vector2.ZERO
	return style


func _keno_board_button_style(color: Color, border: Color, border_width: int, pressed := false) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.border_color = border
	style.border_blend = true
	style.set_border_width_all(border_width)
	style.set_corner_radius_all(2)
	style.shadow_color = Color("#00000088") if color.a > 0.0 else Color("#00000000")
	style.shadow_size = 4 if color.a > 0.0 else 0
	style.shadow_offset = Vector2(1, 2) if pressed else Vector2.ZERO
	style.content_margin_left = 0
	style.content_margin_right = 0
	style.content_margin_top = 0
	style.content_margin_bottom = 0
	return style


func _invert_color(color: Color) -> Color:
	return Color(1.0 - color.r, 1.0 - color.g, 1.0 - color.b, color.a)


func _apply_text_depth(label: Label) -> void:
	label.add_theme_color_override("font_shadow_color", Color("#000000aa"))
	label.add_theme_constant_override("shadow_offset_x", 2)
	label.add_theme_constant_override("shadow_offset_y", 2)


func _apply_button_text_depth(button: Button) -> void:
	button.add_theme_color_override("font_shadow_color", Color("#000000bb"))
	button.add_theme_constant_override("shadow_offset_x", 2)
	button.add_theme_constant_override("shadow_offset_y", 2)


func _apply_compact_control_text(control: Control, font_size: int) -> void:
	control.add_theme_font_size_override("font_size", font_size)
	for child in control.get_children():
		var child_control := child as Control
		if child_control != null:
			_apply_compact_control_text(child_control, font_size)


func _refresh_auto_play_button(playing: bool) -> void:
	if auto_play_button == null:
		return

	auto_play_button.text = "Stop Auto" if playing else "Auto Play"
	var bg := Color("#b63e3e") if playing else Color("#2f8f5b")
	auto_play_button.add_theme_stylebox_override("normal", _button_style(bg, Color("#00000044"), 2))
	auto_play_button.add_theme_stylebox_override("hover", _button_style(bg.lightened(0.08), Color("#f6f0df"), 2))
	auto_play_button.add_theme_stylebox_override("pressed", _button_style(bg.darkened(0.1), Color("#ffffff"), 3, true))
	auto_play_button.add_theme_color_override("font_color", Color("#ffffff"))
