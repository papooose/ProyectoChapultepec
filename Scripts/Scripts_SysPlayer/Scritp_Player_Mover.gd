extends CharacterBody3D
class_name Mover_Player

#i use this for camera movement,
# because its camera VFX are tied to the player movement vars

#region Movement vars
var move_speed: float = 0.0
var move_dir= Vector3.ZERO
const THRUST_SPEED: float = 9.0
const THRUST_FRICTION: float = 5.0
const MAX_SPEED: float =50.0
const MIN_SPEED: float =0.0
#endregion
#-----------------------------------------------------------------------------------------------
#region  Camera vars
@onready var player_camera: Camera3D = $Head_Holder/Player_Camera
@export var axis_arms: Node3D

@onready var h_axis: Node3D = $Axis_H
@onready var v_axis: Node3D = $Axis_H/Axis_V

var _target_h_rot:float
var _target_v_rot:float

const MOUSE_SENSITIVITY:float = 0.09 #This value shouldnt be local, try using settings value
var lerp_speed: float = 2.0

var  camera_rot_threshold = MAX_CAMERA_ROT
const MAX_CAMERA_ROT: float = 98.0
const MIN_CAMERA_ROT: float = 30.0
#endregion
#-----------------------------------------------------------------------------------------------
#region Camera FX vars
const BOB_FREQ: float = 0.5
const BOB_AMP: float = 0.3
var bob_time:float = 0.0

const FOV_BASE:float = 75.0 #This value shouldnt be local, try using and external settings value
const FOV_CHANGE: float = 1.5
#endregion
#-----------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------
#region Func Process
func _process(delta: float) -> void:
	_handle_camera_rot(delta)
func _physics_process(delta: float) -> void:
	_handle_FOV(delta)
	velocity.x = move_dir.x * move_speed
	velocity.z = move_dir.z * move_speed
	move_speed = lerp(move_speed,MIN_SPEED, delta*lerp_speed)
	move_and_slide()
	_handle_headbob(delta)
#endregion
#-----------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------
#region Func CameraFX
func _handle_headbob(delta)->void:
	bob_time += delta*velocity.length() * float(is_on_floor())
	player_camera.transform.origin = _head_bob(bob_time)
	player_camera.transform.origin.normalized()
func _head_bob(time)->Vector3:
	var head_pos = Vector3.ZERO
	head_pos.y = sin(time*BOB_FREQ)*BOB_AMP
	head_pos.x = cos(time*BOB_FREQ/2)*BOB_AMP
	return head_pos
func _handle_FOV(delta)->void:
	if(move_speed>=25.0):
		var velocity_clamped = clamp(velocity.length(),0.5, move_speed*2)
		var target_fov = FOV_BASE + FOV_CHANGE * velocity_clamped
		player_camera.fov = lerp(player_camera.fov,target_fov,delta * 8.0)
	player_camera.fov = lerp(player_camera.fov, FOV_BASE, delta*lerp_speed)
#endregion
#-----------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------
#region Func CameraMovement
func _enable_camera_mov()->void:
	set_process_input(true)
	set_process(true)
func _disable_camera_mov()->void:
	set_process_input(false)
	h_axis.rotation.y = player_camera.rotation.y
	v_axis.rotation.x =player_camera.rotation.x
	set_process(false)

func _limit_camera_rot()->void:
	print("limiting Camera Rot")
	camera_rot_threshold = MIN_CAMERA_ROT
func _unlimit_camera_rot()->void:
	print("Unlimiting Camera ROt")
	camera_rot_threshold = MAX_CAMERA_ROT

func _handle_camera_rot(delta)->void:
	_target_h_rot = h_axis.rotation.y
	_target_v_rot = v_axis.rotation.x
	
	player_camera.rotation.y = lerp_angle(player_camera.rotation.y, _target_h_rot, delta*lerp_speed)
	player_camera.rotation.x = lerp_angle(player_camera.rotation.x, _target_v_rot, delta*lerp_speed)
	
	
	axis_arms.rotation.y = lerp_angle(axis_arms.rotation.y,_target_h_rot,delta*lerp_speed*0.5)
	


func _input(event: InputEvent) -> void:
	_handle_camera_input(event)

func _handle_camera_input(event)->void:
	if event is InputEventMouseMotion:
		event.relative.x = clamp(event.relative.x,-98,98)
		
		h_axis.rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENSITIVITY))
		v_axis.rotate_x(deg_to_rad(-event.relative.y * MOUSE_SENSITIVITY))
		
		h_axis.rotation.x = clamp(h_axis.rotation.x,deg_to_rad(0),deg_to_rad(0))#prevents it from rotationg in the x axis
		v_axis.rotation.y = clamp(v_axis.rotation.y,deg_to_rad(0),deg_to_rad(0))#prevents it from rotation in the y axis
		v_axis.rotation.x = clamp(v_axis.rotation.x,deg_to_rad(-44),deg_to_rad(44))# prevents it from rotating completely
		
#endregion
#-----------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------
#region Func Extra Movements
func _body_stop():
	move_speed = 0.0
#endregion
