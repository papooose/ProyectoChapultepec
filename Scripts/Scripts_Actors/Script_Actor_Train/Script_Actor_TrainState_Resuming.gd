extends state_Base
class_name state_train_resuming


@export var train_var: Actor_Train
@export var FSM: Finte_state_machine
@onready var organ_mouth: actor_organ_3DMouth = $"../../actor_organ_3DMouth"

func _enter_state()->void:
	organ_mouth._fade_in_sound(2)
	train_var._accelerate()
	train_var.life_timer.start()
	await train_var.life_timer.timeout
	train_var._fade_out()

func _exit_state()->void:
	pass
