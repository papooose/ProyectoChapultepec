extends state_Base
class_name state_PlayerArea_SelectingObj


@onready var FSM: Finte_state_machine = $"../../Finte_state_machine"
@onready var PAM: player_areaInteract = $"../.."

@onready var state_clear: state_PlayerArea_Clear = $"../state_PlayerArea_Clear"
@onready var state_carrying: state_PlayerArea_Carrying = $"../state_PlayerArea_Carrying"

var ocuppied_area:bool = false

func _enter_state()->void:
	ocuppied_area = false
	_connect_signals()
	_highlight_object()
func _exit_state()->void:
	_disconnect_signals()

func _connect_signals()->void:
	PAM.signal_entered_body.connect(_highlight_object)
	PAM.signal_exited_body.connect(_unselect_object)
	PAM.signal_item_inquire.connect(_inquire_object)
	PAM.signal_item_pickup.connect(_pick_up_object)
	
func _disconnect_signals()->void:
	PAM.signal_entered_body.disconnect(_highlight_object)
	PAM.signal_exited_body.disconnect(_unselect_object)
	PAM.signal_item_inquire.disconnect(_inquire_object)
	PAM.signal_item_pickup.disconnect(_pick_up_object)



func _highlight_object()->void:
	if PAM.on_area_body !=null && PAM.on_area_body is NPC_PickUpItem_Base && ocuppied_area!=true:
		ocuppied_area = true
		PAM.on_area_body._flash_material()
func _inquire_object()->void:
	if PAM.on_area_body is NPC_PickUpItem_Base: PAM.on_area_body._asked_question()
func _unselect_object()->void:
	ocuppied_area = false
	PAM.on_area_body = null
	FSM._change_state(state_clear)
func _pick_up_object()->void:
	if(PAM.on_area_body is NPC_PickUpItem_Base):
		PAM.on_area_body._picked_up()
		FSM._change_state(state_carrying)
	
