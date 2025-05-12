extends RayCast3D
class_name playerb_soundSpawner

var audio_bubble = preload("res://SytemNode/SN_Effects/SN_Effects_AudioBubble.tscn")
var audio_bubble_instance: SFX_audioBubble


@export var player_point: player_pointer
@export var player: Mover_player_b

var target_loaction:Vector3
var current_loaction:float

# We are taking the target position from the hit info : playerpoint_hit_info.position
#thats where the sound bubble will spawn 

#now the sound bubble will have a predetermined pitch, depending on the ground material
#the bubble will start looping an audio stream
#then on a process function it will check if the distance between the bubble and the player, or navigation agent 
# the pitch will change relative to the distance 
# var distance left = player.position - target_position 
# pitch = distance_left

func _process(_delta: float) -> void:
	_update_player_info()

func _update_player_info()->void:
	if audio_bubble_instance!= null:
		audio_bubble_instance.player_position = player.global_position

func _spawn_bubble()->void:
	if(player_point.valid_target):
		if audio_bubble_instance != null : audio_bubble_instance.queue_free()
		audio_bubble_instance = audio_bubble.instantiate() as SFX_audioBubble
		get_tree().get_root().add_child(audio_bubble_instance)
		audio_bubble_instance.global_position = player_point.hit_info.position

func _delete_bubble()->void:
	if audio_bubble_instance!=null:
		audio_bubble_instance.queue_free()

func _update_player_position()->void:
	if audio_bubble_instance !=null:
		audio_bubble_instance.player_position = player.global_position
