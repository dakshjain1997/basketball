extends Control

var digit1:AnimatedSprite2D
var digit2:AnimatedSprite2D
var digit3:AnimatedSprite2D
var digit4:AnimatedSprite2D

var digitArray:Array=['none','none','none','none']

var score:int=0
var label:Label
@export var Basket:StaticBody2D
var scoreCollider:Node

func _ready()->void:
	digit1=$AnimatedSprite2D
	digit2=$AnimatedSprite2D2
	digit3=$AnimatedSprite2D3
	digit4=$AnimatedSprite2D4
	#label=$Label
	scoreCollider=Basket.get_child(0).get_child(4)
	scoreCollider.score.connect(incScore)
	#label.text=str(score)

func _process(_delta:float)->void:
	pass

func incScore(change:int)->void:
	score+=change
	#label.text=str(score)
	displayScore()

func displayScore()->void:
	if score == 0:
		pass
	elif score > 9999:
		pass
	else:
		var temp:int=score
		var i:int=0
		while temp !=0 and i<4:
			digitArray[i]=temp%10
			temp=int(temp/10)
			i+=1
	#digit1.frame=digitArray[0]
	#digit1.set_frame(digitArray[0])
	digit1.animation=str(digitArray[0])
	digit2.animation=str(digitArray[1])
	digit3.animation=str(digitArray[2])
	digit4.animation=str(digitArray[3])
	pass
