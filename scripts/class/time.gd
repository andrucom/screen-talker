extends Node

func delay(time: float):
	await get_tree().create_timer(time).timeout


#extends Node
#class_name BTime
#
#static func delay_no_await(time: float) -> Timer:
	#var tree = Engine.get_main_loop().current_scene.get_tree()
	#var timer = tree.create_timer(time)
	#return timer
