extends CanvasLayer

signal transition_finished

@onready var color_rect:ColorRect = $ColorRect
@onready var animation_player:AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	color_rect.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name):
	if anim_name == "fade_in":
		animation_player.play("fade_out")
		transition_finished.emit()
	else:
		color_rect.visible = false

func transition():
	color_rect.visible = true
	animation_player.play("fade_in")
