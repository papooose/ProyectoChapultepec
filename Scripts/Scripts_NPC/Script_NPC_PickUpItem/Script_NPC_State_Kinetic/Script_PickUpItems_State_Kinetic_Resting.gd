extends state_Base
class_name state_kinetic_pickUpItem_Resting



@onready var kinetic_state_machine: Finte_state_machine = $".."
@onready var state_logic: NPC_PickUpItem_StateLogic = $"../.."

@onready var stress_meter: NPC_pickUpItem_StressMeter = $"../../NPC_pickUpItem_StressMeter"


func _enter_state()->void:
	state_logic.signal_item_poked.connect(kinetic_state_machine._change_state.bind(kinetic_state_machine.last_state))
	stress_meter.healing_timer.start()
	stress_meter.signal_stress_healed.connect(kinetic_state_machine._change_state.bind(kinetic_state_machine.last_state))

func _exit_state()->void:
	state_logic.signal_item_poked.disconnect(kinetic_state_machine._change_state.bind(kinetic_state_machine.last_state))
	stress_meter.healing_timer.stop()
	stress_meter.signal_stress_healed.disconnect(kinetic_state_machine._change_state.bind(kinetic_state_machine.last_state))
