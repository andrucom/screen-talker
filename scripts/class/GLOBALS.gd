extends Node

var pc_ligh = Color("red")
var dot = false
var choice = ""

var score = 0
#var multiplayer_1 = 1.0
#var cost_multiplayer_1 = 1

#var values = {
	#"multiplayer_1": {"value": 1.0, "cost": 1}
#}

var upgrades = {
	#				Умножитель		Цена		Умножитель умнож	Умножение цены
	"multiplayer_1": {"value": 1.0, "cost": 20, "mult_value": 1.3, "mult_cost":1.3},
	"multiplayer_2": {"value": 1.0, "cost": 100, "mult_value": 4, "mult_cost":2},
	"multiplayer_3": {"value": 1.0, "cost": 1000, "mult_value": 10, "mult_cost":10},
}

func upgrade():
	for upgrade_key in upgrades:
		var upgrade_data = upgrades[upgrade_key]
		
		if (score - upgrade_data.cost) > 0:
			score -= upgrade_data.cost
			upgrade_data.value *= upgrade_data.mult_value
			upgrade_data.cost *= upgrade_data.mult_cost


	#if (G.score - G.cost_multiplayer_1) > 0:
		#G.score -= G.cost_multiplayer_1 
		#G.multiplayer_1 *= 1.1
		#G.cost_multiplayer_1 *= 2
