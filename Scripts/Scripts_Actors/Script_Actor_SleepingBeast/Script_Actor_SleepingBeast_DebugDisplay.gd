extends Control
class_name Actor_SleepingBeast_DebugDisplay
@onready var FSM_heart: Finte_state_machine = $"../SleepingMonster_Heart_state_machine"
@onready var FSM_eye: Finte_state_machine = $"../SleepingMonster_Eye_state_machine"
@onready var organ_wiring: Actor_SleepingBeast_Organ_Wiring = $"../Actor_SleepingBeast_Organ_Wiring"



@onready var eye_label: Label = $VBoxContainer/Eye_Label
@onready var heart_label: Label = $VBoxContainer/Heart_Label
@onready var health_label: Label = $VBoxContainer/Health_Label
@onready var time_passed: Label = $VBoxContainer/Time_passed
@onready var dying_clock: Actor_organ_DyingClock = $"../Actor_organ_DyingClock"
@onready var plants_lost: Label = $VBoxContainer/Plants_Lost
@onready var awake_label: Label = $VBoxContainer/Awake_Label
@onready var state_eye_awake: state_SleepingBeast_Eye_Awake = $"../SleepingMonster_Eye_state_machine/state_SleepingBeast_Eye_Awake"
@onready var disconnection_label: Label = $VBoxContainer/Disconnection_Label
@onready var connection_label: Label = $VBoxContainer/Connection_Label



func _ready() -> void:
	FSM_eye.signal_state_changed.connect(_set_eye_dd)
	FSM_heart.signal_state_changed.connect(_set_heart_dd)
	Singleton_Organ_Beast.signal_heart_health_changed.connect(_set_health)
		
	_set_eye_dd()
	_set_heart_dd()
	_set_health()
	

func _process(_delta: float) -> void:
	time_passed.text = "Time till life loss: "+ str(dying_clock.dying_clock.time_left)
	_set_timers()


func _set_eye_dd()->void:
	eye_label.text = "Eye_state: " + str(FSM_eye.current_state)
func _set_heart_dd()->void:
	heart_label.text = "Heart_state: " + str(FSM_heart.current_state)
func _set_health()->void:
	health_label.text = "Current_health: " + str(Singleton_Organ_Beast.current_health)
	plants_lost.text = "Plants_Lost: " + str(Singleton_Organ_Beast.plants_lost)
func _set_timers()->void:
	awake_label.text = "Time till nap: " +str(state_eye_awake.awake_timer.time_left)
	disconnection_label.text = "Time till disconnection: " +str(organ_wiring.disconnection_timer.time_left)
	connection_label.text = "Time till connection: " +str(organ_wiring.connection_timer.time_left)
	
