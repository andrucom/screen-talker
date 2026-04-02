extends Node3D
@onready var audio = $audio_pc

var pressed_handled = {}
var push_power = 0.005
var sound = preload("res://sounds/button.mp3")
var sound_space = preload("res://sounds/space.mp3")
var sound_enter = preload("res://sounds/enter.mp3")

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
		if node == "space":
			audio.stream = sound_space
			audio.pitch_scale = randf_range(1,1.2)
			audio.volume_db = -20
			audio.play()
		elif node == "enter":
			audio.stream = sound_enter
			audio.pitch_scale = randf_range(1,1.2)
			audio.volume_db = -30
			audio.play()
		else:
			audio.stream = sound
			audio.pitch_scale = randf_range(0.9,1.3)
			audio.volume_db = 0
			audio.play()
		
		var body = get_node(node)
		body.position -= Vector3(0,push_power,0)
	
func unpush_button(node: String):
	if get_node(node) != null:
		var body = get_node(node)
		body.position += Vector3(0,push_power,0)
		
		
# Нажатие и отжатие кнопок на клавиатуре. !На 3д модели должны совпадать keycode с названием мешей
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not pressed_handled.get(event.keycode,false):
		print(OS.get_keycode_string(event.keycode).to_lower())
		push_button(OS.get_keycode_string(event.keycode).to_lower())
		pressed_handled[event.keycode] = true
		
	if event is InputEventKey and event.is_released() and pressed_handled.get(event.keycode,true):
		unpush_button(OS.get_keycode_string(event.keycode).to_lower())
		pressed_handled[event.keycode] = false


		#if event is InputEventKey:
			#if event.keycode == KEY_W and event.pres:
				#body.position -= Vector3(0,0.01,0)
			
