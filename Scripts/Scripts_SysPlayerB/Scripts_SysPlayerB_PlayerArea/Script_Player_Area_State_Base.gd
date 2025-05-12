extends state_Base

class_name state_PlayerArea_Clear

@export var FSM: Finte_state_machine
@export var PAM: player_areaInteract

@export_group("States")
@export var state_selectingObj: state_PlayerArea_SelectingObj
@export var target_ring: crosshair_selectring
@export var inquire_audio_source: playerb_inquireAudioSource


var on_area_area:PhysicsBody3D

func _enter_state()->void:
	PAM.ready_to_carry = true
	target_ring._set_unselected()
	_connect_signals()
func _exit_state()->void:
	_disconnect_signals()

func _connect_signals()->void:
	PAM.signal_item_inquire.connect(_inquire_area)
	PAM.signal_entered_body.connect(_body_in_area)


func _disconnect_signals()->void:
	PAM.signal_item_inquire.disconnect(_inquire_area)
	PAM.signal_entered_body.disconnect(_body_in_area)

	
func _inquire_area()->void:
	if PAM.on_area_area !=null: on_area_area = PAM.on_area_area
	if on_area_area is NPC_StaticItem_base: 
		#on_area_area._asked_question()
		inquire_audio_source._check_for_item_stream(PAM)

func _body_in_area()->void:
	FSM._change_state(state_selectingObj)
	
