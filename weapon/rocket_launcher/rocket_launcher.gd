extends Node2D
class_name RocketLauncher

@onready var fire_rate_timer = $FireRateTimer
@onready var firing_sound = $FiringSound
@onready var gun_origin = $GunOrigin

var can_shoot: bool = true

@onready var tree_root : Node = get_tree().root

func _process(_delta) -> void:
	if !can_shoot:
		return
	
	if Input.is_action_pressed("shoot"):
		var mouse_direction = get_global_mouse_position() - self.global_position
		var shot : RocketProjectile = preload("res://weapon/rocket_launcher/rocket_projectile.tscn").instantiate()

		# The gun should always shoot in the direction of the mouse
		shot.direction = mouse_direction.normalized()
		shot.speed = 500.0
		shot.damage = 100.0
		shot.rotation = mouse_direction.angle()
		shot.scale = self.scale
		shot.global_position = self.global_position
		
		tree_root.add_child(shot)
		firing_sound.play()
		
		can_shoot = false
		fire_rate_timer.start()

func _on_fire_rate_timer_timeout() -> void:
	can_shoot = true

func get_gun_origin() -> Marker2D:
	return gun_origin
