extends Control

@onready var LabelMAIN = $main/LabelMAIN
@onready var LabelVER = $main/LabelVER
@onready var LabelTIME = $main/LabelTIME
const VERSION_DATA = preload("res://version.tres")

func _ready() -> void:
	LabelVER.text ="VER:  " + VERSION_DATA.version
	
	


func _process(delta: float) -> void:
	LabelTIME.text = "TIME: " + Time.get_time_string_from_system()


func _animated_text(label, time):
	label.visible_ratio = 0.0
	var tween = create_tween()
	tween.tween_property(label,"visible_ratio",1,time)
