extends Marker3D

var bullet_hit = preload("res://SytemNode/SN_Effects/SN_Effect_PointDirection.tscn")
var spawn_rate= 3.0
var spawn_time =0.0

func _process(delta: float) -> void:
	spawn_time -= delta
	if(spawn_time <0.0):
		spawn_time = spawn_rate
		var effect_inst = bullet_hit.instantiate()
		effect_inst.global_transform = global_transform
		get_tree().get_root().add_child(effect_inst)
