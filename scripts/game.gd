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
	LabelMAIN.text = ">>score: " + str(int(G.score)) \
	+ "\n\n\nmultiplayer_1: " \
	+ str(snapped(G.upgrades["multiplayer_1"].value, 0.01)) + "\t\t\t\t[COST: " + str(G.upgrades["multiplayer_1"].cost) + "]" \
	
	+ "\nmultiplayer_2: " \
	+ str(snapped(G.upgrades["multiplayer_2"].value, 0.01)) + "\t\t\t\t[COST: " + str(G.upgrades["multiplayer_2"].cost) + "]" \
	
	+ "\nmultiplayer_3: " \
	+ str(snapped(G.upgrades["multiplayer_3"].value, 0.01)) + "\t\t\t\t[COST: " + str(G.upgrades["multiplayer_3"].cost) + "]"
	
	#TextAnimator._typeware(LabelMAIN,0.1)

#only game scene
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_released():
		game_handler()

func game_handler():
	if self.visible:
		score_add()
		G.upgrade()
		#upgrade(G.multiplayer_1, G.cost_multiplayer_1)
		update_text()

#func upgrade(multiplayer, cost_multiplayer):
	#if (G.score - cost_multiplayer) > 0:
		#G.score -= cost_multiplayer 
		#multiplayer *= 1.1
		#cost_multiplayer *= 2
	#return [multiplayer, cost_multiplayer]

#func upgrade_1():
	#if (G.score - G.cost_multiplayer_1) > 0:
		#G.score -= G.cost_multiplayer_1 
		#G.multiplayer_1 *= 1.1
		#G.cost_multiplayer_1 *= 2

func score_add():
	var mult = 0
	for i in G.upgrades:
		print(">>" + str(G.upgrades[i].value) + "  " + str(i))
		mult += G.upgrades[i].value
	print(mult/G.upgrades.size())

	G.score += 1 * (mult / G.upgrades.size())
		
