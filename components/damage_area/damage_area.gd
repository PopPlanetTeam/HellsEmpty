extends Area2D

signal damage_dealt

@export var damage: float = 10.0

func _on_area_entered(area):
	if area is HitBox:
		var target_hitbox:HitBox = area
		target_hitbox.take_damage(damage)
		print("Damage dealt: ", damage)
		damage_dealt.emit()
		
