extends state_Base
class_name state_playerB_moving

@onready var player_body: Mover_player_b = $"../../player_body"
@onready var player_input: input_player_b = $"../../input_player_b"




func _enter_state()->void:
	player_body._enable_body_move()
	_connect_signals()
func _exit_state()->void:
	_disconnect_signals()

func _connect_signals():
	player_input.signal_action_forward.connect(player_body._get_mouse_position)
func _disconnect_signals():
	player_input.signal_action_forward.disconnect(player_body._get_mouse_position)
