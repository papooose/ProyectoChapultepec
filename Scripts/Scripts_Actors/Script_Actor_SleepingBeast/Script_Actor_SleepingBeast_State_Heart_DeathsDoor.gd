extends state_Base
class_name state_SleepingBeast_Heart_DeathsDoor

signal  signal_heart_DeathsDoor
#keeps loosing health 

@export_group("State Variables")
@export var max_healt_threshold:int = 29
@export var min_healt_threshold:int = 1

@export_group("Animation logic")
@export var eye_animator: AnimatedTextureRect #changes the animaton depending on healt
@export var health_state_anim: SpriteFrames
@export_group("State logic")
@export var FSM: Finte_state_machine
@onready var state_ill: state_SleepingBeast_Heart_Ill = $"../state_SleepingBeast_Heart_Ill"
@export_group("Organs")
@onready var organ_wiring: Actor_SleepingBeast_Organ_Wiring = $"../../Actor_SleepingBeast_Organ_Wiring"
@onready var organ_skin: Actor_SleepingBeast_Organ_Skin = $"../../Actor_SleepingBeast_Organ_Skin"
@onready var organ_mouth: actor_Organ_Mouth = $"../actor_Organ_MouthHeart"
@onready var organ_tiroides: Actor_SleepingBeast_Organ_Tiroides = $"../../Actor_SleepingBeast_Organ_Tiroides"




func _enter_state()->void:
	signal_heart_DeathsDoor.emit()
	organ_mouth._fade_in_sound(2)
	organ_tiroides._change_res(2)
	organ_tiroides.health_condition = 2
	Singleton_Organ_Beast.signal_heart_health_changed.connect(_chekc_health)
	organ_wiring._reset_disconnection_freq(10)
	organ_skin._set_skin_condition(3)
	#change_ anim
	#change_material

func _exit_state()->void:
	Singleton_Organ_Beast.signal_heart_health_changed.disconnect(_chekc_health)




func _chekc_health()->void:
	if Singleton_Organ_Beast.current_health >= max_healt_threshold: FSM._change_state(state_ill)
	if Singleton_Organ_Beast.current_health <= min_healt_threshold: print("Dead")
