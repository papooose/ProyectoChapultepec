extends AudioStreamPlayer3D
class_name actor_organ_3DMouth



@export var sfx: Array[AudioStreamMP3]






func _fade_in_sound(sound_int:int)->void:
	var last_vol= self.volume_db
	var tween = create_tween()
	tween.tween_property(self,"volume_db",-20,2)
	await tween.finished
	self.stream = sfx[sound_int]
	self.play()
	var tween_2 = create_tween()
	tween_2.tween_property(self,"volume_db",last_vol,2)
