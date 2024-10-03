extends state_crosshair_base
class_name state_crosshair_clear
@export var crosshair_text: String
@export var crosshair_label: Label 

func _change_text(new_text:String)->void:
	crosshair_label.text = new_text
func _clear_text()->void:
	crosshair_label.text =""



func _enter_state()->void:
	_change_text(crosshair_text)
func _exit_state()->void:
	pass
