extends Node

var pc_ligh = Color("red")
var dot = false
var choice = ""

var game = false
var end_game = false
var end_dialoge = false

var lvl = 1

var Volume = 0

static func lvl_visible(path, state):
	path.visible = state
	path.collision_enabled = state
