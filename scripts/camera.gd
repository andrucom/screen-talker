extends Camera3D

@onready var camera := self
@onready var raycast := $RayCast3D


var time = 0

var input_rotation_x = 0.0  
var input_rotation_y = 0.0  
var shake_offset_x = 0.0
var shake_offset_y = 0.0
var mouse_sensitivity = 0.01

@export var shake_power = 0.005
@export var time_fov = 5.0
@export var fov_original = 48
@export var fov_min = 20

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	input_rotation_x = camera.rotation.x
	input_rotation_y = camera.rotation.y

func _physics_process(delta: float) -> void:
	rayfire_screen()



#Следование камеры за мышкой 
func _input(event: InputEvent) -> void:	
	if event.is_action_pressed("use") :
		rayfire()

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

		input_rotation_x = lerp(input_rotation_x, target_x, 0.7)
		input_rotation_y = lerp(input_rotation_y, target_y, 1.0)
		
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

func shake(delta):
	time += delta
	shake_offset_x = sin(time) * shake_power
	shake_offset_y = sin(time) * shake_power

#Лучь для проверки нужного метода
func rayfire_screen():
	if raycast.is_colliding() != false:
		var target_name = raycast.get_collider().get_parent().name
		if target_name in ["screen", "screen window"]:
			camera.set_fov(0.0)
			var tween = create_tween()
			tween.tween_property(camera, "fov", fov_min, time_fov)
			
			#labelR.visible_ratio = 0.0
			#var tween = create_tween()
			#tween.tween_property(labelR, "visible_ratio", 1.0, 1.0)
			
			#camera.set_fov(fov_min)
	else:
		var tween = create_tween()
		tween.tween_property(camera, "fov", fov_original, time_fov)
		pass

func rayfire():
	print("ray: check")
	if raycast.is_colliding() != false:
		var target = raycast.get_collider().get_owner()
		var target_name = raycast.get_collider().get_parent().name
		if target.has_method("interact"):
			target.interact(target_name)
