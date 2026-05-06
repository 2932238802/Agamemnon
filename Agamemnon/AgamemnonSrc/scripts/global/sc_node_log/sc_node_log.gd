extends Node

var enabled: bool = true
var _path: String = ""


func _ready() -> void:
	if not enabled:
		return
	var d := Time.get_date_dict_from_system()
	_path = "user://Agamemnon_%02d_%02d_%02d.log" % [d.year - 2000, d.month, d.day]
	var file := FileAccess.open(_path, FileAccess.WRITE)
	if file:
		file.store_string("═══ Agamemnon LOG ═══ %s\n" % Time.get_datetime_string_from_system())
		file.close()
	_write("[Logger] started")


func info(msg: String) -> void:
	_write("[INFO]  " + msg)
	print(msg)


func warn(msg: String) -> void:
	_write("[WARN]  " + msg)
	push_warning(msg)


func error(msg: String) -> void:
	_write("[ERROR] " + msg)
	push_error(msg)


func _write(line: String) -> void:
	if not enabled:
		return
	var file := FileAccess.open(_path, FileAccess.READ_WRITE)
	if file:
		file.seek_end()
		file.store_line("%s  %s" % [Time.get_datetime_string_from_system(), line])
		file.close()
