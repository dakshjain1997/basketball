extends Area2D

func _ready()->void:
	body_entered.connect(nextBall)

func _process(_delta:float)->void:
	pass

func nextBall(ball:Ball)->void:
	ball.spawnBall(ball.score)
	ball.set_collision_layer_value(3,false)
	#ball.removeCollision()
