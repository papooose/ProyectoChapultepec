extends state_Base
class_name state_player_paused

signal signal_pausedToIdle
signal signal_pausedToMoving

@onready var player_body: Mover_Player = $"../../Player_Body"

func _enter_state()->void:
	pass
func _exit_state()->void:
	pass

func paused_to_idle()->void:
	signal_pausedToIdle.emit()
func paused_to_moving()->void:
	signal_pausedToMoving.emit()
