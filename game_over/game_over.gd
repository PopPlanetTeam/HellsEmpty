extends Node2D
class_name GameOver

@export var almas_coletadas : int = 0
@export var time_to_restart : = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	$AlmasColetadas.text = "Almas Coletadas: " + str(almas_coletadas)

func _process(delta):
	$TimeUntilRestart.text = str(time_to_restart) + "s"


func _on_restart_timer_timeout():
	time_to_restart -= 1
	if time_to_restart == 0:
		get_tree().change_scene_to_file("res://menus/main_menu/menu.tscn")
