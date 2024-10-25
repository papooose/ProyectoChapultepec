extends Node3D
class_name player_arrowPointer

@export var frequency: float = 5.0
@export var length: float = 0.4
@export var floating_obj:Node3D
var lerp_time:float =0.0

func _process(delta: float) -> void:
	_arrow_life_span(delta)

func _arrow_life_span(delta:float)->void:
	var _position = Vector3.ZERO
	lerp_time += delta
	_position.y = cos(lerp_time*frequency)*length*2
	floating_obj.position.y = _position.y
