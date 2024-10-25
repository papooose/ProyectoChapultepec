extends state_Base
class_name state_crosshair_signB
@onready var ui_label: Label = $"../../Player_UI_Container/AspectRatioContainer/UI_Label"
@onready var animation_player: AnimationPlayer = $"../../Player_UI_Container/AnimationPlayer"

@export var new_text: String

func _change_text()->void:
	ui_label.text = new_text

func _clear_text()->void:
	ui_label.text = ""
	
func _enter_state()->void:
	_clear_text()
	_change_text()
	animation_player.play("Container_FadeIn")

func _exit_state()->void:
	animation_player.play("Container_FadeOut")
