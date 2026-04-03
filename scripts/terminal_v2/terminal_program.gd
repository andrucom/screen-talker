class_name TerminalProgram

var letters: TerminalLettersGrid
var process_id: int

signal request_launch_program_sent(program_name)
signal request_kill_program_sent(process_id)

func initialize(letters: TerminalLettersGrid, process_id: int) -> void:
	self.letters = letters
	self.process_id = process_id
	on_startup()

func sleep(time_sec: float):
	var tree = letters.get_tree()
	return tree.create_timer(time_sec).timeout

func on_startup():
	pass

func on_update(delta: float) -> void:
	pass

func on_shutdown() -> void:
	pass

func on_key_press(key: String) -> void:
	pass

func run_program(program_name) -> void:
	emit_signal("request_launch_program_sent", program_name)

func kill_program(pid) -> void:
	emit_signal("request_kill_program_sent", pid)

func kill_self() -> void:
	kill_program(process_id)
