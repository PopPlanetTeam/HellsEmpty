extends Node2D

@onready var light:PointLight2D = $PointLight2D

func _on_timer_timeout():
	light.energy = randf_range(0.5, 0.7)
