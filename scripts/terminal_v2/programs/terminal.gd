extends TerminalProgram

var time = 0.0
var text_input = ""
var terminal_lines = []
var display_lines_max = 0

func on_startup():
	letters.clear()
	letters.write_string(0, 0, "Terminal")
	letters.clear_area(
		0, letters.width, letters.height - 1, letters.height, Color.DARK_BLUE)
	display_lines_max = letters.height - 2

func on_update(delta: float) -> void:
	time += delta
	var wave = sin(time * 3.0)
	if wave > 0.0:
		letters.set_letter(
			0, letters.height - 1, ">", Color.WHITE, Color.DARK_BLUE)
	else:
		letters.set_letter(
			0, letters.height - 1, "|", Color.BLACK, Color.WHITE)

func on_key_press(key: String) -> void:
	print(key)
	if len(key) > 1:
		match key:
			"Backspace":
				text_input = text_input.erase(len(text_input) - 1)
			"Enter":
				terminal_lines.append(text_input)
				letters.clear_area(0, letters.width, 1, letters.height - 2, Color.BLACK)
				var offset = len(terminal_lines) - display_lines_max
				offset = max(0, offset)
				for index in range(offset, len(terminal_lines)):
					letters.write_string_last(
						0,
						1 + index, 
						terminal_lines[index], 
						letters.width - 1
					)
				text_input = ""
	else:
		text_input += key
	
	letters.clear_area(
		1, letters.width, letters.height - 1, letters.height, Color.DARK_BLUE)
	letters.write_string_last(
		1, letters.height - 1, 
			text_input, letters.width - 2, Color.WHITE, Color.DARK_BLUE)
