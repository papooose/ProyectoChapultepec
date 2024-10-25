extends state_Base
class_name state_crosshairB_clear
@onready var ui_label: Label = $"../../Player_UI_Container/AspectRatioContainer/UI_Label"
@export var new_text: String
@onready var animation_player: AnimationPlayer = $"../../Player_UI_Container/AnimationPlayer"

var first_time: bool = true

func _change_text()->void:
	ui_label.text = new_text

func _clear_text()->void:
	ui_label.text = ""

func _enter_state()->void:
	if(first_time):
		first_time = false
	else:
		_clear_text()
		animation_player.play("Container_FadeOut")

func _exit_state()->void:
	pass
