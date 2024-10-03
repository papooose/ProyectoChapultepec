extends RayCast3D
class_name  raycast_player_b

signal signal_onsigth_sign
signal signal_onsigth_book
signal signal_onsigth_character
signal signal_onsigth_null



@onready var player_input: input_player_b = $"../../../../input_player_b"


var onsigth_collider: interactable_base
var is_looking: bool

func _ready() -> void:
	_connect_signals()
#region process functions
func _connect_signals()-> void:
	player_input.signal_action_interact.connect(_raycast_interaction)

func _physics_process(_delta: float) -> void:
	_check_for_collider()
#endregion


#region Interact_Functions
func _raycast_interaction()->void:
	if(onsigth_collider!= null):
		onsigth_collider._interact()

func _check_for_collider()-> void:
	if(is_colliding()):
		onsigth_collider = self.get_collider()
		if(!is_looking):
			is_looking = true
			if(onsigth_collider is interactable_sign):
				signal_onsigth_sign.emit()
			if(onsigth_collider is interactable_book):
				signal_onsigth_book.emit()
			if(onsigth_collider is interactable_character):
				signal_onsigth_character.emit()
	else: 
		if(is_looking):
			signal_onsigth_null.emit()
			is_looking = false
			onsigth_collider = null
#endregion

#region Direction seeking functions
#endregion



func _disable_crosshair()->void:
	set_physics_process(false)
	self.enabled = false
	signal_onsigth_null.emit()
	
func _enable_crosshair()->void:
	set_physics_process(true)
	self.enabled = true
