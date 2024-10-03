extends Camera3D
class_name camera_player_b


#region Camera mov Vars
@onready var h_axis: Node3D = $"../../Axis_H"
@onready var v_axis: Node3D = $"../../Axis_H/Axis_V"

const MOUSE_SENSITIVITY:float = 0.09 #This value shouldnt be local, try using settings value
var lerp_speed: float = 2.0

var  camera_rot_threshold = MAX_CAMERA_ROT
const MAX_CAMERA_ROT: float = 98.0
const MIN_CAMERA_ROT: float = 30.0


var target_h_rot:float
var target_v_rot:float
#endregion

#region Camera FX vars
const BOB_FREQ: float = 0.5
const BOB_AMP: float = 0.3
var bob_time:float = 0.0

const FOV_BASE:float = 75.0 #This value shouldnt be local, try using and external settings value
const FOV_CHANGE: float = 1.5
#endregion

#region Proces functions
func _process(delta: float) -> void:
	_handle_camera_rot(delta)

#region

#region Camera movement
func _handle_camera_rot(delta)->void:
	target_h_rot = h_axis.rotation.y
	target_v_rot = v_axis.rotation.x
	
	rotation.y = lerp_angle(rotation.y, target_h_rot, delta*lerp_speed)
	rotation.x = lerp_angle(rotation.x, target_v_rot, delta*lerp_speed)



func _handle_camera_input(event)->void:
	if event is InputEventMouseMotion:
		event.relative.x = clamp(event.relative.x,-98,98)

		h_axis.rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENSITIVITY))
		v_axis.rotate_x(deg_to_rad(-event.relative.y * MOUSE_SENSITIVITY))

		h_axis.rotation.x = clamp(h_axis.rotation.x,deg_to_rad(0),deg_to_rad(0))#prevents it from rotationg in the x axis
		v_axis.rotation.y = clamp(v_axis.rotation.y,deg_to_rad(0),deg_to_rad(0))#prevents it from rotation in the y axis
		v_axis.rotation.x = clamp(v_axis.rotation.x,deg_to_rad(-44),deg_to_rad(44))# prevents it from rotating completely
#endregion
