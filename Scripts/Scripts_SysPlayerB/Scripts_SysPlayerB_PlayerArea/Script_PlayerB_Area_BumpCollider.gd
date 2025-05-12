extends Area3D
class_name player_area_BumpCollider



@export var bump_noie: AudioStreamMP3
@onready var bump_stream_player: AudioStreamPlayer3D = $Bump_Stream_Player

func _ready() -> void:
	_set_bump_sound() 

func _set_bump_sound()->void:
	bump_stream_player.stream = bump_noie


func _on_body_entered(_body: Node3D) -> void:
	bump_stream_player.play()
