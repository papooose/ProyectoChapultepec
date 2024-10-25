extends RayCast3D
class_name  raycast_player_b

signal signal_onsigth_sign
signal signal_onsigth_book
signal signal_onsigth_character
signal signal_onsigth_null



@onready var player_input: input_player_b = $"../../../../input_player_b"


var onsigth_collider: interactable_base
var is_looking: bool

#region direction_seeking_functions

var hit_position: Vector3
var hit_normal: Vector3
var look_at_pos: Vector3
var mouse_pos: Vector2
#endregion 



func _ready() -> void:
	_connect_signals()
#region process functions
func _connect_signals()-> void:
	player_input.signal_action_interact.connect(_raycast_interaction)
#endregion



#region Interact_Functions
func _raycast_interaction()->void:
	if(onsigth_collider!= null):
		onsigth_collider._interact()
#endregion







func _disable_crosshair()->void:
	set_physics_process(false)
	self.enabled = false
	signal_onsigth_null.emit()
	
func _enable_crosshair()->void:
	set_physics_process(true)
	self.enabled = true
