extends Control
@onready var labelR = $RichTextLabel
@onready var label = $Label
@onready var label2 = $Label2
const VERSION_DATA = preload("res://version.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Убедитесь, что текст полностью невидим в начале
	labelR.visible_ratio = 0.0
	# Создаем и запускаем анимацию
	var tween = create_tween()
	# Анимируем свойство visible_ratio от 0 до 1 за 3 секунды
	tween.tween_property(labelR, "visible_ratio", 1.0, 1.0)
	
	label.text = "VER: " + VERSION_DATA.version

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label2.text = "TIME: " + Time.get_time_string_from_system()
	pass
