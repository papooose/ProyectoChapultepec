extends Node3D
class_name player_sightTarget

#region Signals
signal signal_onsigth_null
signal signal_onsigth_sign
signal signal_onsigth_character
signal signal_onsigth_book
signal signal_onsigth_item
#endregion

var result: Dictionary : get = _detect_from_cam_to_mouse

var is_looking: bool

var query:= PhysicsRayQueryParameters3D.new()
@onready var player_camera: camera_player_b = $"../player_body/Player_Head/Player_camera"
@onready var space_state:PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
const INTERACT_RADIUS: int = 20
const INTERACT_LAYER: int = 2

func _ready() -> void:
	query.set_collision_mask(2)



func _physics_process(_delta: float) -> void:
	_detect_from_collider()

func _disable_sigth_target()->void:
	set_physics_process(false)
func _enable_sigth_target()->void:
	set_physics_process(true)


func _detect_from_cam_to_mouse()->Dictionary:
	query.from = player_camera.global_position
	query.to = query.from + _get_world_mouse_position()
	return space_state.intersect_ray(query)

func _detect_from_collider()->void:
	if !result.is_empty():
		var onsigth_collider = result['collider']
		if !is_looking:
			is_looking = true
			if onsigth_collider is interactable_book:
				print("book")
				signal_onsigth_book.emit()
			if onsigth_collider is interactable_character:
				print("character")
				signal_onsigth_character.emit()
			if onsigth_collider is interactable_sign:
				print("sign")
				signal_onsigth_sign.emit()
	else:
		if is_looking:
			is_looking = false
			signal_onsigth_null.emit()




func _get_world_mouse_position()->Vector3:
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	return player_camera.project_ray_normal(mouse_pos) *INTERACT_RADIUS
