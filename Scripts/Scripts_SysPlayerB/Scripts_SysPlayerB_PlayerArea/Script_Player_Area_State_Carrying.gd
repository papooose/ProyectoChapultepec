extends state_Base

class_name state_PlayerArea_Carrying


@onready var FSM: Finte_state_machine = $"../../Finte_state_machine"
@onready var PAM: player_areaInteract = $"../.."
@onready var inquire_audio_source: playerb_inquireAudioSource = $"../../playerb_inquireAudioSource"
@onready var state_clear: state_PlayerArea_Clear = $"../state_PlayerArea_Clear"
@onready var target_ring: crosshair_selectring = $"../../Player_Target_Ring"


func _connect_signals()->void:
	PAM.signal_item_inquire.connect(_inquire_object_or_area)
	PAM.signal_entered_body.connect(_highlight_object)
func _disconnect_signals()->void:
	PAM.signal_item_inquire.disconnect(_inquire_object_or_area)
	PAM.signal_item_pickup.disconnect(_drop_object)
	PAM.signal_entered_body.disconnect(_highlight_object)

func _enter_state()->void:
	_connect_signals()
	_prevent_imediate_dropping()
	target_ring._set_carrying()
func _exit_state()->void:
	_disconnect_signals()

func _prevent_imediate_dropping():
	var timer: Timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false
	timer.wait_time = 0.2
	timer.start()
	await timer.timeout
	PAM.signal_item_pickup.connect(_drop_object)
	timer.queue_free()


 
	
func _drop_object()->void:
	if PAM.carried_item !=null: 
		PAM.carried_item._dropped_down()
		PAM.carried_item = null
		FSM._change_state(state_clear)
	

func _highlight_object()->void:
	if PAM.on_area_body !=null && PAM.on_area_body is NPC_PickUpItem_Base:
		PAM.on_area_body._flash_material()
func _inquire_object_or_area()->void:
	if PAM.on_area_body !=null: PAM.on_area_body._asked_question()
	elif PAM.on_area_area !=null: inquire_audio_source._check_for_item_stream(PAM)
