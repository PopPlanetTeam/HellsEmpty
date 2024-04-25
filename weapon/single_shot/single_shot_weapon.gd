extends WeaponBase
class_name SingleShotWeapon

func _process(delta):
	if Input.is_action_pressed("shoot"):
		var shot = preload("res://weapon/single_shot/shoot.tscn").instantiate()
		shot.direction = (get_local_mouse_position() - shot.position).normalized()
		shot.speed = 200.0
		shot.damage = 100.0
		add_child(shot)
