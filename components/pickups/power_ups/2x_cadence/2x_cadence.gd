extends PowerUp

func power_up_effect():
	var player = GlobalData.player

	if not (player is PlayerWithWeapon):
		super.power_up_effect()
		return

	player.weapon_slot.weapon.set_cadence_multiplier(0.5)
	player.set_power_up_shader(true)

	await get_tree().create_timer(duration, false).timeout

	player.set_power_up_shader(false)
	player.weapon_slot.weapon.reset_cadence()

	super.power_up_effect()
