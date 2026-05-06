extends Node

func show_info(title: String, message: String) -> void:
	var d := _make_dialog(title, message)
	d.ok_button_text = "确 定"
	d.confirmed.connect(d.queue_free)
	_add(d)
	d.popup_centered()


func show_confirm(title: String, message: String, on_ok: Callable, on_cancel: Callable = func(): pass) -> void:
	var d := _make_dialog(title, message)
	d.ok_button_text = "确 认"
	d.cancel_button_text = "取 消"
	d.confirmed.connect(on_ok)
	d.confirmed.connect(d.queue_free)
	d.canceled.connect(on_cancel)
	d.canceled.connect(d.queue_free)
	_add(d)
	d.popup_centered()


func _make_dialog(title: String, message: String) -> ConfirmationDialog:
	var d := ConfirmationDialog.new()
	d.title = title
	d.dialog_text = message
	d.min_size = Vector2(42, 18) * 10
	d.theme = _theme()
	return d


func _theme() -> Theme:
	var t := Theme.new()
	var p := StyleBoxFlat.new()
	p.bg_color = Color(0.15, 0.15, 0.19, 1)
	p.border_width_left = 1; p.border_width_right = 1
	p.border_width_top = 1; p.border_width_bottom = 1
	p.border_color = Color(0.788, 0.663, 0.38, 0.3)
	p.set_corner_radius_all(4)
	p.content_margin_left = 24; p.content_margin_right = 24
	p.content_margin_top = 20; p.content_margin_bottom = 20
	t.set_stylebox("panel", "ConfirmationDialog", p)
	var tb := StyleBoxFlat.new()
	tb.bg_color = Color(0.12, 0.12, 0.16, 1)
	t.set_stylebox("titlebar", "ConfirmationDialog", tb)
	t.set_color("title_color", "ConfirmationDialog", Color(0.91, 0.9, 0.88, 1))
	t.set_font_size("title_font_size", "ConfirmationDialog", 16)
	t.set_color("font_color", "ConfirmationDialog", Color(0.659, 0.651, 0.631, 1))
	t.set_font_size("font_size", "ConfirmationDialog", 14)
	return t


func _add(d: ConfirmationDialog) -> void:
	Engine.get_main_loop().root.add_child(d)
