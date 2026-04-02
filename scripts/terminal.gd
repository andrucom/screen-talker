extends Control
@onready var label = $RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Убедитесь, что текст полностью невидим в начале
	label.visible_ratio = 0.0
	# Создаем и запускаем анимацию
	var tween = create_tween()
	# Анимируем свойство visible_ratio от 0 до 1 за 3 секунды
	tween.tween_property(label, "visible_ratio", 1.0, 1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
