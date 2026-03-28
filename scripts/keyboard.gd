extends Node3D
var pressed_handled = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

#--------------------#
# Функции для самого процесса нажатия и отжатия 
func push_button(node: String):
	if get_node(node) != null:
		var body = get_node(node)
		body.position -= Vector3(0,0.01,0)
	
func unpush_button(node: String):
	if get_node(node) != null:
		var body = get_node(node)
		body.position += Vector3(0,0.01,0)
		
		
# Нажатие и отжатие кнопок на клавиатуре. !На 3д модели должны совпадать keycode с названием мешей
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not pressed_handled.get(event.keycode,false):
		push_button(OS.get_keycode_string(event.keycode).to_lower())
		pressed_handled[event.keycode] = true
		
	if event is InputEventKey and event.is_released() and pressed_handled.get(event.keycode,true):
		unpush_button(OS.get_keycode_string(event.keycode).to_lower())
		pressed_handled[event.keycode] = false


		#if event is InputEventKey:
			#if event.keycode == KEY_W and event.pres:
				#body.position -= Vector3(0,0.01,0)
			
