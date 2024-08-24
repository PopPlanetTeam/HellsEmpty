extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_children() \
		.filter(func (obj): return obj.has_method("handle_lock_weapon")) \
		.map(func (obj): obj.handle_lock_weapon())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
