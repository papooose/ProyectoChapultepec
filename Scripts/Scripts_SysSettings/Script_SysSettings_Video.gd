extends Node
class_name Settings_Video


func _ready() -> void:
	_default_setting()

func _default_setting()->void:
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
