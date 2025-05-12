extends Node
class_name Actor_SleepingBeast_Organ_Heart

signal signal_heart_health_changed

var current_health: int = 200

var max_health:int = 200

var min_health:int = 1


var max_plants:int
var plants_lost:int


func _heal_heart()->void:
	current_health +=1
	if current_health > max_health: current_health = max_health
	signal_heart_health_changed.emit()

func _attack_heart()->void:
	if plants_lost <=0: plants_lost = 1
	current_health -=plants_lost
	if current_health < min_health: current_health = min_health
	signal_heart_health_changed.emit()


func _dead_plant()->void:
	plants_lost += 1

func _restored_plant()->void:
	_heal_heart()
	plants_lost -=1

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_attack_heart()
		print("attacking heart   ")

#function called by the plants on entering the scene
func declare_plant_existence()->void:
	max_plants +=1
