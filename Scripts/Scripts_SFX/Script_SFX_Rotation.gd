extends Node3D


@export var rotation_speed: float

func _process(delta: float) -> void:
	_rotate(delta)

func _rotate(delta:float)->void:
	rotation.y += rotation_speed *delta
