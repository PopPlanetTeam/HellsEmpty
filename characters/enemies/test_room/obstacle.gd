extends Node2D

@export var texture: Texture2D
@export var size: Vector2

@onready var _sprite = $Sprite2D
@onready var _collision = $StaticBody2D/CollisionShape2D

var _can_move: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_collision.shape = RectangleShape2D.new()
	_collision.shape.size = size

	var tex_img = texture.get_image()
	tex_img.resize(int(size.x), int(size.y))
	
	var img_tex = ImageTexture.create_from_image(tex_img)
	_sprite.texture = img_tex

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("shoot") and _collision.shape.get_rect().has_point(get_local_mouse_position()):
		_can_move = true
	
	if _can_move:
		position = get_global_mouse_position()
	
	if Input.is_action_just_released("shoot"):
		_can_move = false
