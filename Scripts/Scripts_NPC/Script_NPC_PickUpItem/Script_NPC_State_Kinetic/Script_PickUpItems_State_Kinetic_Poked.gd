extends state_Base
class_name state_kinetic_pickUpItem_Poked


@export var pick_uo_item: NPC_PickUpItem_Base
@onready var kinetic_state_machine: Finte_state_machine = $".."
@onready var state_anodyne: state_kinetic_pickUpItem_Anodyne = $"../state_kinetic_pickUpItem_Anodyne"
@onready var state_distressed: state_kinetic_pickUpItem_Distressed = $"../state_kinetic_pickUpItem_Distressed"


@onready var stress_meter: NPC_pickUpItem_StressMeter = $"../../NPC_pickUpItem_StressMeter"
@onready var emotional_state_machine: Finte_state_machine = $"../../Emotional_state_machine"
@export var distress_emotional_states: Array=[]

#este estado solo puede ser accedido por otros,
#pues solo otros pueden escuchar la señal del state logic

func _enter_state()->void:
	_poked_logic()
	_check_stress_levels()


func _exit_state()->void:
	pass


func _check_stress_levels()->void:
	if emotional_state_machine.current_state in distress_emotional_states:
		kinetic_state_machine._change_state(state_distressed)
	else: 
		kinetic_state_machine._change_state(state_anodyne) 
		print("going anodyne")


func _poked_logic()->void:
	pick_uo_item._asked_question_logic()
	stress_meter.stress_level +=1
