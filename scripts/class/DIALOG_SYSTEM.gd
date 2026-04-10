class_name DialogSystem
extends Node

var path =  "res://text/text_ru.json"
var dialogues_data = []

func _enter_tree() -> void:
	load_dialogues(path)

func load_dialogues(file_path: String):
	# Проверяем, существует ли файл
	if not FileAccess.file_exists(file_path):
		print("Файл не найден: ", file_path)
		return
	
	# Открываем файл
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		print("Не удалось открыть файл: ", file_path)
		return
	
	# Читаем и парсим
	var content = file.get_as_text()
	file.close()
	
	var result = JSON.parse_string(content)
	
	if result == null:
		print("Ошибка парсинга JSON")
		dialogues_data = []
	else:
		dialogues_data = result
		print("Загружено диалогов: ", dialogues_data.size())

func get_text_by_id(id: String) -> String:
	for dialogue in dialogues_data:
		if dialogue.get("id") == id:
			return dialogue.get("text", "")
	return ""  # Если ID не найден
	
