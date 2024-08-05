extends State

signal attack_finished

var _enemy: EnemyBase

## This function is automatically called when the state is entered.
func Enter():
	_enemy = state_machine.get_parent()
	_enemy.damage_area.monitoring = true

	_enemy.animation_sprites.play("attack")

	await _enemy.animation_sprites.animation_finished

	_enemy.damage_area.monitoring = false

	attack_finished.emit()
