extends state_Base
class_name state_emotional_pickUpItem_AboutToDie


@onready var medical_state_machine: Finte_state_machine = $".."
@onready var stress_meter: NPC_pickUpItem_StressMeter = $"../../NPC_pickUpItem_StressMeter"

@export var dead_threshold: int 

@onready var state_logic: NPC_PickUpItem_StateLogic = $"../.."
@onready var state_dead: state_emotional_pickUpItem_Dead = $"../state_emotional_pickUpItem_Dead"


func _enter_state()->void:
	state_logic.signal_item_poked.connect(_check_stress_)

func _exit_state()->void:
	state_logic.signal_item_poked.disconnect(_check_stress_)


func _check_stress_()->void:
	if stress_meter.stress_level >= dead_threshold: 
		medical_state_machine._change_state(state_dead)
	else: state_logic.pick_up_item._answer_question()
