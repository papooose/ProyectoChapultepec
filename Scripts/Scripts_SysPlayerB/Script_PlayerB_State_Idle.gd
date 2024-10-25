extends state_Base
class_name state_playerB_idle


@export var fsm: Finte_state_machine
@export var player_input: input_player_b

@export var state_moving: state_playerB_moving
@export var player_Target: player_target


func _enter_state()->void:
	_connect_signals()

	
func _exit_state()->void:
	_disconnect_signals()


func _connect_signals():
	player_input.signal_action_forward.connect(fsm._change_state.bind(state_moving))
	player_input.signal_action_interact.connect(_interact_sign)
func _disconnect_signals():
	player_input.signal_action_forward.disconnect(fsm._change_state.bind(state_moving))
	player_input.signal_action_interact.disconnect(_interact_sign)


func _interact_sign():
	player_Target._spawn_interact()
