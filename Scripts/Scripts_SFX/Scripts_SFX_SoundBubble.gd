extends AudioStreamPlayer3D
class_name SFX_audioBubble



@onready var ground_cast: RayCast3D = $Ground_Cast
@export var base_sound: AudioStreamMP3


#i am the target position, and the closer the player is, the higher the pitch becomes
#emits a first hit sound at a distance
#the player starts moving
#then when the distance reaches a certain threshold, a "pop" sound is emited

var player_position: Vector3
var distance_left: float

var varying_pitch:float = 1.0



func _ready() -> void:
	self.stream = base_sound
	self.play()
	await self.finished


func _physics_process(_delta: float)-> void:
	_check_proximity()

func _check_proximity()->void:
	distance_left = global_transform.origin.distance_to(player_position)
	floor(distance_left)
	self.pitch_scale = distance_left
	if distance_left <= 2:
		_last_hit()


func _last_hit()->void:
		set_physics_process(false)
		self.stop()
		self.pitch_scale =1.0
		self.stream = base_sound
		self.play()
		await self.finished
		queue_free()


func _check_ground_type()->void:
	ground_cast.force_raycast_update()
	if ground_cast.is_colliding():
		var collider = ground_cast.get_collider()
		if collider is NPC_StaticItem_base:
			_play_ground_audio(collider.ground_sound)

func _play_ground_audio(ground_sound: AudioStreamMP3)->void:
	self.stream = ground_sound
	self.play()
