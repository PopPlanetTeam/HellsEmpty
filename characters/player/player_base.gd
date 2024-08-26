extends CharacterBody2D
class_name PlayerBase

signal player_died

@export var SPEED = 190.0
@export var player_animated_sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer

@export_group("Layers and Masks")
@export_flags_2d_physics var provides_collision: int = 0
@export_flags_2d_physics var scan_collision: int = 0
@export_flags_2d_physics var takes_damage: int = 0

@onready var hitbox: HitBox = $HitBox
@onready var health: Health = $Health

var _knockback: Vector2 = Vector2.ZERO
var _movement_enabled: bool = true

var _attributes: PlayerAttributes

var _power_up_shader = preload("res://characters/player/shaders/power_up.tres")

func _ready():
	if not hitbox:
		printerr("PlayerBase> ERROR: No HitBox assigned.")
		get_tree().quit()
		return

	if not (player_animated_sprite or animation_player):
		printerr("PlayerBase> ERROR: No AnimatedSprite2D or AnimationPlayer assigned.")
		get_tree().quit()
		return
	
	if player_animated_sprite and player_animated_sprite.get_script() == null:
		printerr("PlayerBase> ERROR: AnimatedSprite2D has no script assigned.")
		get_tree().quit()
		return
	
	if animation_player and animation_player.get_script() == null:
		printerr("PlayerBase> ERROR: AnimationPlayer has no script assigned.")
		get_tree().quit()
		return

	self.collision_layer = provides_collision
	self.collision_mask = scan_collision
	hitbox.collision_layer = takes_damage
	hitbox.collision_mask = takes_damage
   
	_attributes = PlayerAttributes.new()
	_attributes.health = health.life
	_attributes.speed = self.SPEED
   
	# Add itself to the global player variable
	GlobalData.player = self

# The only purpose of this function is to update the attributes of the player
func _process(_delta):
	_attributes.health = health.life
	_attributes.speed = self.SPEED

func _physics_process(_delta):
	if not _knockback.is_equal_approx(Vector2.ZERO):
		# We gonna redirect the physics process to the _knockback process
		_knockback_process()
		return

	if not _movement_enabled:
		return

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

func _knockback_process():
	velocity += _knockback

	move_and_slide()
	_knockback = _knockback.lerp(Vector2.ZERO, 0.5)

func _on_died():
	player_died.emit()
	#get_tree().call_group(GlobalData.PHASE_SCENE, "_on_player_died")
	self.queue_free()
	GlobalData.player = null

func set_movement_enabled(enabled: bool):
	_movement_enabled = enabled

func get_attributes() -> PlayerAttributes:
	return _attributes

func set_attributes(attributes: PlayerAttributes):
	_attributes = attributes

	self.SPEED = _attributes.speed
	hitbox.health_component.life = _attributes.health

var actives_power_ups: int = 0
func set_power_up_shader(enabled: bool):
	if enabled:
		self.material = _power_up_shader
		actives_power_ups += 1
	else:
		actives_power_ups -= 1

		if actives_power_ups == 0:
			self.material = null

func pick_weapon(_weapon_pick: WeaponPick):
	pass
