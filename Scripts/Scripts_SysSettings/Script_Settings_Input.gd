extends Node
class_name input_settings

signal signal_pause_game
signal signal_resume_game

var game_paused: bool = false
@export var pause_UI: CanvasLayer


func _ready() -> void:
	_resume_game()



func _disable_input()->void:
	set_process_input(false)
func _enable_inpunt()->void:
	set_process_input(true)


func _pause_game():
	game_paused = true
	signal_pause_game.emit()
	pause_UI.visible = true
func _resume_game():
	game_paused = false
	signal_resume_game.emit()
	pause_UI.visible = false


func _handle_input():
	print("gamePaused")
	if(game_paused):
		_resume_game()
	else:
		_pause_game()
		

func _input(_event: InputEvent) -> void:
	if(Input.is_action_just_pressed("Action_Pause")):
		_handle_input()
