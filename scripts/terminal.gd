extends Control

@onready var main = $main
@onready var LabelMAIN = $main/LabelMAIN
@onready var LabelVER = $main/LabelVER
@onready var LabelTIME = $main/LabelTIME
@onready var LabelCHOISE = $main/LabelCHOISE
@onready var logo = $logo
@onready var ps = $logo/placeholder
@onready var progressbar = $logo/ProgressBar
@onready var path =  "res://text/text_ru.json" 
var choise_stat = false


var DS

const VERSION_DATA = preload("res://version.tres")

func _ready() -> void:
	start()
	
	await  GTime.delay(11)
	
	LabelMAIN.text = DS.get_text_by_id("main_start2")
	TextAnimator._typeware(LabelMAIN,2)
	LabelCHOISE.text = DS.get_text_by_id("choise_start2")
	TextAnimator._typeware(LabelCHOISE, 2)
	
	await GTime.delay(2)
	choise_2(show_dialog.bind("main_test", "choise_test"), show_dialog.bind("_clear","clear"))
	
	
func _process(delta: float) -> void:
	LabelTIME.text = "TIME: " + Time.get_time_string_from_system()

func show_dialog(main_dialog, choise_dialog):
	LabelMAIN.text = DS.get_text_by_id(main_dialog)
	TextAnimator._typeware(LabelMAIN, 2)
	LabelCHOISE.text = DS.get_text_by_id(choise_dialog)
	TextAnimator._typeware(LabelCHOISE, 2)

func choise_2(v1,v2):
	choise_stat = true
	Globals.choise = ""
	while choise_stat != false:
		match Globals.choise:
			"1": 
				v1.call()
				choise_stat = false
			"2":
				v2.call()
				choise_stat = false
			_:
				await  GTime.delay(1)		

func start():
	# init ver
	LabelVER.text ="VER:  " + VERSION_DATA.version
	
	# init DialogSystem
	DS = DialogSystem.new()
	LabelMAIN.add_child(DS)
	
	await GTime.delay(5.5)
	logo.visible = true
	Globals.pc_ligh = Color("green")
	Globals.dot = true
	
	# Screen logo
	await GTime.delay(3)
	ps.visible = false
	progressbar.visible = true
	var tween = create_tween()
	tween.tween_property(progressbar,"value", 100, 1)
	await GTime.delay(2.5)
	logo.visible = false
	main.visible = true
