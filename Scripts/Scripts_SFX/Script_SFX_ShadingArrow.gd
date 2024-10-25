extends Node3D
class_name sfx_shadingArrow
@onready var prop_arrow: player_arrowPointer = $"3dModel_Props_Arrow_1"
@onready var animation_player: AnimationPlayer = $"3dModel_Props_Arrow_1/AnimationPlayer"
@onready var nope_sign: sfx_NopeSign = $"3dModel_Props_NopeSign"

var timer: float =0.0
var timer_limit: float = 1.0


func _ready() -> void:
	_destory_arrow()
func _destory_arrow()->void:
	animation_player.play("Arrow_FadeOut")
	await animation_player.animation_finished
	queue_free()

func _transform_arrow()->void:
	animation_player.stop()
	nope_sign._play_animaion_and_destory()
	prop_arrow.visible = false
	nope_sign.visible = true
	await nope_sign.animation_player.animation_finished
	queue_free()
