extends Node3D
var pressed_handled = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass
	
	
func push_button(node: String):
	var body = get_node(node)
	body.position -= Vector3(0,0.01,0)

func unpush_button(node: String):
	var body = get_node(node)
	body.position += Vector3(0,0.01,0)

func _input(event: InputEvent) -> void:
		if event is InputEventKey and event.is_pressed() and not pressed_handled.get(event.keycode,false):
			match event.keycode:
				KEY_W:
					push_button("w")
				KEY_Q:
					push_button("q")
				KEY_E:
					push_button("e")
				
				KEY_A:
					push_button("a")
				KEY_S:
					push_button("s")
				KEY_D:
					push_button("d")

				KEY_Z:
					push_button("z")
				KEY_X:
					push_button("x")
				KEY_C:
					push_button("c")
			pressed_handled[event.keycode] = true

		if event is InputEventKey and event.is_released() and pressed_handled.get(event.keycode,true):
			match event.keycode:
				KEY_W:
					unpush_button("w")
				KEY_Q:
					unpush_button("q")
				KEY_E:
					unpush_button("e")
				
				KEY_A:
					unpush_button("a")
				KEY_S:
					unpush_button("s")
				KEY_D:
					unpush_button("d")

				KEY_Z:
					unpush_button("z")
				KEY_X:
					unpush_button("x")
				KEY_C:
					unpush_button("c")
			pressed_handled[event.keycode] = false

		#if event is InputEventKey:
			#if event.keycode == KEY_W and event.pres:
				#body.position -= Vector3(0,0.01,0)
			
