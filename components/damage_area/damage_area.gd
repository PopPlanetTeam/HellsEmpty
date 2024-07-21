extends Area2D
class_name DamageArea

signal damage_dealt

@export var damage: float = 10.0
@export var knockback_strength: float = 50.0
@export var debug: bool = false

func _on_area_entered(area):
	if area is HitBox:
		var target_hitbox: HitBox = area
		
		# Calculate the knockback
		var knockback_direction = self.global_position.direction_to(target_hitbox.global_position)
		var knockback = knockback_direction * knockback_strength
		
		target_hitbox.take_damage(damage, knockback)
		
		if debug:
			print("Target: ", target_hitbox.get_parent().name)
			print("Damage dealt: ", damage)
			print("Knockback: ", knockback)
		
		damage_dealt.emit()