extends Node
class_name Settings_Audio



@onready var ITEMFX_BUS_ID = AudioServer.get_bus_index("Items")

@export_group("Audio FX")
@export var Pitch_FX: AudioEffectPitchShift
@export var Reverb_FX: AudioEffectReverb
@export var Chorus_FX: AudioEffectChorus

func _ready() -> void:
	_set_audio_FX()

func _set_audio_FX()->void:
	AudioServer.add_bus_effect(ITEMFX_BUS_ID,Pitch_FX,1)
	#AudioServer.add_bus_effect(ITEMFX_BUS_ID,Reverb_FX,1)
	AudioServer.add_bus_effect(ITEMFX_BUS_ID,Chorus_FX,2)
	
