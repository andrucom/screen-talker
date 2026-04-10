class_name GTime
extends Node


static func delay(time: float):
	var tree = Engine.get_main_loop()
	if tree:
		await tree.create_timer(time).timeout


#extends Node
#class_name BTime
#
#static func delay_no_await(time: float) -> Timer:
	#var tree = Engine.get_main_loop().current_scene.get_tree()
	#var timer = tree.create_timer(time)
	#return timer
