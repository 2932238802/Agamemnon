extends Node

const MAIN_MENU := "res://scenes/menu/main_menu.tscn"
const LOBBY := "res://scenes/menu/lobby.tscn"

func go_to_main_menu() -> void:
	_change_scene(MAIN_MENU);

func go_to_lobby() -> void:
	_change_scene(LOBBY)

func quit_game() -> void:
	print("[ScNodeRouter] quit")
	get_tree().quit()

func _change_scene(path : String) ->void:
	var err := get_tree().change_scene_to_file(path);
	if err != OK:
		push_error("[ScNodeRouter] failed to change scene");
