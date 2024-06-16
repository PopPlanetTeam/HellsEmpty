extends WeaponBase
class_name RocketLauncher

@onready var fire_rate_timer = $FireRateTimer
@onready var firing_sound = $FiringSound
var can_shoot: bool = true

@onready var tree_root : Node = get_tree().root

func _process(delta) -> void:
	var aiming_direction = (get_global_mouse_position() - self.global_position)
	#self.look_at(aiming_direction)
	self.rotation = aiming_direction.angle()
	
	if !can_shoot:
		return
	
	if Input.is_action_pressed("shoot"):
		var shot : RocketProjectile = preload("res://weapon/rocket_launcher/rocket_projectile.tscn").instantiate()
		shot.direction = aiming_direction.normalized()
		shot.speed = 500.0
		shot.damage = 100.0
		shot.rotation = self.rotation
		shot.scale = self.scale
		shot.global_position = self.global_position
		tree_root.add_child(shot)
		firing_sound.play()
		can_shoot = false
		fire_rate_timer.start()

func _on_fire_rate_timer_timeout() -> void:
	can_shoot = true
