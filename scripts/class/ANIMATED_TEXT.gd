# TextAnimator.gd (может быть Node или RefCounted)
class_name TextAnimator

static var sound = preload("res://sounds/button2.mp3")



static func _typeware(label, duration: float) -> void:
	label.visible_ratio = 0.0
	var tween = label.create_tween()
	
	#if not _audio:
	var _audio = AudioStreamPlayer3D.new()
	label.add_child(_audio)
	_audio.pitch_scale = 4
	_audio.volume_db = -42
	_audio.stream = sound 

	_audio.play()
	tween.tween_property(label,"visible_ratio",1,duration)

	await GTime.delay(duration+0.1)
	_audio.stop()
	_audio.queue_free()
	tween.kill()


static func _typeware_hide(label: Label, duration: float, volume = null) -> void:
	label.modulate.a = 1
	label.visible_ratio = 0.0
	var tween = label.create_tween()
	
	var _audio = AudioStreamPlayer3D.new()
	label.add_child(_audio)
	_audio.pitch_scale = 2
	if volume == null:
		_audio.volume_db = -10
	else:
		_audio.volume_db = volume
	_audio.stream = sound 

	_audio.play()
	
	tween.tween_property(label,"visible_ratio",1,duration/2)
	sound_stop(_audio,duration)
	
	
	await GTime.delay(duration)
	_audio.queue_free()
	
	tween.kill()
	tween = label.create_tween()
	tween.tween_property(label,"modulate:a",0,duration/2)



static func sound_stop(audio, duration):
	await  GTime.delay(duration/2 + 0.1)
	audio.stop()
