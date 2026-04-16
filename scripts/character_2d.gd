extends CharacterBody2D

@onready var title_map = get_node("../lvl1")

@export var SPEED = 0.1
var original_SPEED = SPEED
var moving
var move_direction
var original_position = self.position

func _physics_process(delta: float) -> void:
	# Запоминаем направление при нажатии
	if Input.is_anything_pressed():
		var horizontal = Input.get_axis("left", "right")
		var vertical = Input.get_axis("up", "down")
		move_direction = Vector2(horizontal, vertical).normalized()
		moving = true
	
	if moving:
		var motion = move_direction * SPEED * delta
		var collision = move_and_collide(motion)
		check_tilemap()
		if collision:
			moving = false  

func check_tilemap():
	var cell_pos = title_map.local_to_map(global_position)
	var tile_data =  title_map.get_cell_tile_data(cell_pos)
	var custom_value = tile_data.get_custom_data("Finish")
	
	if  tile_data != null and custom_value == true:
		await GTime.delay(0.1)
		self.position = original_position
		
