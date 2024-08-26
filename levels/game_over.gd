extends Control

@onready var souls_collected : Label = $RunStats/SoulsCollected
@onready var coins_collected : Label = $RunStats/CoinsCollected
@onready var time_survived : Label = $RunStats/TimeSurvived
@onready var save_button : Button = $ButtonsContainer/SaveButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = true
	save_button.visible = false
	souls_collected.text = tr("COLLECTED_SOULS") + ": " + str(GlobalData.level_enemies_killed)
	var collected_coins = PlayerInventory.coins_amount - GlobalData.total_level_coins_collected
	coins_collected.text = tr("COINS_COLLECTED") + ": " + str(collected_coins)
	var survived_time = (Time.get_ticks_msec() / 1000.) - GlobalData.total_time_survived
	time_survived.text = tr("TIME_SURVIVED") + ": " + str(survived_time) + "s"
