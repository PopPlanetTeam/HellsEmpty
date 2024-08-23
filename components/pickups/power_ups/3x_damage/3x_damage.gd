extends PowerUp

func power_up_effect():
	var player = GlobalData.player

	if not (player is PlayerWithWeapon):
		super.power_up_effect()
		return

	player.weapon_slot.weapon.set_damage_multiplier(3)
	player.set_power_up_shader(true)

	await get_tree().create_timer(duration, false).timeout

	player.set_power_up_shader(false)
	player.weapon_slot.weapon.reset_damage()

	super.power_up_effect()
