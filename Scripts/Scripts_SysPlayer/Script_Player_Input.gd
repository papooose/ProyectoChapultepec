extends Node
class_name input_player

signal signal_action_forward
signal signal_action_interact
signal signal_action_cameramove








func _move_forward():
	signal_action_forward.emit()
func _action_interact():
	signal_action_interact.emit()
func _move_camera():
	signal_action_cameramove.emit()

func _input(_event: InputEvent) -> void:
	if(Input.is_action_just_pressed("Action_Move_Forward")):
		_move_forward()
	if(Input.is_action_just_pressed("Action_Interact")):
		_action_interact()
