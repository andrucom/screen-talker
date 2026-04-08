extends Control

@onready var labelR = $RichTextLabel
@onready var ver = $LabelVER
@onready var label2 = $Label2
const VERSION_DATA = preload("res://version.tres")

func _ready() -> void:
	ver.text ="VER:  " + VERSION_DATA.version
	
	


func _process(delta: float) -> void:
	label2.text = "TIME: " + Time.get_time_string_from_system()


func _animated_text(label, time):
	label.visible_ratio = 0.0
	var tween = create_tween()
	tween.tween_property(label,"visible_ratio",1,time)
