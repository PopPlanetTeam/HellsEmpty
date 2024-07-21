extends EnemyBase

func _on_idle_next_to_player():
	state_machine.change_to_state("chase")

func _on_chase_player_too_far():
	state_machine.change_to_state("idle")

func _on_died():
	self.queue_free()
