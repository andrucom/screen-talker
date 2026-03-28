extends Node3D
var pressed_handled = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass
	
	
func _input(event: InputEvent) -> void:
		if event is InputEventKey and event.is_pressed() and not pressed_handled.get(event.keycode,false):
			match event.keycode:
				KEY_W:
						var body = get_node('w')
						body.position -= Vector3(0,0.01,0)
						print(OS.get_keycode_string(event.keycode))
				KEY_Q:
					var body = get_node('q')
					body.position -= Vector3(0,0.01,0)
					print(OS.get_keycode_string(event.keycode))
			pressed_handled[event.keycode] = true

		if event is InputEventKey and event.is_released() and pressed_handled.get(event.keycode,true):
			match event.keycode:
				KEY_W:
						var body = get_node('w')
						body.position += Vector3(0,0.01,0)
						print(OS.get_keycode_string(event.keycode))
				KEY_Q:
					var body = get_node('q')
					body.position += Vector3(0,0.01,0)
					print(OS.get_keycode_string(event.keycode))
			pressed_handled[event.keycode] = false

		#if event is InputEventKey:
			#if event.keycode == KEY_W and event.pres:
				#body.position -= Vector3(0,0.01,0)
			
