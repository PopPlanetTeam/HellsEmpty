extends WeaponBase
class_name Revolver

@onready var _fire_rate_timer = $FireRateTimer
@onready var _firing_sound = $FiringSound
@onready var _gun_sprite: Sprite2D = $Sprite2D
@onready var _tree_root: Node = get_tree().root

var _shot: PackedScene = preload("res://weapon/revolver/projectile/revolver_projectile.tscn")
var _can_shoot: bool = true

func _process(_delta) -> void:
	if !_can_shoot:
		return
	
	if Input.is_action_pressed("shoot"):
		var mouse_direction = get_global_mouse_position() - self.global_position
		var new_shot: RevolverProjectile = _shot.instantiate()

		# The gun should always shoot in the direction of the mouse
		new_shot.direction = mouse_direction.normalized()
		new_shot.rotation = mouse_direction.angle()
		new_shot.scale = self.scale
		new_shot.global_position = _projectile_origin.global_position
		
		#_gun_sprite.frame = 1 # Change the gun sprite to the fired state
		_tree_root.add_child(new_shot)
		_firing_sound.play()
		
		_can_shoot = false
		_fire_rate_timer.start()

func _on_fire_rate_timer_timeout() -> void:
	_can_shoot = true
	#_gun_sprite.frame = 0 # Change the gun sprite back to the idle state
