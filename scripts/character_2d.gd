extends CharacterBody2D


@export var SPEED = 0.1
var original_SPEED = SPEED
var moving
var move_direction

func _physics_process(delta: float) -> void:
	# Запоминаем направление при нажатии
	if Input:
		var horizontal = Input.get_axis("left", "right")
		var vertical = Input.get_axis("up", "down")
		move_direction = Vector2(horizontal, vertical).normalized()
		moving = true
	
	# Двигаемся пока не столкнемся
	if moving:
		var motion = move_direction * SPEED * delta
		var collision = move_and_collide(motion)
		
		if collision:
			moving = false  # Останавливаемся при столкновении
	
	#var direction := Input.get_axis("left", "right")
	#
	#if direction:
		#print(direction)
		#self.position.x += direction * SPEED
		
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
