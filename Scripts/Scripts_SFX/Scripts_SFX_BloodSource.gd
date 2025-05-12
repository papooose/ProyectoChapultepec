extends Node3D


@export var blood_surface: SFX_bloodsurface



func _ready() -> void:
	while true:
		var pos:Vector2 = Vector2(self.global_position.x, self.global_position.z)
		blood_surface.drop_at(pos*0.5)
		await get_tree().create_timer(0.15).timeout
