extends Node2D
class_name WeaponContainer

var locked: bool = true
@export var price : int = 1000
@export var scene_path : PackedScene = null

# Reference to the weapon child
@onready var weapon: WeaponBase = null

@onready var price_label : Label = $PriceLabel

signal weapon_selected (w:WeaponBase)

func _ready():
	set_process_input(false)
	
	if scene_path != null:
		weapon = scene_path.instantiate()
		add_child(weapon)
		disable_input_for_wapon()

func handle_lock_weapon():
	locked = not check_weapon_is_in_inventory()
	
	if locked:
		weapon.modulate = Color.CHOCOLATE
	else:
		weapon.modulate = Color.WHITE
		
	if !price_label:
		return
		
	if locked:
		price_label.text = str(self.price)
	else:
		price_label.queue_free()

func check_weapon_is_in_inventory() -> bool:
	return PlayerInventory.unlocked_weapons \
		.any(func(a:PackedScene) : return a.resource_path == scene_path.resource_path)

func disable_input_for_wapon() -> void:
	weapon.set_process_input(false)

func enable_input_for_wapon() -> void:
	weapon.set_process_input(true)

func set_locked(value: bool):
	locked = value

func _input(event):
	if event.is_action_pressed("ui_select"):
		if locked:
			var buy_weapon = buy()
			if !buy_weapon:
				print("Cannot buy weapon now")
			else:
				print("Weapon added to inventory sucessfully")
				#queue_free()
				weapon.modulate = Color.WHITE
				self.locked = false
				handle_lock_weapon()
				select_weapon()
		else:
			select_weapon()
			

func select_weapon() -> void:
	weapon_selected.emit(weapon)
	
func buy() -> bool:	
	if PlayerInventory.unlocked_weapons.any(func (w): return w.resource_path == scene_path.resource_path):
		return false
		
	if PlayerInventory.coins_amount >= price:
		PlayerInventory.coins_amount -= price
		PlayerInventory.unlocked_weapons.append(scene_path)
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
