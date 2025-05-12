extends Node
class_name Actor_SleepingBeast_Organ_Skin


@export var skin_material: ShaderMaterial
var distortion:float


func _process(_delta: float) -> void:
	skin_material.set_shader_parameter("distortionVertex",distortion)


func _set_skin_condition(skin_state:float)->void:
	var tween = create_tween()
	tween.tween_property(self,"distortion",skin_state,2)
	tween.is_queued_for_deletion()
