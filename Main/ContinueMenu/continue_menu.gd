class_name ContineuMenu
extends Control

@onready var adButton:Button=$ViewAd
@onready var roundEnd:Button=$EndRound
@onready var roundContinue:Button=$UseCoins
@onready var close:Button=$Close


func _ready() -> void:
	#print($ViewAd)
	#adButton.button_down.connect(showAd)
	$ViewAd.button_down.connect(showAd)
	$EndRound.button_down.connect(endRound)
	$UseCoins.button_down.connect(continueRound)
	$Close.button_down.connect(endRound)
	pass

func showAd()->void:
	print("in ad")
	pass

func continueRound()->void:
	SignalBus.pauseGame.emit(false)
	get_tree().paused=false
	SignalBus.contenueGame.emit()
	#get_parent().get_node("readyCounter").playCounterAnimation()
	get_tree().paused=true
	get_parent().remove_child(self)
	queue_free()
	# start timer again 
	# clear any lines/ trails drawn 
	# should this be in the game manager function
	pass

func endRound()->void:
	pass
