class_name DialogSystem
extends Node


var path = ""
var dialogues_data = []



var _stat = false

func _enter_tree() -> void:
	if OS.get_locale_language() in ["be", "ru"]:
		print(OS.get_locale_language())
		path = "res://text/text_ru.json"
	else:
		path = "res://text/text_en.json"
	
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

# For label - text
func show_dialog(label, dialoge):
	label.text = get_text_by_id(dialoge)
	TextAnimator._typeware(label, 2)
	
# For choice 2 variant + func

func choice(...args):
	_stat = true
	G.choice = ""
	
	while _stat == true:
		if G.choice.is_valid_int() and int(G.choice)-1 < args.size() and int(G.choice)-1 >= 0:
			print(">>> Da")
			args[int(G.choice)-1].call()
			_stat = false
		await GTime.delay(0.1)

#func choice(v1,v2):
	#_stat = true
	#G.choice = ""
	#while _stat != false:
		#match G.choice:
			#"1": 
				#v1.call()
				#_stat = false
			#"2":
				#v2.call()
				#_stat = false
			#_:
				#await  GTime.delay(1)		
