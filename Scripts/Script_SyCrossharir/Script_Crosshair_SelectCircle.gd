extends MeshInstance3D
class_name crosshair_selectring


@export_group("Unselected Parameters")
@export var unselected_alpha:float
@export var unselected_speed:Vector2
@export var unselected_aperture:float
@export var unselected_texture: Texture2D
@export var unselected_color: Color
@export_group("Selected Parameters")
@export var selected_alpha:float 
@export var selected_speed:Vector2
@export var selected_aperture:float
@export var selected_texture: Texture2D
@export var selected_color: Color
@export_group("Carrying Parameters")
@export var carrying_alpha:float
@export var carrying_speed:Vector2
@export var carrying_aperture:float
@export var carrying_texture: Texture2D
@export var carrying_color: Color


var current_alpha: float
var current_speed: Vector2
var current_aperture:float
var current_texture: Texture2D
var current_color: Color



var shader_material: ShaderMaterial

var tween_timer:Timer

func _ready() -> void:
	_set_tween_timer()
	_get_material()
	_set_unselected()
	_set_parameters()

func _get_material()->void:
	shader_material = mesh.surface_get_material(0)

func _process(_delta: float) -> void:
	_set_parameters()


func _set_tween_timer()->void:
	tween_timer = Timer.new()
	add_child(tween_timer)
	tween_timer.wait_time = 0.5
	tween_timer.autostart = false
	tween_timer.one_shot = true
	tween_timer.timeout.connect(set_process.bind(false))


func _set_parameters()->void:
	if shader_material != null:
		shader_material.set_shader_parameter("fire_alpha",current_alpha)
		shader_material.set_shader_parameter("fire_speed",current_speed)
		shader_material.set_shader_parameter("fire_aperture",current_aperture)
		
		shader_material.set_shader_parameter("noise_tex",current_texture)
		shader_material.set_shader_parameter("tip_color",current_color)

func _tween_alpha(target_alpha:float)->void:
	var tween_alpha = create_tween()
	tween_alpha.tween_property(self,"current_alpha",target_alpha,0.5)
func _tween_speed(target_speed:Vector2)->void:
	var tween_speed = create_tween()
	tween_speed.tween_property(self,"current_speed",target_speed,0.5)
func _tween_aperture(target_aperture:float)->void:
	var tween_aperture = create_tween()
	tween_aperture.tween_property(self,"current_aperture",target_aperture,0.5)
func _tween_texture(target_texture:Texture2D)->void:
	var tween_texture = create_tween()
	tween_texture.tween_property(self,"current_texture",target_texture,0.5)
func _tween_color(target_color:Color)->void:
	var tween_color = create_tween()
	tween_color.tween_property(self,"current_color",target_color,0.5)
func _set_unselected()->void:
	if tween_timer !=null : tween_timer.start()
	else: print("no tween timer")
	set_process(true)
	_tween_alpha(unselected_alpha)
	_tween_speed(unselected_speed)
	_tween_aperture(unselected_aperture)

	current_texture = unselected_texture
	_tween_color(unselected_color)

func _set_selected()->void:
	print("Selecting ring")
	if tween_timer !=null : tween_timer.start()
	else: print("no tween timer")
	set_process(true)
	_tween_alpha(selected_alpha)
	_tween_speed(selected_speed)
	_tween_aperture(selected_aperture)
	
	current_texture = selected_texture
	_tween_color(selected_color)


func _set_carrying()->void:
	if tween_timer !=null : tween_timer.start()
	else: print("no tween timer")
	set_process(true)
	_tween_alpha(carrying_alpha)
	_tween_speed(carrying_speed)
	_tween_aperture(carrying_aperture)
	
	current_texture = carrying_texture
	_tween_color(carrying_color)
