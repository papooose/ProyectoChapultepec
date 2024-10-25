extends CanvasLayer
class_name ui_playerB_manager

#region Signal Emitter
@onready var FSM: Finte_state_machine = $Finte_state_machine
#@onready var player_pointer: player_sightTarget = $"../Player_Sight_Target"



#endregion

#region States
@onready var state_clear: state_crosshair_clear = $States/state_crosshariB_clear
@onready var state_book: state_crosshairB_book = $States/state_crosshariB_book
@onready var state_sign: state_crosshair_sign = $States/state_crosshariB_sign
@onready var state_item: state_crosshair_item = $States/state_crosshariB_item
@onready var state_character: state_crosshairB_character = $States/state_crosshariB_character
#endregion

func _ready() -> void:
	_connect_signals()

func _connect_signals()->void:
	#player_pointer.signal_onsigth_book.connect(FSM._change_state.bind(state_book))
	#player_pointer.signal_onsigth_character.connect(FSM._change_state.bind(state_character))
	#player_pointer.signal_onsigth_sign.connect(FSM._change_state.bind(state_sign))
	#player_pointer.signal_onsigth_null.connect(FSM._change_state.bind(state_clear))
	pass
