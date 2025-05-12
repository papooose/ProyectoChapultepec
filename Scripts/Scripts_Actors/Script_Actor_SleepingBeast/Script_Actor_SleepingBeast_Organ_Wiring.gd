extends Node
class_name Actor_SleepingBeast_Organ_Wiring

signal signal_game_paused
signal signal_game_resumed

signal signal_asleep
signal signal_awake

var disconnection_timer: Timer
var connection_timer: Timer


var disconection_freq: float

@export var max_disc_freq:float =120.0
@export var  min_disc_freq:float=80.0
func _ready() -> void:
	_set_timers()

func _set_timers()->void:
	connection_timer = Timer.new()
	disconnection_timer = Timer.new()
	get_tree().get_root().add_child.call_deferred(disconnection_timer)
	get_tree().get_root().add_child.call_deferred(connection_timer)
	_set_wait_times()
	_connect_timer_signals()


func _set_wait_times()->void:
	_set_disconnection_freq()
	disconnection_timer.wait_time = disconection_freq
	disconnection_timer.one_shot = true
	disconnection_timer.autostart = true
	
	connection_timer.wait_time = 5.0
	connection_timer.one_shot = true
	connection_timer.autostart = false

func _connect_timer_signals()->void:
	disconnection_timer.timeout.connect(_disconnect_controls)
	connection_timer.timeout.connect(_connect_controls)

func _system_asleep()->void:
	signal_asleep.emit()
	disconnection_timer.paused = true
func _syste_awake()->void:
	signal_awake.emit()
	disconnection_timer.paused = false

func _disconnect_controls()->void:
	signal_game_paused.emit()
	connection_timer.start()
func _connect_controls()->void:
	signal_game_resumed.emit()
	disconnection_timer.start()
	
func _set_disconnection_freq()->void:
	disconection_freq = randf_range(min_disc_freq,max_disc_freq)

func _reset_disconnection_freq(divisor:float)->void: #this one is called by the heart states
	print("reset disconnection times")
	disconection_freq = disconection_freq/divisor
	if disconnection_timer !=null: 
		disconnection_timer.stop()
		disconnection_timer.wait_time = disconection_freq
		disconnection_timer.start()
