extends Sprite2D

@onready var player_node : PlayerBase = $"PlayerBase"
@onready var animation : AnimationPlayer = $"../Animation"
@onready var weapon_slot : Node2D = $"../WeaponSlot"

func animate(direction: Vector2) -> void:
	#animation.play("weapon_carying")
	verify_position(direction)
	if direction.x != 0:
		horizontal_behavior(direction)
	else:
		vertical_behavior(direction)

func verify_position(direction: Vector2) -> void:
	var aiming_direction = (get_global_mouse_position() - self.global_position)
	var aiming_oposite_to_walking_position : bool = aiming_direction.dot(Vector2(direction.x, 0.0)) < 0.0
	var aiming_to_the_left : bool = aiming_direction.x < 0.0
	
	if direction.x == 0.0:
		flip_h = aiming_to_the_left
	elif direction.x > 0.0:
		flip_h = false
	elif direction.x < 0.0:
		flip_h = true
		
	if aiming_oposite_to_walking_position:
		flip_h = !flip_h

func horizontal_behavior(direction: Vector2) -> void:
	if direction.x != 0:
		animation.play("walk_side")
	else:
		animation.play("idle")
		
func vertical_behavior(direction: Vector2) -> void:
	if direction.y != 0.0:
		animation.play("walk_side")
	else:
		animation.play("idle")
	#if direction.y > 0:
		#animation.play("walk_front")
	#elif direction.y < 0:
		#animation.play("walk_back")
	#else:
		#animation.play("idle")
