extends CanvasLayer
class_name crosshair_manager
@onready var FSM: Finte_state_machine = $Finte_state_machine
@onready var player_area: player_areaInteract = $".."

@onready var state_clear: state_crosshair_clear = $States/state_crosshair_clear
@onready var state_book: state_crosshair_book = $States/state_crosshair_book
@onready var state_character: state_crosshair_character = $States/state_crosshair_character


@onready var state_sign: state_crosshair_sign = $States/state_crosshair_sign


func _ready() -> void:
	pass
