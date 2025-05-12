extends Area3D
class_name Aura_Type_A

signal signal_resonance
signal signal_disonance
signal signal_kill

var aura_type:int
@export var kill_aura:bool

func _ready() -> void:
	_roll_aura_type()


func _compare_auras(area:Aura_Type_A)->void:
	if area.kill_aura:
		signal_kill.emit()
		set_physics_process(false)
	else:
		if self.aura_type != area.aura_type:
			signal_disonance.emit()
		else : signal_resonance.emit()

func _roll_aura_type()->int:
	aura_type =randi_range(0,2)
	return aura_type


func _on_area_entered(area: Area3D) -> void:
	print("entered area")
	if area is Aura_Type_A: _compare_auras(area)
