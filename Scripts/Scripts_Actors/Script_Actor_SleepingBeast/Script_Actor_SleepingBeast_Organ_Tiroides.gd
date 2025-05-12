extends Node
class_name Actor_SleepingBeast_Organ_Tiroides

var health_condition:int
var viewport = get_viewport()

const FPS_Dictionary ={
	0:60,
	1:18,
	2:5
}
const Resolutions ={
	0:1,
	1:0.25,
	2:0.05
}



func _process(_delta: float) -> void:
	#var wait_time = 1.0/ FPS_Dictionary[health_condition] - delta
	#if wait_time >0:
	#	OS.delay_msec(int(wait_time * 1000))
	pass

func _change_res(scale:int)->void:
	get_viewport().set_scaling_3d_scale(Resolutions[scale])
	_centre_scren()

func _centre_scren()->void:
	var centre_Screen = DisplayServer.screen_get_position() + DisplayServer.screen_get_size()/2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(centre_Screen - window_size/2)
