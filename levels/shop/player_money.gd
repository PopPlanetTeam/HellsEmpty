extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text = tr("COINS") + ": " + str(PlayerInventory.coins_amount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.text = tr("COINS") + ": " + str(PlayerInventory.coins_amount)
