extends Control

@onready var game = $Game
@onready var main = $main
@onready var LabelMAIN = $main/LabelMAIN
@onready var LabelVER = $main/LabelVER
@onready var LabelTIME = $main/LabelTIME
@onready var Label_ = $main/Label_
@onready var LabelCHOICE = $main/LabelCHOICE
@onready var logo = $logo
@onready var ps = $logo/placeholder
@onready var progressbar = $logo/ProgressBar
@onready var path =  "res://text/text_ru.json" 

var DS

const VERSION_DATA = preload("res://version.tres")

func _ready() -> void:
	start()
	
	await GTime.delay(11)
	
	LabelMAIN.text = DS.get_text_by_id("main_start2")
	TextAnimator._typeware(LabelMAIN,2)
	LabelCHOICE.text = DS.get_text_by_id("choice_start2")
	TextAnimator._typeware(LabelCHOICE, 2)
	
	await GTime.delay(2)
	DS.choice(game_toggle.bind(), exit.bind())

func _process(delta: float) -> void:
	LabelTIME.text = "TIME: " + Time.get_time_string_from_system()

func exit():
	get_tree().quit()

func game_toggle():
	LabelMAIN.visible = false
	LabelCHOICE.visible = false
	game.visible = true
	await  GTime.delay(0.2)
	G.game = true

func end_game():
	if G.end_game == true:
		game.visible = false

func start():
	# init ver
	LabelVER.text ="VER:  " + VERSION_DATA.version
	
	main.visible = false
	game.visible = false
	
	# init DialogSystem
	DS = DialogSystem.new()
	LabelMAIN.add_child(DS)
	
	await GTime.delay(5.5)
	logo.visible = true
	G.pc_ligh = Color("green")
	G.dot = true
	
	# Screen logo
	await GTime.delay(3)
	ps.visible = false
	progressbar.visible = true
	var tween = create_tween()
	tween.tween_property(progressbar,"value", 100, 1)
	await GTime.delay(2.5)
	logo.visible = false
	main.visible = true
