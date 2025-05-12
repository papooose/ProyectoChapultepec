extends state_Base
class_name state_SleepingBeast_Eye_Sleeping

@onready var eye_animator: AnimatedTextureRect = $"../../../Eye_Container/Eye_Animator"
@onready var FSM: Finte_state_machine = $".."
@onready var state_awake: state_SleepingBeast_Eye_Awake = $"../state_SleepingBeast_Eye_Awake"

#region Organs
@onready var organ_wiring: Actor_SleepingBeast_Organ_Wiring = $"../../Actor_SleepingBeast_Organ_Wiring"
@onready var organ_eyemouth: actor_Organ_Mouth = $"../actor_Organ_Eye_Mouth"
#endregions



var nap_timer:Timer
var nap_time_duration:float

func _ready() -> void:
	_set_timer_up()

func _enter_state()->void:
	organ_eyemouth._play_sound(0)
	await eye_animator.signal_animation_finished
	eye_animator.animation = "Anim_Eye_Closed"
	_reset_timer()
	organ_wiring._system_asleep()

func _exit_state()->void:
	pass

func _set_timer_up()->void:
	if nap_timer == null: 
		nap_timer = Timer.new()
		add_child(nap_timer)
	if nap_timer !=null:
		nap_timer.timeout.connect(FSM._change_state.bind(state_awake))
		nap_timer.autostart = true
		nap_timer.one_shot = true

func _reset_timer()->void:
	_randomize_awake_time()
	nap_timer.wait_time = nap_time_duration
	nap_timer.start()

func _randomize_awake_time()->void:
	nap_time_duration = randf_range(10.0,15.0)
