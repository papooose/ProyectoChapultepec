extends Node3D
class_name SFX_trainSpawner

var train_to_spawn = preload("res://Assets/Assets_3DM/Assets_3DM_Metro/3DM_Metro.tscn")
@export_dir var spawn_dir

@export var randow_spawn_rate:bool
@export var spawn_rate: float

var spawn_instance: Node3D

var train_spawn_rate = RandomNumberGenerator.new()


var spawn_timer: Timer

func _ready() -> void:
	_setup_timer()

func _setup_timer()->void:
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.autostart = true
	spawn_timer.one_shot= false
	spawn_timer.wait_time = _randomize_spawn_rate()
	spawn_timer.start()
	spawn_timer.timeout.connect(_randomize_spawn_rate)
	spawn_timer.timeout.connect(_spawn_train)

func _spawn_train()->void:
	var train_instance = train_to_spawn.instantiate()
	get_tree().get_root().add_child(train_instance)
	train_instance.global_transform = self.global_transform


func _randomize_spawn_rate()->float:
	var random_spawn_rate:float
	random_spawn_rate = train_spawn_rate.randf_range(10.0,30.0)
	spawn_timer.wait_time = random_spawn_rate
	return random_spawn_rate
