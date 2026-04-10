# TextAnimator.gd (может быть Node или RefCounted)
class_name TextAnimator

static func _typeware(label, duration: float) -> void:
	label.visible_ratio = 0.0
	var tween = label.create_tween()
	tween.tween_property(label,"visible_ratio",1,duration)

static func _typeware_hide(label, duration: float) -> void:
	label.visible_ratio = 0.0
	var tween = label.create_tween()
	tween.tween_property(label,"visible_ratio",1,duration/2)
	
	await GTime.delay(duration)
	
	tween.kill()
	tween = label.create_tween()
	tween.tween_property(label,"modulate:a",0,duration/2)
