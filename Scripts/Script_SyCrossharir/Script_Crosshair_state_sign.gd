extends state_crosshair_base
class_name state_crosshair_sign

@export var crosshair_text: String
@onready var crosshair_label: Label = $"../../AspectRatioContainer2/Crosshair_Text"

func _change_text(new_text:String)->void:
	crosshair_label.text = new_text
func _clear_text()->void:
	crosshair_label.text =""


func _enter_state()->void:
	_change_text(crosshair_text)
func _exit_state()->void:
	pass
