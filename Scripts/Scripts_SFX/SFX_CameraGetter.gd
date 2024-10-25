extends Node
class_name sfx_camera_getter

var video_texture: ImageTexture
var server: UDPServer
var signal_ok:bool

func _ready() -> void:
	_set_server()

func _set_server()->void:
	server = UDPServer.new()
	server.listen(4242) #how do i know how am i supposed to listen to

func _process(delta: float) -> void:
	_get_image()

func _get_image()->void:
	server.poll()
	if server.is_connection_available():
		signal_ok = true
		var peer= server.take_connection()
		var frame_data = peer.get_packet()
		var image = _decode_image(frame_data)
		video_texture = ImageTexture.create_from_image(image)
		
func _decode_image(frame_data:PackedByteArray)->Image:
	var image = Image.new()
	image.load_jpg_from_buffer(frame_data)#carga un jpg de los datos que le llegan
	return image
