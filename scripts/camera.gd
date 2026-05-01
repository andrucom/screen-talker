extends Camera3D

@onready var camera := self
@onready var raycast := $RayCast3D


var time = 0

var input_rotation_x = 0.0  
var input_rotation_y = 0.0  
var shake_offset_x = 0.0
var shake_offset_y = 0.0
var mouse_sensitivity = 0.006
var current_tween: Tween

@onready var light_right: SpotLight3D = get_node("../WorldEnvironment/SpotLight3D")
@onready var light_left: SpotLight3D = get_node("../WorldEnvironment/SpotLight3D2")

@export var shake_power = 0.005
@export var time_fov = 5.0
@export var fov_original = 48
@export var fov_min = 20
@export var time_unfov = 8

var music_end = preload("res://sounds/music/When-You-Die.mp3")
var sound_dead = preload("res://sounds/dead.mp3")
var sound = preload("res://sounds/music/Prison.mp3")
@onready var audio = $audio_main

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	input_rotation_x = camera.rotation.x
	input_rotation_y = camera.rotation.y
	
	camera.fov = fov_original
	
	await GTime.delay(5)
	audio.play()
	audio.stream.loop = true

func _physics_process(delta: float) -> void:
	rayfire_screen()
	$CanvasLayer/Dot.visible = G.dot

#Следование камеры за мышкой 
func _input(event: InputEvent) -> void:	
	if event is InputEvent:
		if event.is_action("volume_up"):
			G.Volume = clamp(G.Volume + 1 , -25, 20)
			var bus = AudioServer.get_bus_index("Master")
			AudioServer.set_bus_volume_db(bus,G.Volume)
			
		if event.is_action("volume_down"):
			G.Volume = clamp(G.Volume - 1 , -25, 20)
			var bus = AudioServer.get_bus_index("Master")
			AudioServer.set_bus_volume_db(bus,G.Volume)
			
		if event.is_action_pressed("screan_mode"):
				print(">><><><")
				var current_mode = DisplayServer.window_get_mode()
				if current_mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
				else:
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		if event.is_action("focus"):
			var tween = create_tween()
			var duration = 0.3
			tween.set_parallel(true)
			tween.tween_property(camera, "input_rotation_x",-0.091, duration)
			tween.tween_property(camera, "input_rotation_y",0.007, duration)
			
			await  GTime.delay(duration+0.1)
			tween.kill()
			
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			for i in range(50):
				await GTime.delay(0.001)
				camera.fov = clamp(camera.fov-0.05, fov_min, fov_original)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			for i in range(50):
				await GTime.delay(0.001)
				camera.fov = clamp(camera.fov+0.05, fov_min, fov_original)

	if event is InputEventJoypadMotion:
		if event.axis == JOY_AXIS_TRIGGER_RIGHT:
			for i in range(50):
				await GTime.delay(0.001)
				camera.fov = clamp(camera.fov-0.05, fov_min, fov_original)
		if event.axis == JOY_AXIS_TRIGGER_LEFT:
			for i in range(50):
				await GTime.delay(0.001)
				camera.fov = clamp(camera.fov+0.05, fov_min, fov_original)				

			
			#input_rotation_x = -0.091
			#input_rotation_y = 0.007
	
	if event.is_action_pressed("use"):
		rayfire()

	if event is InputEventJoypadMotion:
		
		if event.axis == JOY_AXIS_RIGHT_X:
			var stick_x = event.axis_value
			var target_y = input_rotation_y + (stick_x * mouse_sensitivity * 100)
			var dead_zone = 0.1
			if abs(stick_x) < dead_zone: stick_x = 0.0
			target_y = clamp(-target_y, -0.5, 0.5)
			input_rotation_y = lerp(input_rotation_y, target_y, 0.5)

		elif event.axis == JOY_AXIS_RIGHT_Y:
			var stick_y = event.axis_value
			var target_x = input_rotation_x + (stick_y * mouse_sensitivity * 100)
			var dead_zone = 0.1
			if abs(stick_y) < dead_zone: stick_y = 0.0
			target_x = clamp(-target_x, -0.5, 0.5)
			input_rotation_x = lerp(input_rotation_x, target_x, 0.5)

	if event is InputEventMouseMotion:
		var mouse_delta = event.screen_relative
		var viewport_size = get_viewport().get_visible_rect().size
		var normalized_x = -mouse_delta.x / viewport_size.x
		var normalized_y = -mouse_delta.y / viewport_size.y

		# ИЗМЕНЕНО: работаем с input_rotation, а не с rotation
		var target_x = input_rotation_x + (normalized_y * mouse_sensitivity * 100)
		var target_y = input_rotation_y + (normalized_x * mouse_sensitivity * 100)

		target_x = clamp(target_x, -0.5, 0.5)
		target_y = clamp(target_y, -0.5, 0.5)

		input_rotation_x = lerp(input_rotation_x, target_x, 0.5)
		input_rotation_y = lerp(input_rotation_y, target_y, 0.5)
		
		# Это фикс для Linux Wayland.
		# https://github.com/godotengine/godot/issues/80008
		# На данный момент, в версии 4.6.1 присутствует баг, при котором
		# Input.MOUSE_MODE_CAPTURED не ограничивает положение курсора
		# внутри окна, из-за чего приходится вручную это делать, что бы
		# курсор не "выпрыгивал" из окна.
		# Да-да, platform-specific фиксы так рано в рамках разработки.
		# ---
		# Есть, правда, проблема - это фикс для Linux в целом.
		# При вызове DisplayServer.get_name() - у меня выдаёт X11,
		# хотя я точно уверен, что у меня используется Wayland...
		# Надо будет это дополнительно проверить.
		# By Dadaskis
		if OS.get_name() == "Linux":
			Input.warp_mouse(-mouse_delta)

func _process(delta: float) -> void:
	shake(delta)
	# Суммируем вращение от мыши и тряску
	camera.rotation.x = input_rotation_x + shake_offset_x
	camera.rotation.y = input_rotation_y + shake_offset_y
	end_game()
	
func end_game():
	if G.end_exit:
		G.end_exit = false
		light_right.visible = false
		light_left.light_color = Color.RED
		G.dot = false
		
		audio.stream = music_end
		audio.play()
		
		await audio.finished
		GTime.delay(1)
		get_tree().quit()

func shake(delta):
	time += delta
	shake_offset_x = sin(time) * shake_power
	shake_offset_y = sin(time) * shake_power

#Лучь для проверки нужного метода
func rayfire_screen():
	if current_tween != null:
		current_tween.kill()
	if raycast.is_colliding() != false:
		var target_name = raycast.get_collider().get_parent().name
		if target_name in ["screen", "screen window"]:
			current_tween = create_tween()
			current_tween.tween_property(camera, "fov", fov_min, time_fov)
	else:
		current_tween = create_tween()
		current_tween.tween_property(camera, "fov", fov_original, time_unfov)

func rayfire():
	print("ray: check")
	if raycast.is_colliding() != false:
		var target = raycast.get_collider().get_owner()
		var target_name = raycast.get_collider().get_parent().name
		if target.has_method("interact"):
			target.interact(target_name)
