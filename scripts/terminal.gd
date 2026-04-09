extends Control

@onready var main = $main
@onready var LabelMAIN = $main/LabelMAIN
@onready var LabelVER = $main/LabelVER
@onready var LabelTIME = $main/LabelTIME
@onready var logo = $logo
@onready var ps = $logo/placeholder
@onready var progressbar = $logo/ProgressBar
@onready var path =  "res://text/text_ru.json"

var DS

const VERSION_DATA = preload("res://version.tres")

func _ready() -> void:
	start()
	LabelMAIN.text = DS.get_text_by_id("start")
	
	await GTime.delay(10)

	_animated_text(LabelMAIN, 2)
	LabelMAIN.text = DS.get_text_by_id("start2")
	
	
func _process(delta: float) -> void:
	LabelTIME.text = "TIME: " + Time.get_time_string_from_system()

func _animated_text(label, time):
	label.visible_ratio = 0.0
	var tween = create_tween()
	tween.tween_property(label,"visible_ratio",1,time)

func start():
	# init ver
	LabelVER.text ="VER:  " + VERSION_DATA.version
	
	# init DialogSystem
	DS = DialogSystem.new()
	LabelMAIN.add_child(DS)
	
	# Screen logo
	await GTime.delay(6)
	ps.visible = false
	progressbar.visible = true
	var tween = create_tween()
	tween.tween_property(progressbar,"value", 100, 1)
	await GTime.delay(1.5)
	logo.visible = false
	main.visible = true
