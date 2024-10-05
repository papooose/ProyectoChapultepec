extends  Node3D
class_name Manager_PlayerB

@export_group("Signal Emitters")
@export var pause_input: input_settings
var dialogue_manager
@onready var FSM: Finte_state_machine = $Finte_state_machine

@export_group("States")
@onready var state_paused: state_playerB_paused = $Player_states/state_playerB_paused
@onready var state_idle: state_playerB_idle = $Player_states/state_playerB_idle


func _ready() -> void:
	_connect_signals()

func _connect_signals()->void:
	pause_input.signal_pause_game.connect(FSM._change_state.bind(state_paused))
	pause_input.signal_resume_game.connect(FSM._change_state.bind(state_idle))
