extends Node3D
class_name player_target

var hit_effect = preload("res://SytemNode/SN_Effects/SN_Effect_PointDirection.tscn")
var hit_effect_inst: Node3D
var new_arrow: Node3D
var last_arrow:Node3D
var result: Dictionary : get = _detect_from_cam_to_mouse
var arrow_array:Array= []
const  MAX_ARROW_AMT: int = 5

var query:= PhysicsRayQueryParameters3D.new()
@onready var player_camera: camera_player_b = $"../player_body/Player_Head/Player_camera"
@onready var space_state:PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
@onready var animation_player: AnimationPlayer = $AnimationPlayer


const INTERACT_RADIUS: int = 20

func _disable_pointer()->void:
	set_process(false)
func _enable_pointer()->void:
	set_process(true)


func _process(delta: float) -> void:
	if result:
		global_position.x = lerp(global_position.x,result.position.x, delta*20)
		global_position.z = lerp(global_position.z, result.position.z, delta*20)



func _detect_from_cam_to_mouse()->Dictionary:
	query.from = player_camera.global_position
	query.to = query.from + _get_world_mouse_position()
	return space_state.intersect_ray(query)

func _get_world_mouse_position()->Vector3:
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	return player_camera.project_ray_normal(mouse_pos) *INTERACT_RADIUS


func _spawn_arrow():
	animation_player.play("Spot_Neutral")
	if(result):
		hit_effect_inst = hit_effect.instantiate()
		get_tree().get_root().add_child(hit_effect_inst)
		hit_effect_inst.global_position = result.position
