extends Control

@onready var dev = $dev
@onready var main = $main
@onready var LabelRULE = $main/LabelRULE
@onready var LabelMAIN = $main/LabelMAIN
@onready var LabelCHOICE = $main/LabelCHOICE


var DS = DialogSystem.new()
var done = false

func _ready() -> void:
	main.add_child(DS)
	
	dev.visible = false
	#main.visible = false
	



func _physics_process(delta: float) -> void:
	toggle_game_text()
	pass
	
func toggle_game_text():
	await GTime.delay(0.05)
	if G.game == true and done != true:
		done = true
		LabelRULE.text = DS.get_text_by_id("rule")
		LabelCHOICE.text = DS.get_text_by_id("_clear")
		TextAnimator._typeware(LabelRULE,2)
		#TextAnimator._typeware(LabelMAIN,2)
		#TextAnimator._typeware(LabelCHOICE,2)
		
