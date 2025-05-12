extends state_Base
class_name state_playerB_moving

@onready var player_body: Mover_player_b = $"../../player_body"
@onready var player_input: input_player_b = $"../../input_player_b"
@onready var player_point: player_target = $"../../Player_Target"
@onready var sound_spawner: playerb_soundSpawner = $"../../playerb_Sound_spawner"
@onready var player_Target: player_target = $"../../Player_Target"

@onready var FSM: Finte_state_machine = $"../../Finte_state_machine"


@onready var state_idle: state_playerB_idle = $"../state_playerB_idle"




func _enter_state()->void:
	player_body._enable_body_move()
	_connect_signals()
func _exit_state()->void:
	sound_spawner._delete_bubble()
	_disconnect_signals()

func _connect_signals():
	player_input.signal_action_forward.connect(_move_player_to_point)
	player_input.signal_action_interact.connect(_stop_player)
	player_body.navigation_agent.navigation_finished.connect(_player_arrived_to_pos)
	
func _disconnect_signals():
	player_input.signal_action_forward.disconnect(_move_player_to_point)
	player_input.signal_action_interact.disconnect(_stop_player)
	player_body.navigation_agent.navigation_finished.disconnect(_player_arrived_to_pos)


func _move_player_to_point():
	player_body._move_to_mouse_position()
	player_point._spawn_arrow()
	sound_spawner._spawn_bubble()

func _stop_player():
	player_Target._spawn_interact()
	#player_body._stop_body()
	#player_point._transform_arrows()
	#FSM._change_state(state_idle)
	pass

func _player_arrived_to_pos():
	FSM._change_state(state_idle)
