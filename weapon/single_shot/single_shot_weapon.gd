extends WeaponBase
class_name SingleShotWeapon

@onready var fire_rate_timer = $FireRateTimer
var can_shoot: bool = true

@onready var tree_root : Node = get_tree().root

func _process(delta) -> void:
	if !can_shoot:
		return
	
	if Input.is_action_pressed("shoot"):
		var shot = preload("res://weapon/single_shot/shoot.tscn").instantiate()
		shot.direction = (get_local_mouse_position() - shot.position).normalized()
		shot.speed = 200.0
		shot.damage = 100.0
		add_child(shot)
		can_shoot = false
		fire_rate_timer.start()

func _on_fire_rate_timer_timeout() -> void:
	can_shoot = true
