extends state_Base
class_name state_spatial_pickUpItem_Held

#The spatial states can only be changed from the outside
#Meaning that only if the object has been picked up by the player
#The objects spatial state is changed
#I want to include a falling state, but that will come later

@onready var state_logic: NPC_PickUpItem_StateLogic = $"../.."
@onready var state_on_ground: state_spatial_pickUpItem_OnGround = $"../state_spatial_pickUpItem_OnGround"

@onready var spatial_state_machine: Finte_state_machine = $".."


@onready var kinetic_state_machine: Finte_state_machine = $"../../Kinetic_state_machine"
@onready var emotional_state_machine: Finte_state_machine = $"../../Emotional_state_machine"

@onready var state_distressed: state_kinetic_pickUpItem_Distressed = $"../../Kinetic_state_machine/state_kinetic_pickUpItem_Distressed"
@onready var state_resting: state_kinetic_pickUpItem_Resting = $"../../Kinetic_state_machine/state_kinetic_pickUpItem_Resting"
@onready var state_anodyne: state_kinetic_pickUpItem_Anodyne = $"../../Kinetic_state_machine/state_kinetic_pickUpItem_Anodyne"
@onready var state_dead: state_emotional_pickUpItem_Dead = $"../../Emotional_state_machine/state_emotional_pickUpItem_Dead"



func _enter_state()->void:
	_connect_signals()
	_check_kinetic_state()
	state_logic.pick_up_item._picked_up_logic()


func _exit_state()->void:
	state_logic.pick_up_item._dropped_down_logic()
	_drop_down()
	_disconnect_signals()


#if its not working, its because other thing has this signal conected to it, check the other, State_Spatial Script
func _connect_signals()->void:
	set_process(true)
	state_logic.signal_item_droppedDown.connect(spatial_state_machine._change_state.bind(state_on_ground))

func _disconnect_signals()->void:
	set_process(false)
	state_logic.signal_item_droppedDown.disconnect(spatial_state_machine._change_state.bind(state_on_ground))



#region State Management 
func _check_kinetic_state()->void:
	if kinetic_state_machine.current_state != state_distressed:
		kinetic_state_machine._change_state(state_resting)

func _drop_down()->void:
	if kinetic_state_machine.current_state != state_distressed:
		kinetic_state_machine._change_state(state_anodyne)

	if emotional_state_machine.current_state is state_emotional_pickUpItem_AboutToDie:
		emotional_state_machine._change_state(state_dead)
#endregion
