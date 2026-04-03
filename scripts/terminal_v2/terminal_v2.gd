extends Node

const PROGRAMS_PATH = "res://scripts/terminal_v2/programs/"

var letters_grid: TerminalLettersGrid
var programs = []

func run_program(program_name) -> bool:
	var path = PROGRAMS_PATH + program_name + ".gd"
	if not ResourceLoader.exists(path):
		return false
	
	var script = load(path)
	var program_instance: = script.new() as TerminalProgram
	if not program_instance:
		return false
	program_instance.initialize(letters_grid)
	
	return true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	letters_grid = $TerminalLetterGrid
	run_program("bootloader")
