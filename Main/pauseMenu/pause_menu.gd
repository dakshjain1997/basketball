extends Control

func _ready() -> void:
	position=get_viewport().size*2/3
	$Panel/PanelContainer/settings.button_down.connect(openSettings)
	$Panel/PanelContainer/quit.button_down.connect(quitGame)
	$Panel/PanelContainer/forfit.button_down.connect(showLeaderboard)
	$Panel/close.button_down.connect(closePauseMenu)

func quitGame()->void:
	queue_free()
	get_tree().quit()

func openSettings()->void:
	#get_tree().change_scene_to_file()
	pass

func closePauseMenu()->void:
	SignalBus.pauseGame.emit(false)
	get_tree().paused=false
	get_parent().remove_child(self)
	queue_free()

func showLeaderboard()->void:
	var leaderboard:LeaderBoard=load("res://Main/LeaderBoard/leader_board.tscn").instantiate()
	get_parent().add_child(leaderboard)
	get_tree().paused=false
	print(get_parent())
	queue_free()
