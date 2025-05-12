extends Area3D
class_name player_areaInteract

#this script only emits signals that can be read by either 
#the ui manager
#or the item holder

#cuando un objeto entra al area obtiene su script, y si hay un objeto en ella
#y se activa cualquiera de los dos inputs
#puede activar su sonido de pregunta 
#o puede comenzar a cargarlo 
#tambien cuenta con un raycast que detecta el suelo, y obtiene su script de interactable
#para hacerle preguntas y activarlo 
#sin embargo, si hay un objeto en el area
#el raycast que detecta objetos, y que tambien esta conectado al input
#es desactivado
@onready var player_input: input_player_b = $"../../input_player_b"
@export var object_holder: Node3D
@onready var area_raycast: RayCast3D = $RayCast3D

@export_group("States")
@onready var state_clear: state_PlayerArea_Clear = $States/state_PlayerArea_Clear
@onready var state_carrying: state_PlayerArea_Carrying = $States/state_PlayerArea_Carrying
@onready var state_selecting_obj: state_PlayerArea_SelectingObj = $States/state_PlayerArea_SelectingObj


signal signal_item_pickup
signal signal_item_inquire

signal signal_entered_body(body:PhysicsBody3D)
signal signal_exited_body


var on_area_body: PhysicsBody3D
var on_area_area: PhysicsBody3D

var carried_item: PhysicsBody3D

var ready_to_carry: bool = true
var ready_to_drop:bool = false

func _ready() -> void:
	if player_input !=null:
		player_input.signal_action_interact.connect(_inquire_object)
		player_input.signal_action_interact_alt.connect(_pick_up_object)
	else: push_warning("Connect player input please")


func _physics_process(_delta: float) -> void:
	if carried_item != null:
		carried_item.global_position = object_holder.global_position #Cuando es cargado, el objeto sigue al objetivo
	_get_area_colliders()
	if has_overlapping_bodies():
		area_raycast.enabled = false
		_get_bodies_on_area()
		signal_entered_body.emit()
	else: 
		on_area_body = null
		area_raycast.enabled = true
		signal_exited_body.emit() 

func _get_bodies_on_area()->void:
	var array_of_bodies:Array = get_overlapping_bodies()
	var array_int: int = array_of_bodies.size()
	if(array_int != array_int):
		print("new bodies")
	if array_of_bodies !=null:
		on_area_body = array_of_bodies.back() #gets the last one of them
		if on_area_body is NPC_PickUpItem_Base : 
			#on_area_body._flash_material()
			pass


#el objeto en el area comienza a seguir al marker 3d #es una señal disparada desde el input
func _pick_up_object()->void:
	signal_item_pickup.emit()
	#Print("si se intenta tomar la tierra, se puede decir, el mundo es muy pesado, no puedo con todo

# si hay un objeto en el area, y se presiona click derecho, se emite un sonido/imagen
#pero cambia si es un objeto estatico, o un objeto cargable
func _inquire_object()->void:
	signal_item_inquire.emit()


#limpia la variable de on_areabody, y reactiva el raycast
#region Raycast_Management
func _get_area_colliders()->void:
	if area_raycast.is_colliding():
		var collider = area_raycast.get_collider()
		if collider is NPC_StaticItem_base:
			on_area_area = collider #the audio info its taken from this one, meaing they must have a reference to this script
			#signal_entered_area.emit()
			pass
	else: 
		on_area_area = null
#endregion

#region bump detection

#endregion 
