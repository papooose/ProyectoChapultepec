extends MeshInstance3D
class_name sfx_ghostSpawner

@export var ghost_parent:Node3D
@export_dir var ghost_dir
var mesh_dir:String

var ghost_mesh:PackedScene
var ghost_mat: Material
var last_pos: Vector3
var ghost_timer: Timer


func _ready() -> void:
	_get_mesh_direction()
	last_pos = ghost_parent.global_position
	ghost_mesh = load(ghost_dir)
	ghost_mat = self.mesh.surface_get_material(0)
	ghost_timer = Timer.new()
	add_child(ghost_timer)
	ghost_timer.wait_time = 0.17
	ghost_timer.one_shot = false
	ghost_timer.start()
	ghost_timer.timeout.connect(_check_parent_pos)
	

func _check_parent_pos()->void: #this checks if the parent is moving
	if ghost_parent !=null:
		if ghost_parent.global_position != last_pos:
			_spawn_ghost()
		last_pos = ghost_parent.global_position
	else: print("no parent attached")

func _spawn_ghost()->void:
	var ghost_instance = ghost_mesh.instantiate()
	get_tree().get_root().add_child(ghost_instance)
	ghost_instance.global_position = last_pos
	_set_delete_clock(ghost_instance)

func _get_mesh_direction()->void:
	mesh_dir = self.mesh.resource_path
	if mesh_dir != null:
		print("Mesh dir: " + str(mesh_dir))
	else: print("Need to add ghost mesh")


func _set_delete_clock(ghost:Node3D)->void:
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.5
	timer.one_shot = false
	timer.start()
	await timer.timeout
	ghost.queue_free()
	timer.queue_free()
