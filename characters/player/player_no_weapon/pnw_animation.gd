extends AnimatedSprite2D

var _current_animation: String

func animate(velocity: Vector2):
	if velocity.length() > 0:
		if velocity.x != 0:
			_current_animation = "run"
			flip_h = velocity.x < 0
		elif velocity.y != 0:
			if velocity.y < 0:
				_current_animation = "run_back"
			else:
				_current_animation = "run_front"
	else:
		_current_animation = "idle"
	
	play(_current_animation)
