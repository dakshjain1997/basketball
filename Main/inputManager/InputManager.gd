extends Node2D
class_name InputManager

var isDraging:bool= false
var dragStart:Vector2
var dragEnd:Vector2
var directionVector:Vector2
var gamePaused:bool=true

signal Throw(direction:Vector2)
signal DrawDirection(direction:Vector2)

func _ready()->void:
	SignalBus.pauseGame.connect(setPause)

func setPause(pause:bool)->void:
	gamePaused=pause

func _process(delta: float) -> void:
	if !gamePaused:
		screenDrag(delta)

func screenDrag(delta: float)->void:
	if(Input.is_action_just_pressed("Game_Tap")):
		isDraging=true
		dragStart=get_global_mouse_position()
	if(Input.is_action_pressed("Game_Tap")):
		dragEnd=get_global_mouse_position()
		if (directionVector - (dragStart-dragEnd).limit_length(1500)).length()>50:
			directionVector=(dragStart-dragEnd).limit_length(1500)
			DrawDirection.emit(directionVector*2,delta)
	if(Input.is_action_just_released("Game_Tap")):
		dragEnd=get_global_mouse_position()
		isDraging=false
		directionVector=(dragStart-dragEnd).limit_length(1500)
		if directionVector.length()>50:
			Throw.emit(directionVector)

func filterFrozenBall(node:Object)->Ball:
	if node is Ball :
		if node.freeze == true:
			return node
	return null
