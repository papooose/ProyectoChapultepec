extends state_Base
class_name state_player_talking

signal signal_talkingToIdle

@onready var player_body: Mover_Player = $"../../Player_Body"

func _enter_state()->void:
	pass
func _exit_state()->void:
	pass

func _talking_to_idle()->void:
	signal_talkingToIdle.emit()
