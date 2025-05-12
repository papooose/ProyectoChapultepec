extends AudioStreamPlayer3D
class_name playerb_inquireAudioSource


#This audioSource plays the spatial items sound effects


#this is triggered when inquired 
func _check_for_item_stream(PAM:player_areaInteract)->void:
	if PAM.on_area_area is NPC_StaticItem_base:
		print("inquired")
		var ground = PAM.on_area_area as NPC_StaticItem_base
		self.stream = ground.ground_sound
		self.play()
