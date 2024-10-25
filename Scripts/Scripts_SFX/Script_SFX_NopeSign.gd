extends Node3D
class_name sfx_NopeSign

@onready var animation_player: AnimationPlayer = $AnimationPlayer




func _play_animaion_and_destory():
	animation_player.play("Nope_Fade_Out")
	await animation_player.animation_finished
	queue_free()
