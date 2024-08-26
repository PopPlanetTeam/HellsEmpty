extends CanvasLayer
class_name Pause

@onready var paused_label = $Paused
@onready var coins_label = $Coins

func _ready():
	self.visible = false
	paused_label.text = tr("PAUSED")
	coins_label.text = tr("COINS") + ": " + str(PlayerInventory.coins_amount)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		coins_label.text = tr("COINS") + ": " + str(PlayerInventory.coins_amount)
		var pause = get_tree().paused
		get_tree().paused = !pause
		self.visible = !pause
