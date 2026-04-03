class_name TerminalProgram

var letters: TerminalLettersGrid

func initialize(letters: TerminalLettersGrid) -> void:
	self.letters = letters
	startup()

func sleep(time_sec: float):
	var tree = letters.get_tree()
	return tree.create_timer(time_sec).timeout

func startup():
	pass

func update(delta: float) -> void:
	pass

func shutdown() -> void:
	pass
