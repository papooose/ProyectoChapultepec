extends Node
class_name NPC_pickUpItem_StressMeter

signal signal_stress_healed
@warning_ignore("unused_signal")
signal signal_strees_dead

var stress_level:int
var healing_timer: Timer

func _ready() -> void:
	_set_healing_timer()

func _set_healing_timer():
	healing_timer = Timer.new()
	healing_timer.autostart = false
	healing_timer.wait_time = 2
	healing_timer.one_shot = false
	add_child(healing_timer)
	healing_timer.timeout.connect(_decrease_stress)

func increase_stress()->void:
	stress_level += 1

func _decrease_stress()->void:
	if stress_level <= 0: 
		signal_stress_healed.emit() # its recieved by the healing state and changes it back to anodyne
		print("fully healed")
		stress_level = 0
	else: stress_level -=1


func _restore_full_health()->void:
	stress_level = 0
func _instakill()->void:
	stress_level = 500
