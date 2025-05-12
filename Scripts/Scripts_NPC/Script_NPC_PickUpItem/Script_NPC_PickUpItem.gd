extends RigidBody3D
#extends CharacterBody3D
class_name NPC_PickUpItem_Base

const GIB = preload("res://SytemNode/SN_NPC/SN_NPC_Gib.tscn")

@export_group("Item_Sounds")
@export var inquired_sound:AudioStreamMP3
@export var pickedUp_sound:AudioStreamMP3
@export var dropped_sound:AudioStreamMP3
@export var dead_sound:AudioStreamMP3
@export var audio_player: AudioStreamPlayer3D

@export_group("sound FX")
@export var Chorus_FX:AudioEffectChorus
@export var Pitch_FX:AudioEffectPitchShift
@export var Reverb_FX:AudioEffectReverb

@export_group("Phyisics Reqs")
@export var collision_shape: CollisionShape3D
@export var mesh_shape: MeshInstance3D

##State Machine logic 
@export var State_logic: NPC_PickUpItem_StateLogic


var picked_up: bool = false
var mesh_material: ShaderMaterial
var random_audio_value = RandomNumberGenerator.new()
var spiked_value: float = 0.0
var alpha_value:float = 1.0
var flash_bool: bool = false 
var root_node: Node3D
var initial_rot: Vector3

func _ready() -> void:
	initial_rot = rotation_degrees
	root_node = get_tree().current_scene
	_get_material()
	_generate_random_properties()
	



func _process(_delta: float) -> void:
	if(mesh_material is ShaderMaterial):
		if Singleton_CameraFeed.signal_ok:
			mesh_material.set_shader_parameter("texuture_a", Singleton_CameraFeed.video_texture)
		mesh_material.set_shader_parameter("distortionVertex", spiked_value)
		mesh_material.set_shader_parameter("alpha",alpha_value)
		mesh_material.set_shader_parameter("active",flash_bool)
	else: push_warning("Change to Shader Mat") 



func _physics_process(_delta: float) -> void:
	if picked_up: rotation_degrees = initial_rot #this only changes the rotation, dosent make the object follow the base


func _randomize_rotation()->void:
	rotation.x = randf_range(0.0,TAU)
	rotation.y = randf_range(0.0,TAU)
	rotation.z = randf_range(0.0,TAU)

#region Ready Functions
func _generate_random_properties()->void:
	random_audio_value = random_audio_value.randf_range(0.1,5.0)

func _change_FX_values()->void:
	Chorus_FX.voice_count = int(clamp(random_audio_value,1,4))
	Pitch_FX.pitch_scale = random_audio_value
	Reverb_FX.room_size = clamp((random_audio_value * 0.1),0.1,1)

func _get_material()->void:
	mesh_material = mesh_shape.mesh.surface_get_material(0)
#endregion

#region Interaction Functions
func _picked_up()->void:
	State_logic.signal_item_pickedUp.emit()
	#Se dispara desde el Player InteractArea, desde el state selecting, cuando el objeto se convierte en item on area, se activa
	#Lo que hace que el objeto siga al area, es que se convierte en on item area, y eso toma control de la posici[on del objeto
	#esta funcion solo dispara una señal, para que el objeto cambie su estado espacial 

func _dropped_down()->void:
	State_logic.signal_item_droppedDown.emit()


func _picked_up_logic()->void:
	picked_up = true
	_clear_material()
	freeze = true
	lock_rotation = true
	collision_shape.disabled = true
	_play_pickup_sound()

func _dropped_down_logic()->void:
	picked_up = false
	_opaque_material()
	freeze = false
	lock_rotation = false
	collision_shape.disabled = false
	_play_dropped_sound()

func _asked_question()->void:
	State_logic.signal_item_poked.emit()


func _answer_question()->void:
	_vibrate_material()
	_change_FX_values()
	audio_player.stop()
	audio_player.set_stream(inquired_sound)
	audio_player.play()

func _dies()->void:
	audio_player.stop()
	audio_player.set_stream(dead_sound)
	audio_player.play()
	Singleton_Organ_Beast._dead_plant()
	var gib_amout: int  =5
	for _i in gib_amout:
		var gib_inst = GIB.instantiate()
		get_tree().get_root().add_child(gib_inst)
		gib_inst.global_position =global_position

func _reborns()->void:
	Singleton_Organ_Beast._restored_plant()
	audio_player.stop()
	audio_player.set_stream(dead_sound)
	audio_player.play()

#endregion
func _harmonizes()->void:
	print("harmonizes")

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
	print("vibrating Mat")
	var tween = create_tween()
	tween.tween_property(self,"spiked_value",0.2,0.05)
	tween.tween_property(self,"spiked_value",0.0,0.5)

func _clear_material()->void:
	var color_tween = create_tween()
	color_tween.tween_property(self,"alpha_value",0.2,0.2)

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
