extends CharacterBody3D
class_name NPC_Gib


@export var start_move_speed = 8
@export var grav = 35.0
@export var drag =0.01
@export var velo_retained_on_bounce = 0.8

@onready var gib_graphics = $Graphics.get_children()


func _ready() -> void:
	for gibs in gib_graphics:
		gibs.hide()
	gib_graphics[randi_range(0,gib_graphics.size()-1)].show()
	_randomize_rotation()
	velocity = -global_transform.basis.y * randf_range(0.0,start_move_speed)
	_gib_fade_out()

func _physics_process(delta: float) -> void:
	velocity += velocity*drag + Vector3.DOWN *grav *delta
	
	var collision = move_and_collide(velocity*delta)
	if collision:
		var d = velocity
		var n = collision.get_normal()
		var r = d -2* d.dot(n) * n
		velocity = r * velo_retained_on_bounce
		var velo_magnitude = velocity.length()
		if velo_magnitude >1.0:
			_randomize_rotation()
		if velo_magnitude <0.5:
			set_physics_process(false)


func _randomize_rotation()->void:
	rotation.x = randf_range(0.0,TAU)
	rotation.y = randf_range(0.0,TAU)
	rotation.z = randf_range(0.0,TAU)

func _gib_fade_out()->void:
	await get_tree().create_timer(5).timeout
	queue_free()
