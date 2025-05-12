extends state_Base
class_name state_SleepingBeast_Eye_Awake

@warning_ignore("unused_signal")
signal signal_monster_woke_up
@warning_ignore("unused_signal")
signal signal_monster_went_to_sleep

@export var eye_animator: AnimatedTextureRect
@onready var state_sleeping: state_SleepingBeast_Eye_Sleeping = $"../state_SleepingBeast_Eye_Sleeping"

@onready var state_blinking: state_SleepingBeast_Eye_Blinking = $"../state_SleepingBeast_Eye_Blinking"
@onready var FSM: Finte_state_machine = $".."

@export_group("Awake Time")
var awake_timer:Timer
@export_range(20.0,60.0)var min_awake_time_duration:float
@export_range(20.0,120.0)var max_awake_time_duration:float
var awake_time_duration:float

@export_group("Blink Time")
@export_range(5.0,15.0)var min_blink_time_duration:float
@export_range(15.0,30.0)var max_blink_time_duration:float

@export_group("Organs")
@onready var organ_wiring: Actor_SleepingBeast_Organ_Wiring = $"../../Actor_SleepingBeast_Organ_Wiring"
@onready var organ_eyemouth: actor_Organ_Mouth = $"../actor_Organ_Eye_Mouth"

var blink_timer:Timer
var blink_time_duration:float

func _ready() -> void:
	_set_timer_up()
	_set_blink_timer()
	await eye_animator.signal_animation_finished

func _enter_state()->void:
	if FSM.last_state != state_blinking:
		eye_animator.animation = "Anim_Eye_Opening"
		organ_eyemouth._play_sound(0)
		await eye_animator.signal_animation_finished
		eye_animator.animation = "Anim_Eye_Opened"
		_reset_timer()
	else: 	
		organ_eyemouth._play_sound(0)
	organ_wiring._syste_awake()

func _exit_state()->void:
	eye_animator.animation = "Anim_Eye_Closing"
	blink_timer.stop()


func _set_timer_up()->void:
	if awake_timer == null: 
		awake_timer = Timer.new()
		add_child(awake_timer)
	if awake_timer !=null:
		awake_timer.timeout.connect(FSM._change_state.bind(state_sleeping))
		awake_timer.autostart = true
		awake_timer.one_shot = true

func _set_blink_timer()->void:
	if blink_timer == null:
		blink_timer = Timer.new()
		add_child(blink_timer)
	if blink_timer!=null:
		blink_timer.timeout.connect(_blink)

func _blink()->void:
	FSM._change_state(state_blinking)

func _reset_timer()->void:
	_randomize_awake_time()
	await eye_animator.signal_animation_finished
	awake_timer.wait_time = awake_time_duration
	blink_timer.wait_time = blink_time_duration+1
	awake_timer.start()
	blink_timer.start()
	

func _randomize_awake_time()->void:
	awake_time_duration = randf_range(min_awake_time_duration,max_awake_time_duration)
	blink_time_duration = randf_range(min_blink_time_duration,max_blink_time_duration)
