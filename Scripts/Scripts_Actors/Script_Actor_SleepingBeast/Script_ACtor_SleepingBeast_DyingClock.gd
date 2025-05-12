extends Node
class_name Actor_organ_DyingClock

var life_lost:int
var plants_lost:int

@export var time_vel:float
var time_passed:float = 0.0
var dying_clock:Timer
var damage:int

var health_loss_freq:float #velocidad inicial timer
@export_range(20.0,40.0)var min_health_loss_freq:float = 8.0
@export_range(60.0,200.0)var max_health_loss_freq:float = 5.0


var life_span:float #vida maxima
@export_range(240.0,300.0)var min_life_span:float = 240.0
@export_range(400.0,900.0)var max_life_span:float = 400.0

#tiempo que pasa por cada unidad de vida 



func _ready() -> void:
	_set_initial_rand_variables()
	_set_clock()


func _process(delta: float) -> void:
	_pass_time(delta)


func _pass_time(delta_:float)->void:
	life_lost = Singleton_Organ_Beast.max_health - Singleton_Organ_Beast.current_health
	time_vel= life_lost
	time_passed +=delta_*time_vel/10


func _set_clock()->void:
	dying_clock = Timer.new()
	get_tree().get_root().add_child.call_deferred(dying_clock)
	dying_clock.one_shot = false
	dying_clock.wait_time = health_loss_freq
	dying_clock.autostart = true
	dying_clock.timeout.connect(Singleton_Organ_Beast._attack_heart)


func _set_initial_rand_variables()->void:
	_set_life_span()
	_set_helth_loss_freq()
#var health loss freq is tied to the time passed, so life loss freq would be the rand val multiplied by the time passed
func _set_helth_loss_freq()->void: 
	health_loss_freq = randf_range(min_health_loss_freq,max_health_loss_freq)
func _set_life_span()->void: 
	life_span = randf_range(min_life_span,max_life_span)
	life_span = floorf(life_span)
