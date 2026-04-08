extends Control
@onready var label = $Label
@onready var label3 = $Label3
@export var title_speed_time = 4



func _ready() -> void:
	_animated(label,title_speed_time)
	_animated(label3,title_speed_time)
	
func _animated(label, time):
	label.visible_ratio = 0.0
	var tween = create_tween()
	tween.tween_property(label,"visible_ratio",1,time/2)
	
	await GTime.delay(title_speed_time)
	
	tween.kill()
	tween = create_tween()
	tween.tween_property(label,"modulate:a",0,time/2)
