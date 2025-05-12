extends AudioStreamPlayer

class_name actor_Organ_Mouth


@export var sfx:Array[AudioStreamMP3] = []


func _play_sound(sound_int:int)->void:
	self.stream = sfx[sound_int]
	self.play()


func _tween_sound(sound_int:int,tween_speed:float)->void:
	var tween = create_tween()
	tween.tween_property(self,"stream",sfx[sound_int],tween_speed)
	self.play()


func _fade_in_sound(sound_int:int)->void:
	var last_vol= self.volume_db
	var tween = create_tween()
	tween.tween_property(self,"volume_db",-20,2)
	await tween.finished
	self.stream = sfx[sound_int]
	self.play()
	var tween_2 = create_tween()
	tween_2.tween_property(self,"volume_db",last_vol,2)
