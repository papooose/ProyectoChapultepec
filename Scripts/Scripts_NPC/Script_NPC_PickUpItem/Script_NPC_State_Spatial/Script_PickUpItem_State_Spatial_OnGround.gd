extends state_Base
class_name state_spatial_pickUpItem_OnGround

#The spatial states can only be changed from the outside
#Meaning that only if the object has been picked up by the player
#The objects spatial state is changed
#I want to include a falling state, but that will come later
@export var aura: Aura_Type_A
@onready var state_logic: NPC_PickUpItem_StateLogic =$"../.."
@onready var stress_meter: NPC_pickUpItem_StressMeter = $"../../NPC_pickUpItem_StressMeter"

@onready var spatial_state_machine: Finte_state_machine =$".."
@onready var state_held: state_spatial_pickUpItem_Held = $"../state_spatial_pickUpItem_Held"

@onready var EMS: Finte_state_machine = $"../../Emotional_state_machine"
@onready var KSM: Finte_state_machine = $"../../Kinetic_state_machine"

@onready var state_dead: state_emotional_pickUpItem_Dead = $"../../Emotional_state_machine/state_emotional_pickUpItem_Dead"
@onready var state_distressed: state_kinetic_pickUpItem_Distressed = $"../../Kinetic_state_machine/state_kinetic_pickUpItem_Distressed"

#On Ground means it can have, every state

#probably can be poked on ground, 

func _enter_state()->void:
	_connect_signals()
	if spatial_state_machine.last_state == state_held: state_logic.pick_up_item._dropped_down()


func _exit_state()->void:
	_disconnect_signals()

func _connect_signals()->void:
	state_logic.signal_item_pickedUp.connect(spatial_state_machine._change_state.bind(state_held))
	state_logic.signal_item_poked.connect(stress_meter.increase_stress)
	if aura !=null: aura.signal_kill.connect(_instakill)
	
	

func _disconnect_signals()->void: 
	state_logic.signal_item_pickedUp.disconnect(spatial_state_machine._change_state.bind(state_held))
	state_logic.signal_item_poked.disconnect(stress_meter.increase_stress)
	if aura !=null: aura.signal_kill.disconnect(_instakill)



func _instakill()->void:
	print("insta killed")
	stress_meter._instakill()
	EMS._change_state(state_dead)
	KSM._change_state(state_distressed)
