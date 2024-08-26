extends Node2D

@export var kills_to_win: int = 70

@onready var player : PlayerBase = $PlayerNoWeapon
@onready var auto_save_timer : Timer = $Autosave

func transfer_all_children_added_on_this_scene(from_node, to_node):
	from_node.get_children(false) \
		.filter(func(child): return child.owner != from_node) \
		.map(func(child): transfer_child(from_node, to_node, child))
		
func transfer_child(from_node, to_node, child):
	from_node.remove_child(child)
	to_node.add_child(child)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalData.level_enemies_killed = 0
	GlobalData.current_level_goal = kills_to_win
	
	PlayerInventorySaverLoader.new().load_scene()
	if PlayerInventory.current_weapon != null:
		if GlobalData.player !=  null:
				var player_with_weapon : PlayerWithWeapon = GlobalData.player_with_weapon_scene.instantiate()
				player_with_weapon.transform = player.transform
				player_with_weapon.position = player.position
				player_with_weapon.global_position = player.global_position

				transfer_all_children_added_on_this_scene(player, player_with_weapon)
				self.add_child(player_with_weapon)
				player_with_weapon.SPEED = player.SPEED
				player.queue_free()
				
				player = player_with_weapon
				GlobalData.player = player
				player.weapon_slot.assign_weapon(PlayerInventory.current_weapon)
				
	player.player_died.connect(_return_to_menu)


func _return_to_menu():
	GlobalDataSaverLoader.new().save_scene()
	PlayerInventorySaverLoader.new().save_scene()
	get_tree().change_scene_to_file("res://menus/main_menu/menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if GlobalData.level_enemies_killed == GlobalData.current_level_goal:
		# ------------------------------ Coloca tua tela de Game Win aqui, Jelson ------------------------------
		pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("save"):
		PlayerInventorySaverLoader.new().save_scene()
		GlobalDataSave.new().save_scene()

func _on_autosave_timeout() -> void:
	GlobalDataSaverLoader.new().save_scene()
	PlayerInventorySaverLoader.new().save_scene()
	auto_save_timer.start()
