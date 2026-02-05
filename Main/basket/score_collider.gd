class_name score_collider
extends Node2D

@onready var upper:Area2D=$UpperArea
@onready var lower:Area2D=$LowerArea

signal score(change:int)

var upperHit:bool=false
var LowerHit:bool=false

func _ready()->void:
	upper.body_entered.connect(upperEntered)
	upper.body_exited.connect(upperExit)
	lower.body_entered.connect(lowerEntered)
	lower.body_exited.connect(lowerExit)

func upperEntered(_area:Ball)->void:
	upperHit = true

func lowerEntered(area:Ball)->void:
	if upperHit : 
		LowerHit = true
		upperHit = false
		score.emit(area.score)

func upperExit(_area:Ball)->void: upperHit = false

func lowerExit(_area:Ball)->void: LowerHit = false
