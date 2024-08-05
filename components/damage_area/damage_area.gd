extends Area2D
class_name DamageArea

## DamageArea is an Area2D node that scans for the player HitBox and deals damage to it.

signal damage_dealt

# If true, debug information will be printed to the console.
@export var debug: bool = false

# The amount of damage to deal to the HitBox.
@export var damage: float = 10.0

# The strength of the knockback to apply to the HitBox.
@export var knockback_strength: float = 50.0

# Called when another area enters this node's area.
# If the area is a HitBox, it deals damage and applies knockback to it.
# Emits the damage_dealt signal after dealing damage.
func _on_area_entered(area):
	if area is HitBox:
		var target_hitbox: HitBox = area
		
		# Calculate the knockback direction and strength.
		var knockback_direction = self.global_position.direction_to(target_hitbox.global_position)
		var knockback = knockback_direction.normalized() * knockback_strength
		
		# Apply damage and knockback to the target HitBox.
		target_hitbox.take_damage(damage, knockback)
		
		# Print debug information if debug mode is enabled.
		if debug:
			print("Target: ", target_hitbox.get_parent().name)
			print("Damage dealt: ", damage)
			print("Knockback: ", knockback_strength)
		
		# Emit the damage_dealt signal.
		damage_dealt.emit()
