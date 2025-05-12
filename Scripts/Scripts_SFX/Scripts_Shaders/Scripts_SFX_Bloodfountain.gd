extends Node3D
class_name SFX_bloodfountain

const BLOOD_DECAL =preload("res://SytemNode/SN_Effects/SN_Effects_BloodDecal.tscn")
@onready var blood_raycast: RayCast3D = $BloodRaycast

@onready var blood_particles: GPUParticles3D = $BloodParticles



@export var blood_spatter_count:int = 3
@export var blood_spatter_range: float =2.0
@export var blood_spatter_size_variance: float =0.5

var bleeding_frequency:float = 1.0
var bleeding_timer: Timer





func _set_bleeding_timer()->void:
	bleeding_timer = Timer.new()
	add_child(bleeding_timer)
	bleeding_timer.one_shot = false
	bleeding_timer.wait_time = bleeding_frequency
	bleeding_timer.autostart = true
	bleeding_timer.timeout.connect(_blood_logic)
	bleeding_timer.start()


func _blood_logic()->void:
	blood_raycast.enabled = true
	for _i in blood_spatter_count:
		var h_angle = randf_range(0.0,PI /4.0)
		var v_angle = randf_range(0.0,TAU)
		var dir = Vector3.DOWN.rotated(Vector3.RIGHT, h_angle)
		
		dir = dir.rotated(Vector3.UP,v_angle)
		var raycast_to = global_position + dir *blood_spatter_range
		blood_raycast.target_position = blood_raycast.to_local(raycast_to)
		blood_raycast.force_raycast_update()
		if !blood_raycast.is_colliding(): continue
		
		var hit_pos = blood_raycast.get_collision_point()
		var hit_normal = blood_raycast.get_collision_normal()
		var blood_decal = BLOOD_DECAL.instantiate()
		get_tree().get_root().add_child(blood_decal)
		blood_decal.global_position = hit_pos
		var look_at_pos = hit_pos + hit_normal
		
		if hit_normal.is_equal_approx(Vector3.UP) or hit_normal.is_equal_approx(Vector3.DOWN):
			blood_decal.look_at(look_at_pos,Vector3.RIGHT)
			
		else:blood_decal.look_at(look_at_pos)
		
		blood_decal.rotate_object_local(Vector3.FORWARD,randf_range(0.0,TAU))
		blood_decal.scale *=1.0 +randf_range(-blood_spatter_size_variance,blood_spatter_size_variance)
	blood_raycast.enabled = false

func _stop_bleeding()->void:
	if bleeding_timer !=null: bleeding_timer.stop()
