extends CanvasLayer
class_name UI_pauseScreen


@export var wiring: Actor_SleepingBeast_Organ_Wiring


func _ready() -> void:
	hide()
	if wiring !=null:
		_connect_signals()
	else: push_warning("Connect Wiring, or not")

func _connect_signals()->void:
	wiring.signal_game_paused.connect(self.show)
	wiring.signal_game_resumed.connect(self.hide)
