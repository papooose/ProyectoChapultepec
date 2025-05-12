extends state_Base
class_name state_train_initialized


@export var train_var: Actor_Train
@export var FSM: Finte_state_machine

@onready var state_stopping: state_train_stopping = $"../state_train_stopping"
@export var organ_mouth: actor_organ_3DMouth

func _enter_state()->void:
	organ_mouth._fade_in_sound(0)
	set_physics_process(true)
	train_var._accelerate()
	_connect_signals()

func _exit_state()->void:
	set_physics_process(false)
	_disconnect_signals()


func _connect_signals()->void:
	train_var.life_timer.timeout.connect(train_var._fade_out)
	
func _disconnect_signals()->void:
	train_var.life_timer.timeout.disconnect(train_var._fade_out)


func _physics_process(_delta: float) -> void:
	if(train_var.stop_bool): _check_life_span()

func _check_life_span()->void:
	if(train_var.life_timer.time_left <= train_var.life_span/2):
		train_var.life_timer.stop()
		FSM._change_state(state_stopping)
