extends Node3D
class_name player_target

var hit_effect = preload("res://SytemNode/SN_Effects/SN_Effect_PointDirection.tscn")
var hit_effect_inst: Node3D

var question_effect =preload("res://SytemNode/SN_Effects/SN_Effects_QuestionSign.tscn")
var question_effect_inst: Node3D


var xform: Transform3D

@onready var animation_player: AnimationPlayer = $Player_Target_Mesh/AnimationPlayer
@onready var player_target_raycast: RayCast3D = $Player_Target_Raycast
@onready var player_point: player_pointer = $"../player_pointer"

var arrow_array:Array =[]

const INTERACT_RADIUS: int = 20

func _disable_pointer()->void:
	set_process(false)
func _enable_pointer()->void:
	set_process(true)

func _physics_process(delta: float) -> void:
	_align_with_floor(delta)
	_target_follow_mouse(delta)

func _target_follow_mouse(delta:float)->void:
	if(player_point.valid_target):
		global_position.x = lerp(global_position.x, player_point.hit_info.position.x, delta*30)
		global_position.z = lerp(global_position.z, player_point.hit_info.position.z, delta*30)
		global_position.y = player_point.hit_info.position.y

func _align_with_floor(_delta:float)->void:
	if(player_point.valid_target):
		_rotate_with_floor(player_point.hit_info.normal)
		global_transform = global_transform.interpolate_with(xform,0.3)

func _rotate_with_floor(floor_normal)->void:
	xform = global_transform
	xform.basis.y = floor_normal
	xform.basis.x = xform.basis.z.cross(floor_normal)
	xform.basis = xform.basis.orthonormalized()

func _spawn_arrow()->void:
	animation_player.play("Spot_Neutral")
	if(player_point.valid_target):
		hit_effect_inst = hit_effect.instantiate()
		get_tree().get_root().add_child(hit_effect_inst)
		var hit_normal: Vector3 = player_point.hit_info.normal
		var look_at_pos: Vector3 = player_point.hit_info.position + player_point.hit_info.normal
		hit_effect_inst.global_position = player_point.hit_info.position
		arrow_array.append(hit_effect_inst)
		if hit_normal.is_equal_approx(Vector3.UP) or hit_normal.is_equal_approx(Vector3.DOWN):
			hit_effect_inst.look_at(look_at_pos, Vector3.RIGHT)
		else :
			hit_effect_inst.look_at(look_at_pos)

func _transform_arrows()->void:
	for arrow in arrow_array:
		if is_instance_valid(arrow):
			arrow._transform_arrow()

func _spawn_interact():
	if(player_point.valid_target):
		question_effect_inst = question_effect.instantiate()
		get_tree().get_root().add_child(question_effect_inst)
		var hit_normal: Vector3 = player_point.hit_info.normal
		var look_at_pos: Vector3 = player_point.hit_info.position + player_point.hit_info.normal
		question_effect_inst.global_position = player_point.hit_info.position
		
		if hit_normal.is_equal_approx(Vector3.UP) or hit_normal.is_equal_approx(Vector3.DOWN):
			question_effect_inst.look_at(look_at_pos, Vector3.RIGHT)
		else :
			question_effect_inst.look_at(look_at_pos)
