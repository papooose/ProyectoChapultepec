extends state_Base
class_name state_player_paused

signal signal_pausedToIdle
signal signal_pausedToMoving

@onready var player_body: Mover_Player = $"../../Player_Body"
@onready var player_raycast: raycast_player = $"../../Player_Body/Head_Holder/Player_Camera/raycast_player"


func _enter_state()->void:
	player_raycast._disable_crosshair()
	player_body._disable_camera_mov()
	player_body._body_stop()
func _exit_state()->void:
	player_raycast._enable_crosshair()
	set_physics_process(false)










func paused_to_idle()->void:
	signal_pausedToIdle.emit()
func paused_to_moving()->void:
	signal_pausedToMoving.emit()
