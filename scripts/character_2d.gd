extends CharacterBody2D


@onready var particles = $CPUParticles2D
@onready var particles_dead = $DEAD
@onready var particles_win = get_node("../WIN")
@onready var labelLVL = get_node("../LabelLVL")
@onready var labelALL = get_node("../LabelALL")

@export var SPEED = 2300

var stop_timer = 0.0
var STOP_DELAY = 0.25

var original_SPEED = SPEED
var moving = false
var move_direction

var location
var original_position = self.position
var original_location 


func _ready() -> void:
	#G.game
	#moving
	
	location = get_node("../lvl1")
	original_location = location
	labelALL.text =  "/ " + str(lvl_counter())


func _physics_process(delta: float) -> void:

	if Input.is_action_just_released("skip_lvl") and G.game:
		next_lvl()
	
	if G.game == true:
		if Input.is_anything_pressed() and moving != true:
			var horizontal = Input.get_axis("left", "right")
			var vertical = Input.get_axis("up", "down")
			move_direction = Vector2(horizontal, vertical).normalized()
			moving = true
			stop_timer = 0.0
			$Sprite2D.scale.y = 1
	
	if velocity.length() == 0 and moving:
		stop_timer += delta
		if stop_timer >= STOP_DELAY:
			$Sprite2D.scale.y = 1.77
			moving = false
			stop_timer = 0.0
	else:
		stop_timer = 0.0
	
	if moving:
		var motion = move_direction * SPEED * delta
		var collision = move_and_collide(motion)
		check_tilemap()
	
		if collision:
			particles.emitting = true
			moving = false
			$Sprite2D.scale.y = 1.77


func check_tilemap():
	var cell_pos = location.local_to_map(global_position)
	var tile_data =  location.get_cell_tile_data(cell_pos)
	var custom_value
	var custom_value_2
	
	if tile_data != null:
		custom_value = tile_data.get_custom_data("Finish")
		custom_value_2 = tile_data.get_custom_data("Damage")
		if  tile_data != null and custom_value_2 == true:
			await GTime.delay(0.02)
			particles_dead.emitting = true
			self.position = original_position
			custom_value = null
			
		if  tile_data != null and custom_value == true:
			particles_win.position = self.position
			particles_win.emitting = true
			next_lvl()

		
		
func next_lvl():
	self.position = original_position
	if  G.lvl < lvl_counter():
		print("PING" + str(G.lvl))
		G.lvl += 1
		moving = false
		
		original_location = location
		var nname = "../lvl" + str(G.lvl)
		labelLVL.text = str(G.lvl)
		location = get_node(str(nname))
		
		print(">>>", G.lvl)
		print(">>", original_location)
		print(">", location)
		
		await get_tree().process_frame
		G.lvl_visible(original_location, false)
		G.lvl_visible(location, true)
	
	else:
		self.position = original_position
		G.game = false
		G.end_game = true
		

func lvl_counter():
	var count = 0
	for i in range(1,100):
		var n_name = "../lvl" + str(i)
		var n_location = get_node(str(n_name))
		
		if n_location != null: 
			count += 1
		else:
			break
	return count
	
	

	
