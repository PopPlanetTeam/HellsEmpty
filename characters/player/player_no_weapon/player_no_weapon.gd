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

			GlobalData.player = player_with_weapon
			
			# Set player with weapon position, scale and assign weapon
			player_with_weapon.global_position = self.global_position
			player_with_weapon.set_scale(self.get_scale())
			player_with_weapon.weapon_slot.assign_weapon(weapon_instance)

			print("PlayerNoWeapon> Switching to player with weapon")

			# Delete player without weapon
			self.queue_free()
			return

func _on_hit_box_damage_taken(_amount, knockback_taken):
	self._knockback = knockback_taken
	self.set_movement_enabled(false)

	self.player_animated_sprite.play("damage")
	await self.player_animated_sprite.animation_finished

	self.set_movement_enabled(true)
