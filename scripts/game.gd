extends Control

@onready var dev = $dev
@onready var main = $main
@onready var LabelRULE = $main/LabelRULE
@onready var LabelMAIN = $main/LabelMAIN
@onready var LabelCHOICE = $main/LabelCHOICE


var DS = DialogSystem.new()
var add = false

func _ready() -> void:
	main.add_child(DS)
	
	dev.visible = false
	#main.visible = false
	
	LabelRULE.text = DS.get_text_by_id("rule")
	LabelMAIN.text = "score: " + str(G.score)
	LabelCHOICE.text = DS.get_text_by_id("_clear")
	TextAnimator._typeware(LabelRULE,2)
	TextAnimator._typeware(LabelMAIN,2)
	TextAnimator._typeware(LabelCHOICE,2)

func _physics_process(delta: float) -> void:
	pass
	
func _on_pc_input_connect() -> void:
	game_handler()

func update_text():
	LabelMAIN.text = "score: " + str(int(G.score)) + "\nmultiplayer_1: " + str(snapped(G.multiplayer_1,0.01)) + "\t\t\t\t[COST: " + str(G.cost_multiplayer_1) + "]"
	TextAnimator._typeware(LabelMAIN,0.1)

#only game scene
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_released():
		game_handler()

func game_handler():
	if self.visible != false:
		upgrade()
		score_add()
		update_text()

func upgrade():
	if (G.score - G.cost_multiplayer_1) > 0:
		G.score -= G.cost_multiplayer_1 
		G.multiplayer_1 *= 1.1
		G.cost_multiplayer_1 *= 2

func score_add():
	G.score += 1 * G.multiplayer_1
		
