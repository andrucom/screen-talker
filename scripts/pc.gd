extends Node3D
@onready var audio_pc = $audio_pc
@onready var audio = $audio_keyboard
@onready var pc_light = $power_light

var pressed_handled = {}
const push_power = 0.005
var sound = preload("res://sounds/button.mp3")
var sound_space = preload("res://sounds/space.mp3")
var sound_enter = preload("res://sounds/enter.mp3")

var pc_start = preload("res://sounds/pc_start.mp3")
var pc_work = preload("res://sounds/pc_work.mp3")

var power = false
signal input_connect()

func _process(delta: float) -> void:
	await GTime.delay(1)
	$power_light.light_color = G.pc_ligh

func _ready() -> void:
	_init_screen()
	
	await GTime.delay(4)
	audio_pc.stream = pc_start
	audio_pc.play()
	await audio_pc.finished
	audio_pc.stream = pc_work
	audio_pc.stream.loop = true
	audio_pc.play()
	
	#var game = $SubViewport/CanvasLayer/Terminal/Game
	#game.input_connect.connect()
	

func _input(event: InputEvent) -> void:
	# Push button
	if event is InputEventKey and event.is_pressed() and not pressed_handled.get(event.keycode,false):
		print("key: ", OS.get_keycode_string(event.keycode).to_lower())
		push_button(OS.get_keycode_string(event.keycode).to_lower())
		pressed_handled[event.keycode] = true
	
	# Unpush button
	if event is InputEventKey and event.is_released() and pressed_handled.get(event.keycode,true):
		unpush_button(OS.get_keycode_string(event.keycode).to_lower())
		pressed_handled[event.keycode] = false
		input_connect.emit()
	
	# Global choice
	if event is InputEventJoypadButton and event.is_pressed():
		if event.is_action_pressed("choice_1"):
			G.choice = "1"
		elif event.is_action_pressed("choice_2"):
			G.choice = "2"
	
	if event is InputEventKey and event.is_pressed():
		G.choice = OS.get_keycode_string(event.keycode).to_lower()
	
# функция вкл/выкл - пока не нужно
#func interact(name):
	#if name == "comp_button":
		#power = !power
		#if power == true:
			#$pc_light.light_color = Color.GREEN
			#G.pc_ligh = Color.GREEN
		#else:
			#$pc_light.light_color = Color.RED
			#G.pc_ligh = Color.RED

#--------------------#
# Функции для самого процесса нажатия и отжатия 

func _init_screen():
	var viewport = $SubViewport
	viewport.set_update_mode(SubViewport.CLEAR_MODE_ONCE)
	
	var material: = StandardMaterial3D.new()
	material.albedo_texture = viewport.get_texture()
	material.emission_enabled = true
	material.emission_texture = viewport.get_texture()
	material.emission_operator = BaseMaterial3D.EMISSION_OP_MULTIPLY
	material.emission = Color.WHITE
	material.emission_intensity = 2.0;
	material.emission_energy_multiplier = 2.0;
	get_node("screen").material_override = material
	
func push_button(node: String):
	if get_node(node) != null:
		if node == "space":
			audio.stream = sound_space
			audio.pitch_scale = randf_range(1,1.2)
			audio.volume_db = -35
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
