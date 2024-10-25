extends state_Base

class_name state_PlayerArea_Carrying


@onready var FSM: Finte_state_machine = $"../../Finte_state_machine"
@onready var PAM: player_areaInteract = $"../.."
@onready var state_clear: state_PlayerArea_Clear = $"../state_PlayerArea_Clear"

var carried_body:PhysicsBody3D


func _connect_signals()->void:
	PAM.signal_item_inquire.connect(_inquire_object_or_area)
	PAM.signal_item_drop.connect(_drop_object)
	PAM.signal_entered_body.connect(_highlight_object)
func _disconnect_signals()->void:
	PAM.signal_item_inquire.disconnect(_inquire_object_or_area)
	PAM.signal_item_drop.disconnect(_drop_object)
	PAM.signal_entered_body.disconnect(_highlight_object)

func _enter_state()->void:
	_pick_up_object()
	_connect_signals()
func _exit_state()->void:
	_disconnect_signals()

func _pick_up_object()->void:
	if PAM.on_area_body !=null: 
		PAM.carried_item = PAM.on_area_body
		PAM.on_area_body = null
		PAM.carrying_item = true


func _drop_object()->void:
	if PAM.carried_item !=null: 
		if(PAM.carrying_item):
			PAM.carried_item._dropped_down()
			PAM.carried_item = null
			PAM.carrying_item = false
			FSM._change_state(state_clear)
	

func _highlight_object()->void:
	if PAM.on_area_body !=null && PAM.on_area_body is NPC_PickUpItem_Base:
		PAM.on_area_body._flash_material()
func _inquire_object_or_area()->void:
	if PAM.on_area_body !=null: PAM.on_area_body._asked_question()
	elif PAM.on_area_area !=null: PAM.on_area_area._asked_question()
