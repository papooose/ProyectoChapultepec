extends CharacterBody3D
class_name Mover_player_b

@onready var player_camera: camera_player_b = $Player_Head/Player_camera
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var player_hit_target: player_pointer = $"../player_pointer"

#region Movement vars
var speed: float = 5
var target_pos: Vector3
var direction: Vector3
#endregion

func _process(_delta: float) -> void:
	if(navigation_agent.is_navigation_finished()):
		return
	_move_body_to_point()
	velocity = direction*speed
	move_and_slide()


func _move_to_mouse_position()->void:
	navigation_agent.path_changed.emit()
	if(player_hit_target.valid_target):
		navigation_agent.target_position = player_hit_target.hit_info.position

func _move_body_to_point()->void: #this just updates the position to go
	target_pos = navigation_agent.get_next_path_position()
	direction = self.global_position.direction_to(target_pos)


func _stop_body()->void:
	navigation_agent.target_position = self.global_position

func _disable_body_move()->void:
	_stop_body()
	set_process(false)
	set_physics_process(false)
func _enable_body_move()->void:
	set_process(true)
	set_physics_process(true)
