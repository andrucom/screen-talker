@tool

class_name TerminalLettersGrid

extends GridContainer

@export var width: = 0: 
	set(value):
		width = value
		if Engine.is_editor_hint():
			update_grid()

@export var height: = 0: 
	set(value):
		height = value
		if Engine.is_editor_hint():
			update_grid()

func update_grid():
	var preset = get_node("_PRESET")
	preset.visible = true
	
	for child in get_children():
		if child == preset:
			continue
		remove_child(child)
		child.queue_free()
	
	columns = width
	for y in range(height):
		for x in range(width):
			var dupe = preset.duplicate()
			dupe.name = str(x) + "_" + str(y)
			
			dupe.get_child(0).color = Color.BLACK
			dupe.get_child(1).text = " "
			
			add_child(dupe)
	
	preset.visible = false

func set_letter(
	x: int, 
	y: int, 
	letter: String, 
	color: = Color.WHITE, 
	color_background: = Color.BLACK
):
	if x < 0 or x >= width:
		return
	if y < 0 or y >= height:
		return
	
	if len(letter) == 0:
		letter = " "
	letter = letter[0]
	
	var rect = get_node(str(x) + "_" + str(y))
	if not rect:
		return
	
	var background_color: = rect.get_child(0) as ColorRect
	background_color.color = color_background
	
	var letter_label: = rect.get_child(1) as Label
	letter_label.self_modulate = color
	letter_label.text = letter

func get_letter_char(x: int, y: int) -> String:
	if x < 0 or x >= width:
		return " "
	if y < 0 or y >= height:
		return " "
	
	var rect = get_node(str(x) + "_" + str(y))
	if not rect:
		return " "
	
	var letter_label: = rect.get_child(1) as Label
	return letter_label.text

func get_letter_color(x: int, y: int) -> Color:
	if x < 0 or x >= width:
		return Color.BLACK
	if y < 0 or y >= height:
		return Color.BLACK
	
	var rect = get_node(str(x) + "_" + str(y))
	if not rect:
		return Color.BLACK
	
	var letter_label: = rect.get_child(1) as Label
	return letter_label.self_modulate

func get_letter_background_color(x: int, y: int) -> Color:
	if x < 0 or x >= width:
		return Color.BLACK
	if y < 0 or y >= height:
		return Color.BLACK
	
	var rect = get_node(str(x) + "_" + str(y))
	if not rect:
		return Color.BLACK
	
	var background_color: = rect.get_child(0) as ColorRect
	return background_color.color

func write_string(
	x: int,
	y: int,
	text: String,
	color: = Color.WHITE,
	color_background: = Color.BLACK
):
	for index in range(len(text)):
		set_letter(x + index, y, text[index], color, color_background)

func clear(color_background: = Color.BLACK):
	for x in range(width):
		for y in range(height):
			set_letter(x, y, " ", Color.WHITE, color_background)

func clear_area(
		x_start: int, x_end: int, 
			y_start: int, y_end: int, color: = Color.BLACK):
	for x in range(x_start, x_end):
		for y in range(y_start, y_end):
			set_letter(x, y, " ", Color.WHITE, color)

func _ready() -> void:
	if not Engine.is_editor_hint():
		update_grid()
