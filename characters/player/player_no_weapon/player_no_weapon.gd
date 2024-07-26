extends PlayerBase


func _on_picker_area_entered(area):
	var parent_obj = area.get_parent()

	if parent_obj is WeaponPick:
		var weapon: PackedScene = parent_obj.get_weapon()
		if weapon:
			print("PlayerNoWeapon> Picked up weapon: ", weapon)
			
			var weapon_instance = weapon.instantiate()
			var player_with_weapon = GlobalData.player_with_weapon_scene.instantiate()

			# Delete weapon pick
			parent_obj.queue_free()

			# Add player with weapon to the scene
			self.get_parent().call_deferred("add_child", player_with_weapon)
			await player_with_weapon.ready
			
			# Move camera to player with weapon
			self.get_node("Camera2D").reparent(player_with_weapon)
			
			print("OI")
			
			# Set player with weapon position, scale and assign weapon
			player_with_weapon.set_position(self.get_position())
			player_with_weapon.set_scale(self.get_scale())
			player_with_weapon.weapon_slot.assign_weapon(weapon_instance)

			print("PlayerNoWeapon> Switching to player with weapon")

			# Delete player without weapon
			self.queue_free()
			return
