extends state_Base
class_name state_kinetic_pickUpItem_Anodyne

@onready var stress_meter: NPC_pickUpItem_StressMeter = $"../../NPC_pickUpItem_StressMeter"
@onready var state_logic: NPC_PickUpItem_StateLogic = $"../.."


@onready var kinetic_state_machine: Finte_state_machine = $".."
@onready var emotional_state_machine: Finte_state_machine = $"../../Emotional_state_machine"
@onready var state_resting: state_kinetic_pickUpItem_Resting = $"../state_kinetic_pickUpItem_Resting"

@export var distressed_states: Array=[state_emotional_pickUpItem_Collapsing,state_emotional_pickUpItem_AboutToDie]
#If its collapsing or about to die it wont start waiting the undistubred time to start healing
var undisturbed_timer: Timer

func _ready() -> void:
	_set_unisturbed_timer()

func _enter_state()->void:
	state_logic.signal_item_poked.connect(undisturbed_timer.start)
	undisturbed_timer.start()

func _exit_state()->void:
	state_logic.signal_item_poked.disconnect(undisturbed_timer.start)
	undisturbed_timer.stop()

func _check_stress_levels()->void:
	if !emotional_state_machine.current_state in  distressed_states:
		if stress_meter.stress_level <=0: return
		else: kinetic_state_machine._change_state(state_resting)
	if emotional_state_machine.current_state in  distressed_states: print("i cant heal")


func _set_unisturbed_timer()->void:
	undisturbed_timer = Timer.new()
	add_child(undisturbed_timer)
	undisturbed_timer.wait_time = 5.0
	undisturbed_timer.one_shot = true
	undisturbed_timer.timeout.connect(_check_stress_levels)
