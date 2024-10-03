extends Node3D

@export var frequency: float = 5.0
@export var length: float = 0.4
@export var shader_fade: ShaderMaterial
var lerp_time:float =0.0

func _process(delta: float) -> void:
	var _position = Vector3.ZERO
	lerp_time += delta
	_position.y = cos(lerp_time*frequency)*length*2
	position.y = _position.y
