extends CanvasLayer
class_name crosshair_manager
@onready var FSM: Finte_state_machine = $Finte_state_machine
@export var player_raycast: raycast_player

@onready var state_clear: state_crosshair_clear = $States/state_crosshair_clear
@onready var state_book: state_crosshair_book = $States/state_crosshair_book
@onready var state_character: state_crosshair_sign = $States/state_crosshair_character

@onready var state_sign: state_crosshair_sign = $States/state_crosshair_sign


func _ready() -> void:
	_connect_signals()

func _connect_signals():
	player_raycast.signal_onsigth_null.connect(FSM._change_state.bind(state_clear))
	player_raycast.signal_onsigth_book.connect(FSM._change_state.bind(state_book))
	player_raycast.signal_onsigth_character.connect(FSM._change_state.bind(state_character))
	player_raycast.signal_onsigth_sign.connect(FSM._change_state.bind(state_sign))
