extends Node2D
class_name WeaponContainer

var locked: bool = true

# Reference to the weapon child
@onready var weapon: WeaponBase = null

func _ready():
	var weapon_base_object_filter_lambda = func (obj): return obj is WeaponBase 
	var weapon_base_children = get_children().filter(weapon_base_object_filter_lambda) as Array[WeaponBase]
	
	if weapon_base_children.size() == 0:
		push_error("No weapon as child found")
		return
	elif weapon_base_children.size() > 1:
		push_error("Multiple weapons as child found")
	
	weapon = weapon_base_children[0]

func set_locked(value: bool):
	locked = value

func get_weapon() -> WeaponBase:
	var weapon_to_return = null
	if not locked:
		weapon_to_return = weapon
	return weapon_to_return
