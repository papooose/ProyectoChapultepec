extends MeshInstance3D
class_name SFX_WebcamSetter



var mesh_material:ShaderMaterial = self.get_surface_override_material(0)


func _process(_delta: float) -> void:
	if Singleton_CameraFeed.signal_ok:
			mesh_material.set_shader_parameter("texuture_a", Singleton_CameraFeed.video_texture)
