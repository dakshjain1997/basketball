extends Control


func _ready() -> void:
	$HBoxContainer/TimeAttack.button_up.connect(gameModeTimeAttack)
	$HBoxContainer/ScoreRush.button_up.connect(gameModeScoreRush)
	$HBoxContainer/Back.button_up.connect(backToMainMenu)

func gameModeTimeAttack()->void:
	Enums.currentGameMode=Enums.GameMode.TIMEATTACK
	get_tree().change_scene_to_file("res://Main/GameManager/game_manager.tscn")
	queue_free()

func gameModeScoreRush()->void:
	Enums.currentGameMode=Enums.GameMode.SCORERUSH
	get_tree().change_scene_to_file("res://Main/GameManager/game_manager.tscn")
	queue_free()

func backToMainMenu()->void:
	get_tree().change_scene_to_file("res://Main/MainMenu/main_menu.tscn")
	queue_free()
