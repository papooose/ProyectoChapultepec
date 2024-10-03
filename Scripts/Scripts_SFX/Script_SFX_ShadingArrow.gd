extends Node3D
class_name sfx_shadingArrow

var timer: float =0.0
var timer_limit: float = 1.0

func _destory_arrow():
	queue_free()

func _process(delta: float) -> void:
	timer += delta
	if(timer>= timer_limit):
		_destory_arrow()
