extends state_Base
class_name state_emotional_pickUpItem_Stressed



@onready var state_logic: NPC_PickUpItem_StateLogic = $"../.."

@onready var medical_state_machine: Finte_state_machine = $".."
@onready var stress_meter: NPC_pickUpItem_StressMeter = $"../../NPC_pickUpItem_StressMeter"

@export var collapsing_threshold: int 
@export var mildstressed_threshold: int

@onready var state_collapsing: state_emotional_pickUpItem_Collapsing = $"../state_emotional_pickUpItem_Collapsing"
@onready var state_stressed: state_emotional_pickUpItem_MildlyStressed = $"../state_emotional_pickUpItem_MildlyStressed"


func _enter_state()->void:
	state_logic.signal_item_poked.connect(_check_stress_)

func _exit_state()->void:
	state_logic.signal_item_poked.disconnect(_check_stress_)

func _check_stress_()->void:
	state_logic.pick_up_item._answer_question()
	if stress_meter.stress_level >= collapsing_threshold: medical_state_machine._change_state(state_collapsing)
	if stress_meter.stress_level <= mildstressed_threshold-1: medical_state_machine._change_state(state_stressed)
