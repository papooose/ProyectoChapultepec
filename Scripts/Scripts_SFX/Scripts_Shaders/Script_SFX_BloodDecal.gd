extends Decal
class_name SFX_bloodDecal


@export var lifespan: float = 10.0
var life_timer: Timer

func _ready() -> void:
	_set_timer()

func _set_timer()->void:
	life_timer = Timer.new()
	life_timer.wait_time = lifespan
	life_timer.autostart = true
	add_child(life_timer)
	life_timer.timeout.connect(_destroy_decal)
	life_timer.start()

func _destroy_decal()->void:
	var tween = create_tween()
	tween.tween_property(self,"albedo_mix",0,5.0)
	await tween.finished
	var parent = get_parent_node_3d()
	parent.queue_free()
