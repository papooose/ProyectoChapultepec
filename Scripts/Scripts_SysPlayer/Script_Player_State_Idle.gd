extends state_Base
class_name state_player_idle

signal signal_idleToTalking
signal signal_idleToMoving
signal signal_idleToPause


@export var player_input: input_player




func _enter_state()->void:
	_connect_signals()
func _exit_state()->void:
	_disconnect_signals()

func _connect_signals()->void:
	player_input.signal_action_forward.connect(_idle_to_moving)
func _disconnect_signals()->void:
	player_input.signal_action_forward.disconnect(_idle_to_moving)




func _idle_to_moving()->void:
	signal_idleToMoving.emit()
func _idle_to_pause()->void:
	signal_idleToPause.emit()
func _idle_to_talking()->void:
	signal_idleToTalking.emit()
