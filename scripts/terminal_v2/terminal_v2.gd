extends Node

const PROGRAMS_PATH = "res://scripts/terminal_v2/programs/"

var letters_grid: TerminalLettersGrid
var programs = []

func program_request_kill(process_id):
	var program: = programs[process_id] as TerminalProgram
	program.on_shutdown()
	programs.remove_at(process_id)
	
	var index = 0
	for old_program in programs:
		old_program.process_id = index
		index += 1

func program_request_launch(program_name):
	run_program(program_name)

func run_program(program_name) -> bool:
	var path = PROGRAMS_PATH + program_name + ".gd"
	if not ResourceLoader.exists(path):
		return false
	
	var script = load(path)
	var program_instance: = script.new() as TerminalProgram
	if not program_instance:
		return false
	
	program_instance.request_kill_program_sent.connect(program_request_kill)
	program_instance.request_launch_program_sent.connect(program_request_launch)
	program_instance.initialize(letters_grid, len(programs))
	programs.append(program_instance)
	
	return true

func init_terminal():
	letters_grid = $TerminalLetterGrid
	run_program("bootloader")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("init_terminal")

func _process(delta: float) -> void:
	for program in programs:
		program.on_update(delta)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and (event.pressed or event.echo):
		var key_text = get_key_text(event)
		for program in programs:
			program.on_key_press(key_text)
		# For testing:
		# print("Key pressed: ", key_text)

func get_key_text(event: InputEventKey) -> String:
	# Handle special keys first
	match event.keycode:
		KEY_BACKSPACE:
			return "Backspace"
		KEY_SPACE:
			return " "
		KEY_UP:
			return "ArrowUp"
		KEY_DOWN:
			return "ArrowDown"
		KEY_LEFT:
			return "ArrowLeft"
		KEY_RIGHT:
			return "ArrowRight"
	
	# For letters, numbers, symbols — use unicode with shift state
	if event.unicode != 0:
		# Unicode gives us the actual character respecting layout and shift
		var char = char(event.unicode)
		
		# For letters, handle shift manually if needed (unicode already includes shift)
		# But for consistent formatting: if shift is held, return uppercase, else lowercase
		if char.is_valid_unicode_identifier():
			if event.shift_pressed:
				return char.to_upper()
			else:
				return char.to_lower()
		return char
	
	# Fallback: use keycode for keys without unicode (like F-keys if needed)
	return keycode_to_string(event.keycode)

func keycode_to_string(keycode: Key) -> String:
	# Custom mapping for any non-unicode keys
	var key_names = {
		KEY_TAB: "Tab",
		KEY_ENTER: "Enter",
		KEY_ESCAPE: "Escape",
		# Add others as needed
	}
	return key_names.get(keycode, "Unknown")
