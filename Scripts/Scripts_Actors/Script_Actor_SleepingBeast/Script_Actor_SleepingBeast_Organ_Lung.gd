extends Node
class_name Actor_SleepingBeast_Organ_Lung


var max_num_of_plants:int
var plants_lost:int


func _ready() -> void:
	_ge_all_plants()

func _ge_all_plants()->void:
	var plants = get_children()
	for plant in plants:
		if plant is NPC_PickUpItem_Base:
			max_num_of_plants +=1
