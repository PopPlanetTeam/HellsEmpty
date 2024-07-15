extends AnimatedSprite2D

func animate(velocity: Vector2):
	if velocity.length() > 0:
		if velocity.x != 0:
			animation = "run"
			flip_h = velocity.x < 0
		elif velocity.y != 0:
			flip_h = false
			if velocity.y < 0:
				animation = "run_back"
			else:
				animation = "run_front"
	else:
		animation = "idle"
		flip_h = false
