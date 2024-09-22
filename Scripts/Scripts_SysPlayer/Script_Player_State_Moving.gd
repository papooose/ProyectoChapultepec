extends state_Base
class_name state_player_moving

signal signal_movingToTalking
signal signal_movingToIdle
signal signal_movingToPause

#moves character from point a to point b
@onready var player_body: Mover_Player = $"../../Player_Body"
@onready var player_Input: input_player = $"../../Input_player"

var idle_timer:float
var idle_timer_start: bool

func _enter_state()->void:
	_connect_signals()
	_restart_idle_timer()
	_enanble_proceess()

func _exit_state()->void:
	_disconect_signals()
	_disable_process()
	_restart_idle_timer()

func _connect_signals()->void:
	player_Input.signal_action_forward.connect(_move_forward)
func _disconect_signals()->void:
	player_Input.signal_action_forward.disconnect(_move_forward)
func _enanble_proceess()->void:
	set_physics_process(true)
	set_process(true)
func _disable_process()->void:
	set_physics_process(false)
	set_process(false)



func _move_forward()->void:
	player_body.move_dir =-player_body.player_camera.get_global_transform().basis.z.normalized()
	 #whatever z is pointing towards, thats the player forward direction
	player_body.move_speed = clamp(player_body.move_speed + player_body.THRUST_SPEED,0, player_body.MAX_SPEED)

func _check_timer_for_idle(delta)->void:
	if(idle_timer_start != true):
		idle_timer+=delta
		if(idle_timer>=10):
			idle_timer_start = true
			_moving_to_pause()
func _restart_idle_timer()->void:
	idle_timer_start = false
	idle_timer = 0.0
	

#region Transition Functions
func _moving_to_talking()->void:
	signal_movingToTalking.emit()
func _moving_to_idle()->void:
	signal_movingToIdle.emit()
func _moving_to_pause()->void:
	signal_movingToPause.emit()
#endregion
