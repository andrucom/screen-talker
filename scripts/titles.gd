extends Control
@onready var LabelGAME = $LabelGAME
@onready var LabelAUTHOR = $LabelAUTHOR
@export var title_speed_time = 4

func _ready() -> void:
	TextAnimator._typeware_hide(LabelGAME,title_speed_time)
	TextAnimator._typeware_hide(LabelAUTHOR,title_speed_time)
