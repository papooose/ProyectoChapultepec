extends state_Base
class_name state_emotional_pickUpItem_Collapsing

#after reaching this state the item gets Distressed, and cant relaxed anymore



@onready var medical_state_machine: Finte_state_machine = $".."
@onready var kinetic_state_machine: Finte_state_machine = $"../../Kinetic_state_machine"

@onready var stress_meter: NPC_pickUpItem_StressMeter = $"../../NPC_pickUpItem_StressMeter"
@export var aboutToDie_threshold: int 

@onready var state_abouTtoDie: state_emotional_pickUpItem_AboutToDie = $"../state_emotional_pickUpItem_AboutToDie"
@onready var state_distressed: state_kinetic_pickUpItem_Distressed = $"../../Kinetic_state_machine/state_kinetic_pickUpItem_Distressed"
@onready var state_logic: NPC_PickUpItem_StateLogic = $"../.."


@export var blood_fountain: SFX_bloodfountain 



func _enter_state()->void:
	state_logic.signal_item_poked.connect(_check_stress_)
	kinetic_state_machine._change_state(state_distressed)
	blood_fountain._set_bleeding_timer() #This makes the object bleed

func _exit_state()->void:
	state_logic.signal_item_poked.disconnect(_check_stress_)


func _check_stress_()->void:
	state_logic.pick_up_item._answer_question()
	if stress_meter.stress_level >= aboutToDie_threshold: 
		medical_state_machine._change_state(state_abouTtoDie)
