extends SceneBase

@onready var saver_loader: SceneSaverLoader = $SceneSaverLoader

func _ready():
	super._ready()
	
	if SceneManager.transition_happened():
		saver_loader.load_scene()
