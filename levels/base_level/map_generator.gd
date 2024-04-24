extends Node2D

@export var generator_button_click = func():
	$WalkerGenerator.generate()
@export var generator_settings: WalkerGeneratorSettings = null
@export var tilemap_instance: TileMap = null

func _ready():
	assert(generator_settings != null, "Error: you must provide the generator settings!")
	assert(tilemap_instance != null, "Error: you must provide the tilemap instance!")
	
	$WalkerGenerator.settings = generator_settings
	$TilemapGaeaRenderer.tile_map = tilemap_instance
