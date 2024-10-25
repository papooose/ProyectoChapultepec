extends RigidBody3D
class_name NPC_PickUpItem_Base

#@onready var pick_up_item_body: RigidBody3D = $PickUpItem_Body


@export_group("Item_Sounds")
@export var inquired_sound:AudioStreamMP3
@export var pickedUp_sound:AudioStreamMP3
@export var dropped_sound:AudioStreamMP3
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

@export_group("Item properties")
@export var weigth: float
@export var temperature: float
@export var weigth_resistance: float
@export var temperature_resistance: float

@export_group("sound FX")
@export var Chorus_FX:AudioEffectChorus
@export var Pitch_FX:AudioEffectPitchShift
@export var Reverb_FX:AudioEffectReverb


@export_group("Phyisics Reqs")
@export var collision_shape: CollisionShape3D

var picked_up: bool = false
var mesh_material: ShaderMaterial
var random_audio_value = RandomNumberGenerator.new()
var spiked_value: float = 0.0
var alpha_value:float = 1.0
var flash_bool: bool = false
var root_node: Node3D

func _ready() -> void:
	root_node = get_tree().current_scene
	_get_material()
	_generate_random_properties()


func _process(_delta: float) -> void:
	if Singleton_CameraFeed.signal_ok:
		mesh_material.set_shader_parameter("texuture_a", Singleton_CameraFeed.video_texture)
	mesh_material.set_shader_parameter("distortionVertex", spiked_value)
	mesh_material.set_shader_parameter("alpha",alpha_value)
	mesh_material.set_shader_parameter("active",flash_bool)


#region Ready Functions
func _generate_random_properties()->void:
	random_audio_value = random_audio_value.randf_range(0.1,5.0)

func _change_FX_values()->void:
	Chorus_FX.voice_count = int(clamp(random_audio_value,1,4))
	Pitch_FX.pitch_scale = random_audio_value
	Reverb_FX.room_size = clamp((random_audio_value * 0.1),0.1,1)

func _get_material()->void:
	var children: Array = collision_shape.get_children()
	for child in children:
		if child is MeshInstance3D:
			mesh_material = child.mesh.surface_get_material(0)
#endregion

#region Interaction Functions
func _picked_up()->void:
	if !picked_up:
		print("picked up")
		picked_up = true
		_clear_material()
		freeze = true
		lock_rotation = true
		collision_shape.disabled = true
		rotation = Vector3.ZERO
		_play_pickup_sound()

func _dropped_down()->void:
	if picked_up:
		print("droped down")
		_opaque_material()
		freeze = false
		lock_rotation = false
		collision_shape.disabled = false
		_play_dropped_sound()
		picked_up = false

func _asked_question()->void:
	_vibrate_material()
	_change_FX_values()
	audio_player.stop()
	audio_player.set_stream(inquired_sound)
	audio_player.play()
#endregion

#region Audio Functions
func _play_dropped_sound()->void:
	audio_player.stop()
	audio_player.set_stream(dropped_sound)
	audio_player.play()
func _play_pickup_sound()->void:
	audio_player.stop()
	audio_player.set_stream(pickedUp_sound)
	audio_player.play()
#endregion

#region Lerp Funcs
func _vibrate_material()->void:
	var tween = create_tween()
	tween.tween_property(self,"spiked_value",0.2,0.05)
	tween.tween_property(self,"spiked_value",0.0,0.5)

func _clear_material()->void:
	var color_tween = create_tween()
	color_tween.tween_property(self,"alpha_value",0.5,0.5)

func _opaque_material()->void:
	var color_tween = create_tween()
	color_tween.tween_property(self,"alpha_value",1.0,0.5)

func _flash_material()->void:
	if !flash_bool:
		flash_bool = true
		var flash_tween = create_tween()
		flash_tween.tween_property(self,"flash_bool",true,0.02)
		flash_tween.tween_property(self,"flash_bool",false,0.01)
		flash_tween.tween_property(self,"flash_bool",true,0.02)
		flash_tween.tween_property(self,"flash_bool",false,0.01)
#endregion
