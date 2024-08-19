extends Node2D
class_name WeaponContainer

var locked: bool = true
@export var price : int = 1000

# Reference to the weapon child
@onready var weapon: WeaponBase = null

func _ready():
	set_process_input(false)
	var weapon_base_object_filter_lambda = func (obj): return obj is WeaponBase 
	var weapon_base_children = get_children().filter(weapon_base_object_filter_lambda) as Array[WeaponBase]
	
	if weapon_base_children.size() == 0:
		push_error("No weapon as child found")
		return
	elif weapon_base_children.size() > 1:
		push_error("Multiple weapons as child found")
	
	weapon = weapon_base_children[0]
	disable_input_for_wapon()

func disable_input_for_wapon() -> void:
	weapon.set_process_input(false)

func enable_input_for_wapon() -> void:
	weapon.set_process_input(true)

func set_locked(value: bool):
	locked = value

func _input(event):
	if event.is_action_pressed("select"):
		var buy_weapon = buy()
		if !buy_weapon:
			print("Cannot buy weapon now")
		else:
			print("Weapon added to inventory sucessfully")

func buy() -> bool:
	if PlayerInventory.coins_amount >= price:
		PlayerInventory.coins_amount -= price
		PlayerInventory.unlocked_weapons.append(weapon)
		return true
	return false

func get_weapon() -> WeaponBase:
	var weapon_to_return = null
	if not locked:
		weapon_to_return = weapon
	return weapon_to_return

func _on_area_2d_area_entered(area):
	set_process_input(true)
	enable_input_for_wapon()

func _on_area_2d_area_exited(area):
	set_process_input(false)
	var event = InputEventAction.new()
	event.action = "shoot"
	event.pressed = false
	weapon._input(event)
	disable_input_for_wapon()
