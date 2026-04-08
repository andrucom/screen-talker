class_name ANIM_TEXT
extends Node

var _labels: Array[Label]
#var label: Label
var time: float = 1.0

func add(l: Label):
	_labels.append(l)
	return self
	
func print_hide(time: float):
	for label in _labels:
		label.visible_ratio = 0.0
		var tween = create_tween()
		tween.tween_property(label,"visible_ratio",1,time/2)
		
		await GTime.delay(time + 1)
		
		tween.kill()
		tween = create_tween()
		tween.tween_property(label,"modulate:a",0,time)

#func _init(current_label: Label, anim_duration: float):
	#label = current_label
	#time = anim_duration
#
#func print_hide():
	#label.visible_ratio = 0.0
	#var tween = create_tween()
	#tween.tween_property(label,"visible_ratio",1,time/2)
	#
	#await GTime.delay(time + 1)
	#
	#tween.kill()
	#tween = create_tween()
	#tween.tween_property(label,"modulate:a",0,time)
	#
