extends state_Base
class_name state_emotional_pickUpItem_Dead

@export var blood_fountain: SFX_bloodfountain 

@onready var kinetic_state_machine: Finte_state_machine = $"../../Kinetic_state_machine"
@onready var medical_state_machine: Finte_state_machine = $".."

@onready var state_relaxed: state_emotional_pickUpItem_relaxed = $"../state_emotional_pickUpItem_relaxed"
@onready var state_anodyne: state_kinetic_pickUpItem_Anodyne = $"../../Kinetic_state_machine/state_kinetic_pickUpItem_Anodyne"

@onready var stress_meter: NPC_pickUpItem_StressMeter = $"../../NPC_pickUpItem_StressMeter"
@onready var state_logic: NPC_PickUpItem_StateLogic = $"../.."
@onready var mesh_skin: NPC_MeshSkin = $"../../NPC_MeshSkin"

var reborn_timer:Timer

func _enter_state()->void:
	_set_r_timer()
	blood_fountain._stop_bleeding()
	state_logic.pick_up_item._dies()
	mesh_skin._switch_mesh(1)

func _exit_state()->void:
	pass


func _set_r_timer()->void:
	reborn_timer = Timer.new()
	get_tree().get_root().add_child(reborn_timer)
	reborn_timer.autostart = true
	reborn_timer.one_shot = false
	reborn_timer.wait_time = 30.0
	reborn_timer.timeout.connect(_try_to_resurrect)
	reborn_timer.start()

func _try_to_resurrect()->void:
	var reborn:bool
	reborn = randi() %2==1
	if reborn: _revive()
	else: print("failed to revive")

func _revive()->void:
	stress_meter._restore_full_health()
	state_logic.pick_up_item._reborns()
	kinetic_state_machine._change_state(state_anodyne)
	medical_state_machine._change_state(state_relaxed)
	if reborn_timer !=null: reborn_timer.queue_free()
