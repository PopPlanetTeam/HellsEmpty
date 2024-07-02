extends Sprite2D

@onready var player_node : PlayerBase = $"PlayerBase"
@onready var animation : AnimationPlayer = $"../Animation"

func animate(direction: Vector2) -> void:
	animation.play("weapon_carying")
	#if Input.is_action_pressed("shoot"):
		#animation.play("sword_attack")
	#else:
		#verify_position(direction)
		#if direction.x != 0:
			#horizontal_behavior(direction)
		#else:
			#vertical_behavior(direction)

func verify_position(direction: Vector2) -> void:
	if direction.x > 0:
		flip_h = false
	elif direction.x < 0:
		flip_h = true

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
