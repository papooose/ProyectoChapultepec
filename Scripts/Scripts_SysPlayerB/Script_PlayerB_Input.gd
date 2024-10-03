extends Node
class_name input_player_b


signal signal_action_forward
signal signal_action_interact
signal signal_action_cameramove

@onready var player_camera: camera_player_b = $"../player_body/Player_Head/Player_camera"



func _move_forward():
	signal_action_forward.emit()
func _action_interact():
	signal_action_interact.emit()
func _move_camera():
	signal_action_cameramove.emit()

func _input(event: InputEvent) -> void:
	if(Input.is_action_just_pressed("Action_Move_Forward")):
		_move_forward()
	if(Input.is_action_just_pressed("Action_Interact")):
		_action_interact()
	player_camera._handle_camera_input(event)
