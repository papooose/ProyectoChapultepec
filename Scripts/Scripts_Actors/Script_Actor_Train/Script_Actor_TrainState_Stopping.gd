extends state_Base
class_name state_train_stopping


@export var train_var: Actor_Train
@export var FSM: Finte_state_machine
@onready var state_stopped: state_train_stopped = $"../state_train_stopped"

func _ready() -> void:
	set_process(false)

func _enter_state()->void:
	set_process(true)
	train_var._deaccelerate()

func _exit_state()->void:
	set_process(false)

func _process(_delta: float) -> void:
	_check_speed()

func _check_speed()->void:
	if(train_var.speed <= 0): FSM._change_state(state_stopped)
