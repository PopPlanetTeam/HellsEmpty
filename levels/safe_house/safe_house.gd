extends Node2D

func _on_cauldron_body_entered(body:Node2D):
	get_tree().change_scene_to_file("res://levels/level_1/level_1.tscn")
