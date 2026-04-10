extends Control

@onready var dev = $dev
@onready var main = $main
@onready var LabelRULE = $main/LabelRULE
@onready var LabelMAIN = $main/LabelMAIN
@onready var LabelCHOISE = $main/LabelCHOISE
var DS = DialogSystem.new()
var add = false


func _ready() -> void:
	main.add_child(DS)
	
	dev.visible = false
	#main.visible = false
	
	LabelRULE.text = DS.get_text_by_id("rule")
	LabelMAIN.text = "score: " + str(Globals.score)



func _physics_process(delta: float) -> void:
	score_add()
	update_text()

func update_text():
	LabelMAIN.text = "score: " + str(Globals.score)

func score_add():
	
	if add == false:
		add = true
		await  GTime.delay(1)
		Globals.score += 1
		add = false
