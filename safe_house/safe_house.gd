extends Node2D

func _on_area_area_entered(area):
	print("entrou")
	get_tree().change_scene_to_file("res://game/game.tscn")
