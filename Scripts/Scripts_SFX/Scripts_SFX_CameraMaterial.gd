extends MeshInstance3D
class_name sfx_videomaterial

var mesh_mat: ShaderMaterial
var server: UDPServer
@export var video_texture: ImageTexture
func _ready() -> void:
	_get_material()
	_set_server()

func _process(delta: float) -> void:
	_get_image()



func _set_server()->void:
	server = UDPServer.new()
	server.listen(4242) #how do i know how am i supposed to listen to

func _get_image()->void:
	server.poll()
	if server.is_connection_available():
		var peer= server.take_connection()
		var frame_data = peer.get_packet()
		var image = _decode_image(frame_data)
		video_texture = ImageTexture.create_from_image(image)
		mesh_mat.set_shader_parameter("texuture_a",video_texture)
func _get_material()->void:
	mesh_mat = mesh.surface_get_material(0)
func _decode_image(frame_data:PackedByteArray)->Image:
	var image = Image.new()
	image.load_jpg_from_buffer(frame_data)#carga un jpg de los datos que le llegan
	return image
