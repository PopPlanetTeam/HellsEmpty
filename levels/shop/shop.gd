extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerInventory.coins_amount += 2000
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("save"):
		PlayerInventorySaverLoader.new().save_scene()
