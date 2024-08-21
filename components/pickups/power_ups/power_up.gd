extends Pickup
class_name PowerUp

@onready var path_follow = $Path2D/PathFollow2D
@onready var area_2d = $Area2D

@export var sprite: Sprite2D
var duration: float = randf_range(8, 16)

func set_enabled(enabled: bool) -> void:
	area_2d.monitoring = enabled

func can_rotate() -> bool:
	return false

func power_up_effect():
	self.queue_free()

var power_up_active: bool = false
func on_powerup_area_entered(_area: Area2D) -> void:
	if GlobalData.player and not power_up_active:
		sprite.visible = false
		self.call_deferred("set_enabled", false)
		power_up_active = true

		power_up_effect()

func _physics_process(_delta):
	path_follow.progress_ratio += 0.01

	if path_follow.progress_ratio >= 1:
		path_follow.progress_ratio = 0
