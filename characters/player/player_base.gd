extends CharacterBody2D
class_name PlayerBase

@export var SPEED = 300.0
@export var hitbox: HitBox
@export var player_animated_sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer

@export_group("Layers and Masks")
@export_flags_2d_physics var provides_collision = 0
@export_flags_2d_physics var scan_collision = 0
@export_flags_2d_physics var takes_damage = 0

func _ready():
	if not hitbox:
		printerr("PlayerBase> ERROR: No HitBox assigned.")
		get_tree().quit()

	if not (player_animated_sprite or animation_player):
		printerr("PlayerBase> ERROR: No AnimatedSprite2D or AnimationPlayer assigned.")
		get_tree().quit()
	
	if player_animated_sprite and player_animated_sprite.get_script() == null:
		printerr("PlayerBase> ERROR: AnimatedSprite2D has no script assigned.")
		get_tree().quit()
	
	if animation_player and animation_player.get_script() == null:
		printerr("PlayerBase> ERROR: AnimationPlayer has no script assigned.")
		get_tree().quit()

	self.collision_layer = provides_collision
	self.collision_mask = scan_collision
	hitbox.collision_layer = takes_damage
	hitbox.collision_mask = 0 # The hitbox should not collide with anything, it needs to only be visible to damage areas
   
	# Add itself to the global player variable
	GlobalData.player = self

func _physics_process(_delta):
	var x_direction = Input.get_axis("left", "right")
	var y_direction = Input.get_axis("up", "down")
	
	if x_direction or y_direction:
		velocity = Vector2(x_direction, y_direction).normalized() * SPEED
	else:
		velocity = Vector2(move_toward(velocity.x, 0, SPEED), move_toward(velocity.y, 0, SPEED))

	if player_animated_sprite:
		player_animated_sprite.animate(velocity)
	else:
		animation_player.animate(velocity)
	
	move_and_slide()
