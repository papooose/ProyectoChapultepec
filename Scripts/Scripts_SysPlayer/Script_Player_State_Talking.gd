extends state_Base
class_name state_player_talking

signal signal_talkingToIdle

@onready var player_body: Mover_Player = $"../../Player_Body"
@onready var player_raycast: raycast_player = $"../../Player_Body/Head_Holder/Player_Camera/raycast_player"

func _enter_state()->void:
	player_raycast._disable_crosshair()
func _exit_state()->void:
	player_raycast._enable_crosshair()
	pass

func _talking_to_idle()->void:
	signal_talkingToIdle.emit()
