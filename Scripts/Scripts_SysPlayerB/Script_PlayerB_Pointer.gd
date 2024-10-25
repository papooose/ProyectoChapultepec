extends Node3D
class_name player_pointer 


@onready var player_camera: camera_player_b = $"../player_body/Player_Head/Player_camera"


var side_normal: Vector3 = Vector3(-1,0,0)
var ray_length: float = 100
var valid_target: bool
#region Position Vars
var mouse_pos: Vector2
var hit_info: Dictionary 

#endregion


func _physics_process(_delta: float) -> void:
	_get_mouse_pos()


func _get_mouse_pos()->void:
	mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = player_camera.project_ray_origin(mouse_pos)
	var ray_target =ray_origin + player_camera.project_ray_normal(mouse_pos) * ray_length
	var space = self.get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.set_collision_mask(2)
	ray_query.from = ray_origin
	ray_query.to = ray_target
	ray_query.collide_with_areas = true
	hit_info = space.intersect_ray(ray_query)

	if(!hit_info.is_empty() && hit_info.normal != side_normal):
		valid_target = true
	else: valid_target = false
