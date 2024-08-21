extends Node2D
class_name WeaponBase

@onready var _gun_origin: Marker2D = $GunOrigin
@onready var _projectile_origin: Marker2D = $ProjectileOrigin

var cadence_timer: Timer
var shot: ProjectileBase

var default_cadence: float
var default_damage: float

func get_gun_origin() -> Marker2D:
	return _gun_origin

func set_damage_multiplier(m: float) -> void:
	shot.set_damage(default_damage * m)

func reset_damage() -> void:
	shot.set_damage(default_damage)

func set_cadence_multiplier(m: float) -> void:
	cadence_timer.wait_time = default_cadence * m

func reset_cadence() -> void:
	cadence_timer.wait_time = default_cadence