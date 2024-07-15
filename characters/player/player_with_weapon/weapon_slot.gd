extends Node2D

@export var weapon : Node2D

@onready var origin = $Origin

func _ready():
	if not weapon:
		printerr("WeaponSlot> ERROR: No weapon assigned.")
		get_tree().quit()

func get_origin() -> Marker2D:
	return origin

func assign_weapon(new_weapon: Node2D) -> void:
	self.weapon = new_weapon
	
	# Need to check this later
	new_weapon.global_position = origin.global_position
	
	self.add_child(new_weapon)
