extends Node
class_name Manager_player
#region External signals
@export_group("Signal Emitters")
var Dialogue_manager
@export var pasue_input: input_settings
var crosshair_manager
#endregion


@onready var FSM: Finte_state_machine = $Finte_state_machine


#region States
@export_group("States")
@onready var state_idle: state_player_idle = $Player_States/state_player_idle
@onready var state_moving: state_player_moving = $Player_States/state_player_moving
@onready var state_paused: state_player_paused = $Player_States/state_player_paused
@onready var state_talking: state_player_talking = $Player_States/state_player_talking
#endregion

func _ready() -> void:
	_connect_internal_signals()
	_connect_external_signals()


func _connect_external_signals()->void:
	pasue_input.signal_pause_game.connect(_pause_player)
	pasue_input.signal_resume_game.connect(_resume_player)


func _connect_internal_signals()->void:
	_idle_signals()
	_moving_signals()
	_pause_signals()
	_talking_signals()


func _pause_player():
	FSM._change_state(state_paused)

func _resume_player():
	if(FSM.last_state != state_talking):
		FSM._change_state(FSM.last_state)
	else:
		FSM._change_state(state_idle)

func _talk_player():
	FSM._change_state(state_talking)

#region StateSignals
func _idle_signals():
	state_idle.signal_idleToMoving.connect(FSM._change_state.bind(state_moving))
	state_idle.signal_idleToPause.connect(FSM._change_state.bind(state_paused))
	state_idle.signal_idleToTalking.connect(FSM._change_state.bind(state_talking))
func _moving_signals():
	state_moving.signal_movingToIdle.connect(FSM._change_state.bind(state_idle))
	state_moving.signal_movingToPause.connect(FSM._change_state.bind(state_paused))
	state_moving.signal_movingToTalking.connect(FSM._change_state.bind(state_talking))
func _pause_signals():
	state_paused.signal_pausedToIdle.connect(FSM._change_state.bind(state_idle))
	state_paused.signal_pausedToMoving.connect(FSM._change_state.bind(state_moving))
func _talking_signals():
	state_talking.signal_talkingToIdle.connect(FSM._change_state.bind(state_idle))
#endregion
