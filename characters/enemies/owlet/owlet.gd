extends EnemyBase

func _on_idle_next_to_player():
	state_machine.change_to_state("chase_a_star")

func _on_chase_a_star_player_too_far():
	state_machine.change_to_state("idle")

func _on_chase_a_star_player_next_to_enemy():
	state_machine.change_to_state("attack")

func _on_attack_finished():
	state_machine.change_to_state("chase_a_star")

func _on_hit_box_damage_taken(_amount, knockback):
	state_machine.current_state.set_physics_process(false)
	state_machine.current_state.set_process(false)

	_knockback = knockback

	animation_sprites.play("damage")

	await animation_sprites.animation_finished

	state_machine.current_state.set_physics_process(true)
	state_machine.current_state.set_process(true)

func _on_died():
	state_machine.current_state.set_physics_process(false)
	state_machine.current_state.set_process(false)

	animation_sprites.play("die")
	await animation_sprites.animation_finished

	self.queue_free()
