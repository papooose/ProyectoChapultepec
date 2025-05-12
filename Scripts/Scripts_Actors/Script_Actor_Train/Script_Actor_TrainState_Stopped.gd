extends state_Base
class_name state_train_stopped


@export var train_var: Actor_Train
@export var FSM: Finte_state_machine
@onready var state_resuming: state_train_resuming = $"../state_train_resuming"
@onready var aura: Aura_Type_A = $"../../Aura_Type_A"
@onready var organ_mouth: actor_organ_3DMouth = $"../../actor_organ_3DMouth"


func _enter_state()->void:
	aura.kill_aura = false
	organ_mouth._fade_in_sound(1)
	await get_tree().create_timer(train_var.stop_time).timeout
	FSM._change_state(state_resuming)

func _exit_state()->void:
	aura.kill_aura =true
