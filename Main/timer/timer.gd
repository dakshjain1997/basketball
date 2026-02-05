extends Timer

var gamemode:Enums.GameMode
var score:score_collider
var hasContinured:bool=false

@export var timeIncrement:float = 5

func _ready() -> void:
	SignalBus.pauseGame.connect(startTimer)
	SignalBus.contenueGame.connect(contnueRound)
	gamemode=Enums.currentGameMode
	#timeout.connect(endGame)
	if gamemode == Enums.GameMode.SCORERUSH:
		score=get_parent().get_node("Basket").get_child(0).get_child(4)
		print(score)
		if !score.score.is_connected(incrementTimer):
			score.score.connect(incrementTimer)
		wait_time=60
	if gamemode == Enums.GameMode.TIMEATTACK:
		disconnectIncrement()
		wait_time=150

func startTimer(isPaused:bool)->void:
	if !isPaused:
		start()
		SignalBus.pauseGame.disconnect(startTimer)

#func roundStarter()->void:
	

func contnueRound()->void:
	wait_time=30
	hasContinured=true
	start(wait_time)

func incrementTimer(_score:int)->void:
	#var currentTime:float= get_time_left()
	#set_wait_time(currentTime+timeIncrement)
	wait_time=time_left+timeIncrement
	#start(currentTime+timeIncrement)
	start(wait_time)
	print(get_time_left())
	pass

func _process(_delta: float) -> void:
	#print(get_time_left())
	$Label.text=str(time_left)
	pass

func get_isContineued()->bool:
	return hasContinured

#func endGame()->void:
	##print("end")
	#pass

func disconnectIncrement()->void:
	if score:
			if score.score.is_connected(incrementTimer):
				score.score.disconnect(incrementTimer)
