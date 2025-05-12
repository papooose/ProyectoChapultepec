extends state_Base
class_name state_emotional_pickUpItem_relaxed

@onready var state_logic: NPC_PickUpItem_StateLogic = $"../.."

@onready var medical_state_machine: Finte_state_machine = $".."
@onready var stress_meter: NPC_pickUpItem_StressMeter = $"../../NPC_pickUpItem_StressMeter"
@onready var mesh_skin: NPC_MeshSkin = $"../../NPC_MeshSkin"

@export var mildlystressed_threshold: int 
@onready var state_Mildystressed: state_emotional_pickUpItem_MildlyStressed = $"../state_emotional_pickUpItem_MildlyStressed"


func _enter_state()->void:
	if medical_state_machine != state_emotional_pickUpItem_Dead:
		mesh_skin._switch_mesh(0)
	state_logic.signal_item_poked.connect(_check_stress_)

func _exit_state()->void:
	state_logic.signal_item_poked.disconnect(_check_stress_)



func _check_stress_():
	state_logic.pick_up_item._answer_question()
	if stress_meter.stress_level >= mildlystressed_threshold: 
		medical_state_machine._change_state(state_Mildystressed)
