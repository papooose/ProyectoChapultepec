extends Node
class_name Actor_SleepingBeast_NapClock


signal signal_nap_time_start
signal signal_nap_time_over

var nap_timer:Timer= Timer.new()
var awake_timer:Timer= Timer.new()
var nap_time_duration:float
var awake_time_duration:float

@export var anim_rect: AnimatedTextureRect


func _ready() -> void:
	awake_time_duration = randf_range(20.0,30.0)
	_set_awake_timer()
	_set_nap_timer()
	awake_timer.start()

func _process(delta: float) -> void:
	var time_left = awake_timer.time_left
	print(time_left)


func _set_nap_timer()->void:
	print("nap set up")
	nap_timer.autostart = false
	nap_timer.one_shot = true
	nap_timer.wait_time = nap_time_duration +1
	add_child(nap_timer)
	nap_timer.timeout.connect(_new_awake_set_up)

func _set_awake_timer()->void:
	print("awake set up")
	awake_timer.autostart = false
	awake_timer.one_shot = true
	awake_timer.wait_time = awake_time_duration
	add_child(awake_timer)
	awake_timer.timeout.connect(_new_nap_set_up)




func _new_nap_set_up()->void:
	print("nap time_start")
	signal_nap_time_start.emit()
	nap_time_duration = randf_range(10.0,120.0)
	nap_timer.wait_time = nap_time_duration
	anim_rect.animation = "Anim_Eye_Closing"
	nap_timer.start()

func _new_awake_set_up()->void:
	print("awake_time_start")
	signal_nap_time_over.emit()
	awake_time_duration = randf_range(300.0,500.0)
	awake_timer.wait_time = awake_time_duration
	awake_timer.start()
