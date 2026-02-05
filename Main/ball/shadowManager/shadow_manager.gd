class_name ShadowManager
extends Node2D

var floorPosition:float
var ballPosition:float
var castDistance:float
var largeShadowRange:float=1200
var smallShadowRange:float=400

func _init() -> void:
	global_rotation=0
	

func _ready() -> void:
	floorPosition=get_parent().get_parent().getFloorPosition()
	calculateCastDistance()
	updatePlacement()
	global_rotation=0
	#print("shadow here")
	#print(position,global_position)
	#rotation=-get_parent().transform.get_rotation()
	pass

func _process(_delta: float) -> void:
	calculateCastDistance()
	affectShadows(castDistance)
	updatePlacement()
	global_rotation=0
	#updateRotation($LargeShadow)
	#updateRotation($SmallShadow)
	#rotation=-get_parent().transform.get_rotation()

func affectShadows(distance:float)->void:
	var largeScale:float=clamp(remap(distance,largeShadowRange,0,0,1),0,1)
	var smallScale:float=clamp(remap(distance,smallShadowRange,0,0,1),0,1)
	$LargeShadow.scale.x=largeScale
	$LargeShadow.scale.y=largeScale
	$SmallShadow.scale.x=smallScale
	$SmallShadow.scale.y=smallScale
	#print($LargeShadow.scale)

func calculateCastDistance()->void:
	ballPosition=get_parent().global_position.y
	castDistance=floorPosition-ballPosition

func updatePlacement()->void:
	$LargeShadow.position.y=castDistance
	$SmallShadow.position.y=castDistance
	pass

func updateRotation(element:Sprite2D)->void:
	var spin:float=get_parent().get_rotation()
	element.rotate(spin)
	pass
