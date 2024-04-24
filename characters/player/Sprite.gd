extends Sprite2D

@onready var animation = get_parent().get_node("Animation")
@onready var player_node = get_parent()

func animate(direction: Vector2) -> void:
	verify_position(direction)
	if direction.x != 0:
		horizontal_behavior(direction)
	else:
		vertical_behavior(direction)

func verify_position(direction: Vector2) -> void:
	if direction.x > 0:
		flip_h = false
	elif direction.x < 0:
		flip_h = true

func horizontal_behavior(direction: Vector2) -> void:
	if direction.x !=0:
		animation.play("walk_side")
	else:
		animation.play("idle")
		
func vertical_behavior(direction: Vector2) -> void:
	if direction.y > 0:
		animation.play("walk_front")
	elif direction.y < 0:
		animation.play("walk_back")
	else:
		animation.play("idle")
