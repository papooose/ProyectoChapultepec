extends state_Base
class_name state_SleepingBeast_Heart_Ill

signal signal_heart_Ill
#still recovers health while sleeping but at a lower rate


@export_group("State Variables")
@export var max_healt_threshold:int = 99
@export var min_healt_threshold:int =30

@export_group("Animation logic")
@export var eye_animator: AnimatedTextureRect #changes the animaton depending on healt
@export var health_state_anim: SpriteFrames
@export_group("State logic")
@export var FSM: Finte_state_machine

@onready var state_healthy: state_SleepingBeast_Heart_Healthy = $"../state_SleepingBeast_Heart_Healthy"
@onready var state_deathsDoor: state_SleepingBeast_Heart_DeathsDoor = $"../state_SleepingBeast_Heart_DeathsDoor"

@export_group("Organs")
@onready var organ_wiring: Actor_SleepingBeast_Organ_Wiring = $"../../Actor_SleepingBeast_Organ_Wiring"
@onready var organ_skin: Actor_SleepingBeast_Organ_Skin = $"../../Actor_SleepingBeast_Organ_Skin"
@onready var organ_mouth: actor_Organ_Mouth = $"../actor_Organ_MouthHeart"
@onready var organ_tiroides: Actor_SleepingBeast_Organ_Tiroides = $"../../Actor_SleepingBeast_Organ_Tiroides"



func _enter_state()->void:
	signal_heart_Ill.emit()
	organ_mouth._fade_in_sound(1)
	organ_tiroides._change_res(1)
	organ_tiroides.health_condition = 1
	Singleton_Organ_Beast.signal_heart_health_changed.connect(_chekc_health)
	organ_wiring._reset_disconnection_freq(4)
	organ_skin._set_skin_condition(0.2)
	#change_material

func _exit_state()->void:
	Singleton_Organ_Beast.signal_heart_health_changed.disconnect(_chekc_health)


func _chekc_health()->void:
	if Singleton_Organ_Beast.current_health > max_healt_threshold: FSM._change_state(state_healthy)
	if Singleton_Organ_Beast.current_health < min_healt_threshold: FSM._change_state(state_deathsDoor)
