extends state_Base
class_name state_playerB_moving

@onready var player_body: Mover_player_b = $"../../player_body"
@onready var player_input: input_player_b = $"../../input_player_b"
@onready var player_pointer: player_target = $"../../Player_Target"




func _enter_state()->void:
	player_body._enable_body_move()
	_connect_signals()
func _exit_state()->void:
	_disconnect_signals()

func _connect_signals():
	player_input.signal_action_forward.connect(_move_player_to_point)
	player_body.navigation_agent.navigation_finished.connect(_player_arrived_to_pos)
	
func _disconnect_signals():
	player_input.signal_action_forward.disconnect(_move_player_to_point)
	player_body.navigation_agent.navigation_finished.disconnect(_player_arrived_to_pos)


func _move_player_to_point():
	player_body._get_mouse_position()
	player_pointer._spawn_arrow()


func _player_arrived_to_pos():
	pass
	#player_pointer._hide_arrow()
