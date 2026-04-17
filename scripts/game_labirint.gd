extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lvl_init()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func lvl_init():
	for i in range(2,100):
		var n_name = "lvl" + str(i)
		var n_location = get_node(str(n_name))
		if n_location != null: 
			G.lvl_visible(n_location,false)
		else:
			break

	
