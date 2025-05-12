extends Node
class_name Finte_state_machine

signal signal_state_changed
@export var current_state: state_Base

var last_state: state_Base
var first_state: bool

func _ready()->void:
	first_state = true
	_change_state(current_state)
	first_state = false


func _change_state(new_state: state_Base)->void:
	#print("Changing to: " + String(new_state.name))
	last_state = current_state
	if last_state is state_Base:
		if(!first_state):
			last_state._exit_state()
	new_state._enter_state()
	current_state = new_state
	signal_state_changed.emit()
