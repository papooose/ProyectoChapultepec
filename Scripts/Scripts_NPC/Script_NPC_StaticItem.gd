extends StaticBody3D
class_name NPC_StaticItem_base


@export var inquired_sound: AudioStreamMP3
@export var ground_sound: AudioStreamMP3
@export var audio_player: AudioStreamPlayer

@export var weigth_resistance:float
@export var temperature_resistance:float



var random_audio_value:float


func _asked_question()->void:
	audio_player.set_stream(inquired_sound)
	audio_player.stop()
	audio_player.play()
