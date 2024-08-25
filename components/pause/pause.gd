extends CanvasLayer
class_name Pause

@onready var buttons_container = $ButtonsContainer
@onready var paused_label = $Paused

func _ready():
	self.visible = false
	paused_label.text = tr("PAUSED")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var pause = get_tree().paused
		get_tree().paused = !pause
		self.visible = !pause
