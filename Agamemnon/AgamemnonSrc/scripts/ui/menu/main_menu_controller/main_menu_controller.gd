extends Control

@onready var clock_label: Label = $TopBar/MetaBox/Clock
@onready var player_name_label: Label = $PlayerCard/HBox/Info/Name
@onready var player_rank_label: Label = $PlayerCard/HBox/Info/Rank
@onready var server_status_label: Label = $RightInfo/ServerStatus
@onready var season_name_label: Label = $RightInfo/SeasonName
@onready var season_days_label: Label = $RightInfo/SeasonCountdown

@onready var btn_quick_match: Button = $MainContent/MenuList/MenuItem_QuickMatch
@onready var btn_practice: Button = $MainContent/MenuList/MenuItem_Practice
@onready var btn_custom: Button = $MainContent/MenuList/MenuItem_Custom
@onready var btn_codex: Button = $MainContent/MenuList/MenuItem_Codex
@onready var btn_stats: Button = $MainContent/MenuList/MenuItem_Stats
@onready var btn_settings: Button = $MainContent/MenuList/MenuItem_Settings
@onready var btn_quit: Button = $MainContent/MenuList/MenuItem_Quit

var _menu_buttons: Array[Button] = []

func _ready() -> void:
	_menu_buttons = [
		btn_quick_match, btn_practice, btn_custom,
		btn_codex, btn_stats, btn_settings, btn_quit
	]
	_connect_buttons()
	_refresh_all()
	_start_clock()

func _connect_buttons() -> void:
	btn_quick_match.pressed.connect(_on_quick_match_pressed)
	btn_practice.pressed.connect(_on_practice_pressed)
	btn_custom.pressed.connect(_on_custom_pressed)
	btn_codex.pressed.connect(_on_codex_pressed)
	btn_stats.pressed.connect(_on_stats_pressed)
	btn_settings.pressed.connect(_on_settings_pressed)
	btn_quit.pressed.connect(_on_quit_pressed)

	for btn in _menu_buttons:
		_apply_menu_button_normal(btn)
		btn.mouse_entered.connect(_on_menu_hover.bind(btn))
		btn.mouse_exited.connect(_on_menu_unhover.bind(btn))


func _make_menu_style(border_color: Color, bg_color: Color = Color.TRANSPARENT) -> StyleBoxFlat:
	var sb := StyleBoxFlat.new()
	sb.bg_color = bg_color
	sb.border_width_left = 3
	sb.border_color = border_color
	# 固定 margin，所有状态一致，避免 Container 重新布局导致抖动
	sb.content_margin_left = 12
	sb.content_margin_right = 0
	sb.content_margin_top = 2
	sb.content_margin_bottom = 2
	return sb


func _apply_menu_button_normal(btn: Button) -> void:
	btn.flat = false
	var normal := _make_menu_style(Color.TRANSPARENT)
	var hover := _make_menu_style(Color.TRANSPARENT)
	var pressed := _make_menu_style(Color.TRANSPARENT)
	var focus := _make_menu_style(Color.TRANSPARENT)
	btn.add_theme_stylebox_override("normal", normal)
	btn.add_theme_stylebox_override("hover", hover)
	btn.add_theme_stylebox_override("pressed", pressed)
	btn.add_theme_stylebox_override("focus", focus)
	btn.add_theme_stylebox_override("disabled", normal)

	var normal_color := Color(0.86, 0.85, 0.82, 1.0)
	btn.add_theme_color_override("font_color", normal_color)
	btn.add_theme_color_override("font_hover_color", normal_color)
	btn.add_theme_color_override("font_pressed_color", normal_color)
	btn.add_theme_color_override("font_focus_color", normal_color)


func _on_menu_hover(btn: Button) -> void:
	var hover := _make_menu_style(
		Color(0.788, 0.663, 0.38, 1.0),
		Color(0.788, 0.663, 0.38, 0.035)
	)
	btn.add_theme_stylebox_override("hover", hover)
	btn.add_theme_color_override("font_hover_color", Color(0.95, 0.90, 0.76, 1.0))


func _on_menu_unhover(btn: Button) -> void:
	var hover := _make_menu_style(Color.TRANSPARENT)
	btn.add_theme_stylebox_override("hover", hover)
	btn.add_theme_color_override("font_hover_color", Color(0.86, 0.85, 0.82, 1.0))


func _refresh_all() -> void:
	player_name_label.text = ScNodeContext.player_name
	player_rank_label.text = "%s · %d 分" % [ScNodeContext.player_tier, ScNodeContext.player_rank]
	server_status_label.text = "%s · 延迟 %d ms  ●" % [ScNodeContext.server_region, ScNodeContext.server_latency]
	season_name_label.text = "当前赛季 · %s" % ScNodeContext.season_name
	season_days_label.text = "距赛季结束 %d 日" % ScNodeContext.season_left_days


func _start_clock() -> void:
	_update_clock()
	var timer := Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.timeout.connect(_update_clock)
	add_child(timer)


func _update_clock() -> void:
	var t := Time.get_time_dict_from_system()
	clock_label.text = "%02d : %02d : %02d" % [t.hour, t.minute, t.second]


func _on_quick_match_pressed() -> void:
	print("[MainMenu] quick_match")
	ScNodeRouter.go_to_lobby()


func _on_practice_pressed() -> void:
	print("[MainMenu] practice")
	ScNodeRouter.go_to_lobby()


func _on_custom_pressed() -> void:
	print("[MainMenu] custom")
	ScNodeRouter.go_to_lobby()


func _on_codex_pressed() -> void:
	print("[MainMenu] codex")
	# TODO


func _on_stats_pressed() -> void:
	print("[MainMenu] stats")
	# TODO


func _on_settings_pressed() -> void:
	print("[MainMenu] settings")
	# TODO


func _on_quit_pressed() -> void:
	print("[MainMenu] quit → showing confirm dialog")
	Dialog.show_confirm(
		"退出游戏",
		"确定要离开拍卖场吗？",
		func(): ScNodeRouter.quit_game(),
		func(): print("[MainMenu] quit cancelled")
	)
