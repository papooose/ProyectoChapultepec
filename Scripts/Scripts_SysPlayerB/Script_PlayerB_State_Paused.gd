extends state_Base
class_name state_playerB_paused

@onready var player_body: Mover_player_b = $"../../player_body"
@onready var player_input: input_player_b = $"../../input_player_b"
@onready var player_point: player_target = $"../../Player_Target"
@onready var player_camera: camera_player_b = $"../../player_body/Player_Head/Player_camera"




func _enter_state()->void:
	_pause_player()
func _exit_state()->void:
	_resume_player()

func _pause_player():
	player_body._disable_body_move()
	player_camera._disable_camera_rot()
	player_input._disable_input()
	player_point._disable_pointer()

func _resume_player():
	player_body._enable_body_move()
	player_camera._enable_camera_rot()
	player_input._enable_input()
	player_point._enable_pointer()
