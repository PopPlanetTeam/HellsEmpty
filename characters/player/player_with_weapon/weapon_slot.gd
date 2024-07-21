extends Node2D
class_name WeaponSlot

@export var weapon : Node2D

# A Origem dentro do Weapon Slot demarca onde a arma será alinhada com o braço do Devil.
# Cada arma deverá ter um Marker2D que será a GunOrigin. Essa GunOrigin será a referência para a posição da arma.
@onready var origin = $Origin

func _ready():
	if not weapon:
		print("WeaponSlot> Warning: No weapon assigned.")

func get_origin() -> Marker2D:
	return origin

func has_weapon() -> bool:
	return weapon != null

func assign_weapon(new_weapon: Node2D) -> void:
	if weapon:
		weapon.queue_free()

	self.weapon = new_weapon
	new_weapon.global_position = origin.global_position - new_weapon.get_origin().global_position
	
	self.add_child(new_weapon)
