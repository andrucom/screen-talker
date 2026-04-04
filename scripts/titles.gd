extends Control
@onready var label = $Label
@onready var label2 = $Label2
@export var title_speed_time = 0.5
@export var title_time = 1

func _ready() -> void:
	_animated(label, title_speed_time)
	_animated(label2, title_speed_time)
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass

func _animated(label, time):
	label.visible_ratio = 0.0
	var tween = create_tween()
	tween.tween_property(label,"visible_ratio",1,time/2)
	
	await GTime.delay(title_time)
	
	tween.kill()
	tween = create_tween()
	tween.tween_property(label,"modulate:a",0,time)
