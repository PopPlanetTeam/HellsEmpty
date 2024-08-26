extends Control

@onready var label = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerInventory.coins_amount += 10000
	label.text = tr("WON_TEXT")
	PlayerInventorySaverLoader.new().save_scene()
