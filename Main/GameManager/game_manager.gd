extends Node2D

var hasTimerExtended:bool=false
var continueMenu:ContineuMenu
var leaderBoard:LeaderBoard
var floorPosition:float

var timer:Timer

func _ready() -> void:
	floorPosition=floorContactPosition()
	timer=$Timer
	timer.timeout.connect(timerExpired)
	
	get_tree().paused=true
	$readyCounter.playCounterAnimation()
	SignalBus.contenueGame.connect(continurRound)

func timerExpired()->void:
	$BallSpawner.disableBallSpawn()
	$Timer.disconnectIncrement()
	$lineManager.disconnectDraw()
	$lineManager.clearTragectory(Vector2.ZERO)
	if !hasTimerExtended:
		print("show contenue menu")
		print(continueMenu)
		if !continueMenu:
			continueMenu=load("res://Main/ContinueMenu/continue_menu.tscn").instantiate()
		add_child(continueMenu)
		setTimeExtended(true)
		pass
	else:
		if !leaderBoard:
			leaderBoard=load("res://Main/LeaderBoard/leader_board.tscn").instantiate()
		add_child(leaderBoard)


func setTimeExtended(state:bool)->void:
	hasTimerExtended=state

func continurRound()->void:
	$lineManager.connectDraw()
	$readyCounter.playCounterAnimation()

func floorContactPosition()->float:
	var size:float=$Floor/FloorCollider.shape.size.y
	var loaction:float= $Floor/FloorCollider.global_position.y
	return loaction-size/2

func getFloorPosition()->float:
	return floorPosition
