extends Node2D
class_name WeaponBase

@onready var _gun_origin: Marker2D = $GunOrigin
@onready var _projectile_origin: Marker2D = $ProjectileOrigin

func get_gun_origin() -> Marker2D:
	return _gun_origin
