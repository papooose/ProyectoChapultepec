extends  Node3D
class_name Manager_PlayerB

@export_group("Signal Emitters")
@export var pause_input: input_settings
@export var organ_wiring: Actor_SleepingBeast_Organ_Wiring

var dialogue_manager
@onready var FSM: Finte_state_machine = $Finte_state_machine

@export_group("States")
@onready var state_paused: state_playerB_paused = $Player_states/state_playerB_paused
@onready var state_idle: state_playerB_idle = $Player_states/state_playerB_idle

func _ready() -> void:
	_connect_signals()

func _connect_signals()->void:
	organ_wiring.signal_game_paused.connect(FSM._change_state.bind(state_paused))
	organ_wiring.signal_game_resumed.connect(FSM._change_state.bind(state_idle))

	organ_wiring.signal_asleep.connect(FSM._change_state.bind(state_paused))
	organ_wiring.signal_awake.connect(FSM._change_state.bind(state_idle))
