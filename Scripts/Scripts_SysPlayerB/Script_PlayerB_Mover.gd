extends CharacterBody3D
class_name Mover_player_b

var hit_effect = preload("res://SytemNode/SN_Effects/SN_Effect_PointDirection.tscn")
var hit_effect_inst: Node3D
@onready var player_camera: camera_player_b = $Player_Head/Player_camera
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
				
#region Movement vars
var speed: float = 5
var side_normal: Vector3 = Vector3(-1,0,0)
var mouse_pos: Vector2
var target_pos: Vector3
var direction: Vector3
#endregion
var ray_legth: float = 100

func _process(_delta: float) -> void:
	if(navigation_agent.is_navigation_finished()):
		return
	_move_body_to_point()
	velocity = direction*speed
	move_and_slide()


func _get_mouse_position()->void: #this is the one that actually moves the character
	mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = player_camera.project_ray_origin(mouse_pos)
	var ray_target =ray_origin + player_camera.project_ray_normal(mouse_pos) * ray_legth
	var space = self.get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = ray_origin
	ray_query.to = ray_target
	ray_query.collide_with_areas = true
	var hit_info = space.intersect_ray(ray_query)


	if(!hit_info.is_empty() && hit_info.normal != side_normal):
		navigation_agent.target_position = hit_info.position
		print(hit_info.position)
		hit_effect_inst= hit_effect.instantiate()
		get_tree().get_root().add_child(hit_effect_inst)
		hit_effect_inst.global_position = hit_info.position

func _move_body_to_point()->void: #this just updates the position to go
	target_pos = navigation_agent.get_next_path_position()
	direction = self.global_position.direction_to(target_pos)

func _get_position_w_raycast():
	pass

func _spawn_decal():
	pass

func _stop_body()->void:
	navigation_agent.target_position = self.global_position


func _disable_body_move()->void:
	_stop_body()
	set_process(false)
	set_physics_process(false)
func _enable_body_move()->void:
	set_process(true)
	set_physics_process(true)
