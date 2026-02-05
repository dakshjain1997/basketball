extends Control

var ballSpawner:Node2D

signal connectLineManager

func _ready() -> void:
	ballSpawner=get_parent().get_node('BallSpawner')
	$AnimationPlayer.connect("animation_finished",unpauseGame)
	#animation_finished("contdown").connect(unpauseGame)
	$AnimationPlayer.set_assigned_animation("contdown")
	
func unpauseGame(_animation:String)->void:
	get_tree().paused=false
	SignalBus.pauseGame.emit(false)

func playCounterAnimation()->void:
	connectLineManager.emit()
	ballSpawner.clearBalls()
	ballSpawner.spawnBall()
	$AnimationPlayer.play("contdown")
