extends state_Base
class_name state_SleepingBeast_Eye_Blinking

@onready var eye_animator: AnimatedTextureRect = $"../../../Eye_Container/Eye_Animator"
@onready var FSM: Finte_state_machine = $".."
@onready var state_awake: state_SleepingBeast_Eye_Awake = $"../state_SleepingBeast_Eye_Awake"
@onready var organ_eye_mouth: actor_Organ_Mouth = $"../actor_Organ_Eye_Mouth"





func _enter_state()->void:
	state_awake.awake_timer.paused = true
	organ_eye_mouth._play_sound(1)
	eye_animator.animation = "Anim_Eye_Blinking"
	await eye_animator.signal_animation_finished
	eye_animator.animation = "Anim_Eye_Opened"
	FSM._change_state(state_awake)
func _exit_state()->void:
	state_awake.awake_timer.paused = false
