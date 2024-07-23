extends EnemyBase

@onready var animation_sprites: AnimatedSprite2D = $Animation
@onready var damage_area: DamageArea = $DamageArea

var _knockback: Vector2 = Vector2.ZERO

func _on_idle_next_to_player():
	state_machine.change_to_state("chase")

func _on_chase_player_too_far():
	state_machine.change_to_state("idle")

func _on_chase_player_next_to_enemy():
	state_machine.change_to_state("attack")

func _on_attack_finished():
	state_machine.change_to_state("chase")

func _on_died():
	state_machine.current_state.set_process(false)
	state_machine.current_state.set_physics_process(false)

	animation_sprites.play("die")
	await animation_sprites.animation_finished

	self.queue_free()

func _on_hit_box_damage_taken(_amount, knockback):
	state_machine.current_state.set_process(false)
	state_machine.current_state.set_physics_process(false)

	_knockback = knockback

	animation_sprites.play("damage")

	await animation_sprites.animation_finished

	state_machine.current_state.set_process(true)
	state_machine.current_state.set_physics_process(true)

func _physics_process(_delta):
	if not _knockback.is_equal_approx(Vector2.ZERO):
		velocity += _knockback

		move_and_slide()

		_knockback = _knockback.lerp(Vector2.ZERO, 0.5)
