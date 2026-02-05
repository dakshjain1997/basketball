class_name LeaderBoard
extends Control

func _ready() -> void:
	$close.button_down.connect(closeLeaderboard)
	$ReturnToMenu.button_down.connect(backToGameMenu)
	$Retry.button_down.connect(restartGame)
	
func closeLeaderboard()->void:
	queue_free()

func backToGameMenu()->void:
	get_tree().change_scene_to_file("res://Main/GameMenu/game_menu.tscn")
	queue_free()

func restartGame()->void:
	get_tree().change_scene_to_file("res://Main/GameManager/game_manager.tscn")
	queue_free()
