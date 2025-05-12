extends Node3D
class_name NPC_stateDisplay
@onready var state_label: Label = $SubViewport/Label_state_display
@export var FSM: Finte_state_machine

func _ready() -> void:
	if FSM != null: 
		_connect_signals()
		_set_label_text()
	else: push_warning("Conect the FSM!")

func _connect_signals()->void:
	FSM.signal_state_changed.connect(_set_label_text)
	
func _set_label_text()->void:
	state_label.text = FSM.current_state.name
