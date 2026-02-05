extends Control

func _ready() -> void:
	$VBoxContainer/Play.button_up.connect(onPlay)
	$Quit.button_up.connect(onQuit)

func onPlay()->void:
	get_tree().change_scene_to_file("res://Main/GameMenu/game_menu.tscn")
	queue_free()

func onQuit()->void:
	get_tree().quit()
