extends state_Base
class_name state_playerB_idle

#@onready var fsm: Finte_state_machine = $"../../Finte_state_machine"
@export var fsm: Finte_state_machine
#@onready var player_input: input_player_b = $"../../input_player_b"
@export var player_input: input_player_b

@export var state_moving: state_playerB_moving
#@onready var state_moving: state_playerB_moving = $"../state_playerB_moving"

@export var player_body: Mover_player_b
#@onready var player_body: Mover_player_b = $"../../player_body"



func _enter_state()->void:
	_connect_signals()
	player_body._disable_body_move()
	
func _exit_state()->void:
	_disconnect_signals()

func _connect_signals():
	player_input.signal_action_forward.connect(fsm._change_state.bind(state_moving))
func _disconnect_signals():
	player_input.signal_action_forward.disconnect(fsm._change_state.bind(state_moving))
