extends Area2D
class_name HitBox

## The HitBox is an Area2D node that can be detected by DamageArea nodes to take damage and apply knockback.
## Also, the HitBox scans for bodies in the "damage_body" group. This group is used to deal damage to HitBoxes without needing a DamageArea node.

signal damage_taken(amount: float, knockback: Vector2)

@export var health_component: Health = null

# Takes damage and emits the damage_taken signal if the health is greater than 0.
func take_damage(amount: float, knockback: Vector2):
	if health_component:
		health_component.take_damage(amount)
		
		if health_component.life > 0.0:
			damage_taken.emit(amount, knockback)

# Detects bodies in the "damage_body" group and takes damage from them.
func _on_body_entered(body):
	if body.is_in_group("damage_body"):
		take_damage(body.get_damage(), body.get_knockback(self.global_position))
