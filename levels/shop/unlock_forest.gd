extends Node2D

@export var souls_needed : int = 200
@onready var souls_collected : int = GlobalData.total_enemies_killed

@onready var counter = $Counter

func _ready() -> void:
	counter.text = str("UNLOCK FOREST MAP\n" + str(souls_collected) + "/" + str(souls_needed) + " SOULS")
	
	if check_unlocked():
		Shop.forest_unlocked = true
		self.queue_free()	

func check_unlocked() -> bool:
	return souls_collected >= souls_needed
