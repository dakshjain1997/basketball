extends Control

const pauseMenu=preload("res://Main/pauseMenu/pause_menu.tscn")

func _ready() -> void:
	$Button.button_down.connect(openPauseMenu)
	

func openPauseMenu()->void:
	get_tree().paused=true
	SignalBus.pauseGame.emit(true)
	get_parent().add_child(pauseMenu.instantiate())
