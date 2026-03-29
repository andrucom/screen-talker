extends Camera3D

@onready var camera := self


var time = 0
var power = 0.005
var original_rotation_x = 0.0
var original_rotation_y = 0.0

var target_rot_x = 0
var target_rot_y = 0

var mouse_sensitivity = 0.01  # Чувствительность (чем меньше, тем плавнее)

func _ready() -> void:
	original_rotation_x = camera.rotation.x
	original_rotation_y = camera.rotation.y



func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Получаем движение мыши
		var mouse_delta = event.screen_relative

		# Нормализуем движение относительно размера экрана
		var viewport_size = get_viewport().get_visible_rect().size
		var normalized_x = -mouse_delta.x / viewport_size.x
		var normalized_y = -mouse_delta.y / viewport_size.y

		# Рассчитываем целевое вращение (накапливаем, а не ограничиваем)
		target_rot_x = rotation.x + (normalized_y * mouse_sensitivity * 100)
		target_rot_y = rotation.y + (normalized_x * mouse_sensitivity * 100)

		# Опционально: глобальные ограничения, чтобы камера не перевернулась
		target_rot_x = clamp(target_rot_x, -3.5, 3.5)  # ~ -85 до +85 градусов
		target_rot_y = clamp(target_rot_y, -3.14, 3.14)  # полный круг по горизонтали

		# Плавно поворачиваем камеру

		rotation.x = lerp(rotation.x, target_rot_x, 0.6)
		rotation.y = lerp(rotation.y, target_rot_y, 0.6)

func shake(delta):
	time += delta  # Увеличиваем время
	# Мягко покачиваем камеру влево-вправо
	# sin(time) даёт плавное изменение от -1 до 1
	# Умножаем на 0.1, чтобы амплитуда (размах) была небольшой
	camera.rotation.x =  original_rotation_x + sin(time) * power
	camera.rotation.y =  original_rotation_y + sin(time) * power


	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	shake(delta)
	pass
