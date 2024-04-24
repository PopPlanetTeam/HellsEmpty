extends Node2D

const Enemy = preload("res://characters/enemies/enemy.gd")

@export var enemy_object: Enemy = null

func _ready():
	assert(enemy_object, "Error: you must provide the enemy object")
