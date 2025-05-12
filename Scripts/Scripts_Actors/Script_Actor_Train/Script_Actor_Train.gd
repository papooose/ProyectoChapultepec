extends Node3D
class_name Actor_Train



@export var life_span: float
@export var fadeout_time: float

var life_timer = Timer.new()
var stop_timer:Timer


@export_group("Random Variables")
var stop_bool: bool
var stop_time:float
var speed:float = 1.0

var max_speed: float = 30.0

var mesh_Shader: ShaderMaterial
var alpha_value:float

#This Script holds the train variables, and sets up its shader and corresponding opacity
#Controlls another state machine 
#it has three states 
#Starting:
	#all of the random vlaues are rolled
	#the train gets it shader assinged
	#The train shades in into existance
	#The tran starts accelerating
	#The train clock for its lifespan starts going down
	#If the value for stopping is true, and the lifetime of the train is reaching its half point: The train will go to stopping
	#Once the clock hits zero, the train slowly fades out of exisence

#Stoping:  "If the value for stopping rolled true, then the train will stop
	#The train reduces its speed till it reaces zero
	#Once it has stopped the train Passes to Stop
#Stopped:
	#the train waits untill the stopping time has reached zero
	#the train continues to accelerating
#Resuming: 
	#The train lifespan clock is restarted 

#Resuming 
func _ready() -> void:
	_set_random_values()
	_set_timer()
	_get_mesh_shader()
	_fade_in()

func _process(_delta: float) -> void:
	if mesh_Shader!=null:
		mesh_Shader.set_shader_parameter("alpha",alpha_value)

func _physics_process(delta: float) -> void:
	_move_forward(delta)

func _set_random_values():
	var random_lifespan = RandomNumberGenerator.new()
	var random_speed = RandomNumberGenerator.new()
	var random_bool = RandomNumberGenerator.new()
	var random_stoptime = RandomNumberGenerator.new()

	stop_bool = random_bool.randi() % 2 == 0
	if stop_bool: stop_time = random_stoptime.randf_range(6,10)

	life_span = random_lifespan.randf_range(15,30)
	max_speed = random_speed.randf_range(10,25)

func _set_timer()->void:
	add_child(life_timer)
	life_timer.autostart = true
	life_timer.one_shot = true
	life_timer.wait_time = life_span
	life_timer.start()

func _get_mesh_shader()->void:
	var mesh = self.get_child(0)
	if mesh is MeshInstance3D:
		mesh_Shader= mesh.mesh.surface_get_material(0)
		mesh_Shader.set_shader_parameter("alpha",0)


func _move_forward(delta)->void:
	global_position += -global_transform.basis.z *speed *delta


func _deaccelerate()->void:
	var tween = create_tween()
	tween.tween_property(self,"speed",0,fadeout_time)

func _accelerate()->void:
	var tween = create_tween()
	tween.tween_property(self,"speed",max_speed,fadeout_time)

func _fade_in()->void:
	var tween = create_tween()
	tween.tween_property(self,"alpha_value",0.5,5.0)

func _fade_out()->void:
	var tween = create_tween()
	tween.tween_property(self,"alpha_value",0.0,fadeout_time)
	await get_tree().create_timer(fadeout_time).timeout
	queue_free()
