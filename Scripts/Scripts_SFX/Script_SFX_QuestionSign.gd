extends Node3D


@onready var animation_player: AnimationPlayer = $"3dModel_Props_QuestionSign/AnimationPlayer"


func _ready() -> void:
	_destroy_question_sign()

func _destroy_question_sign()->void:
	animation_player.play("Question_Fade")
	await animation_player.animation_finished
	queue_free()
