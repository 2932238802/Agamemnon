extends Control

@onready var back_btn: Button = $Body/CenterColumn/CenterVBox/ActionBar/BackButton
@onready var ready_btn: Button = $Body/CenterColumn/CenterVBox/ActionBar/ReadyButton
@onready var seat_ready_label: Label = $Body/CenterColumn/CenterVBox/SeatsRow/Seat_01/Seat01Inner/Seat01VBox/SeatReady
@onready var player_name_label: Label = $TopBar/TopBarHBox/RankDisplay

var _is_ready: bool = false


func _ready() -> void:
	print("[Lobby] ready")
	_refresh_player_info()
	back_btn.pressed.connect(_on_back_pressed)
	ready_btn.pressed.connect(_on_ready_toggled)


func _refresh_player_info() -> void:
	player_name_label.text = "%s · %d 分" % [ScNodeContext.player_tier, ScNodeContext.player_rank]


func _on_back_pressed() -> void:
	print("[Lobby] back to main_menu")
	ScNodeRouter.go_to_main_menu()


func _on_ready_toggled() -> void:
	_is_ready = not _is_ready
	if _is_ready:
		ready_btn.text = "取 消 准 备"
		ready_btn.add_theme_color_override("font_color", Color(0.498, 0.651, 0.498, 1))
		seat_ready_label.text = "●  已 就 绪"
		seat_ready_label.add_theme_color_override("font_color", Color(0.498, 0.651, 0.498, 1))
	else:
		ready_btn.text = "准 备 就 绪"
		ready_btn.remove_theme_color_override("font_color")
		seat_ready_label.text = "○  等 待 开 始"
		seat_ready_label.add_theme_color_override("font_color", Color(0.42, 0.41, 0.4, 1))
	_set_ai_all_ready()
	_check_all_ready()


func _set_ai_all_ready() -> void:
	for i in range(2, 5):
		var label = get_node_or_null(
			"Body/CenterColumn/CenterVBox/SeatsRow/Seat_0%d/Seat0%dInner/Seat0%dVBox/SeatReady" % [i, i, i]
		)
		if label:
			label.text = "●  已 就 绪"
			label.add_theme_color_override("font_color", Color(0.498, 0.651, 0.498, 1))


func _check_all_ready() -> void:
	if _is_ready:
		print("[Lobby] all ready → starting game")
		var timer := Timer.new()
		timer.wait_time = 1.5
		timer.one_shot = true
		timer.timeout.connect(_start_game)
		add_child(timer)
		timer.start()


func _start_game() -> void:
	print("[Lobby] transitioning to game...")
	ScNodeRouter.go_to_main_menu()
