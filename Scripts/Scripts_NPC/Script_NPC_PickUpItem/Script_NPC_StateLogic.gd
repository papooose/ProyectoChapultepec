extends Node

class_name NPC_PickUpItem_StateLogic

@export var pick_up_item: NPC_PickUpItem_Base
@onready var spatial_state_machine: Finte_state_machine = $Spatial_state_machine
@warning_ignore("unused_signal")
signal signal_item_pickedUp
@warning_ignore("unused_signal")
signal signal_item_droppedDown
#The spactial state machine only changes from player input
#Only the player can hange the spatial state either by picking it up or dropping it down

@onready var kinetic_state_machine: Finte_state_machine = $Kinetic_state_machine
@warning_ignore("unused_signal")
signal signal_item_poked
@onready var emotional_state_machine: Finte_state_machine = $Emotional_state_machine
