extends PlayerBase

signal player_died

@export var weapon_slot: WeaponSlot

func _ready():
	super._ready()
	
	if not weapon_slot:
		printerr("PlayerWithWeapon> ERROR: No weapon slot assigned.")
		get_tree().quit()
		return

func _on_died():
	GlobalData.player = null

	self.set_movement_enabled(false)
	weapon_slot.set_weapon_enabled(false)
	
	animation_player.die_animation()
	await animation_player.animation_finished
	
	player_died.emit()
	self.queue_free()

func _on_hit_box_damage_taken(_amount: float, knockback_taken: Vector2):
	self._knockback = knockback_taken
	self.set_movement_enabled(false)

	weapon_slot.set_weapon_enabled(false)
	
	animation_player.damage_animation()
	await animation_player.animation_finished
	
	self.set_movement_enabled(true)
	weapon_slot.set_weapon_enabled(true)
