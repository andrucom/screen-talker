extends CharacterBody2D


@onready var particles = $CPUParticles2D
@onready var particles_win = get_node("../WIN")
@onready var labelLVL = get_node("../LabelLVL")
@onready var labelALL = get_node("../LabelALL")

@export var test_game = false
@export var SPEED = 0.1

var original_SPEED = SPEED
var moving
var move_direction

var lvltext 

var location
var original_position = self.position
var original_location 

func _ready() -> void:
	G.game = test_game
	location = get_node("../lvl1")
	original_location = location
	labelALL.text =  "/ " + str(lvl_counter()-1)


func _physics_process(delta: float) -> void:
	# Запоминаем направление при нажатии
	if Input.is_anything_pressed() and G.game == true and moving != true:
		var horizontal = Input.get_axis("left", "right")
		var vertical = Input.get_axis("up", "down")
		move_direction = Vector2(horizontal, vertical).normalized()
		moving = true
	
	if moving:
		var motion = move_direction * SPEED * delta
		var collision = move_and_collide(motion)
		check_tilemap()
		if collision:
			particles.emitting = true
			moving = false  

func check_tilemap():
	var cell_pos = location.local_to_map(global_position)
	var tile_data =  location.get_cell_tile_data(cell_pos)
	var custom_value
	
	if tile_data != null:
		custom_value = tile_data.get_custom_data("Finish")
	
	if  tile_data != null and custom_value == true:
		particles_win.position = self.position
		particles_win.emitting = true
		
		await GTime.delay(0.1)
		self.position = original_position
		next_lvl()
		
func next_lvl():
	moving = false
	if  G.lvl < lvl_counter():
		
		original_location = location

		var nname = "../lvl" + str(G.lvl)
		labelLVL.text = str(G.lvl)
		location = get_node(str(nname))
		
		G.lvl_visible(original_location, false)
		G.lvl_visible(location, true)
		
		await  GTime.delay(0.1)
		G.lvl += 1

func lvl_counter():
	var count = 0
	for i in range(1,100):
		var n_name = "../lvl" + str(i)
		var n_location = get_node(str(n_name))
		
		if n_location != null: 
			count += 1
		else:
			break
	return count+1
	
	

	
