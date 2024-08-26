extends Camera2D
class_name FollowingCamera

@onready var default_hud = $HUD
@onready var shop_hud = $ShopHUD

@export var shop: bool = false

## The camera will follow the player. This script should be attached to the camera node.
func _ready():
	if shop:
		default_hud.visible = false
		shop_hud.visible = true
	else:
		default_hud.visible = true
		shop_hud.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if GlobalData.player != null:
		self.global_position = GlobalData.player.global_position
