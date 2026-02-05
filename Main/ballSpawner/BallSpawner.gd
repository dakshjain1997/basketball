extends Node2D

var ballScene:PackedScene=preload("res://Main/ball/ball.tscn")
#var shadowManagerScene:PackedScene=preload("res://Main/ball/shadowManager/shadow_manager.tscn")
#var shadowManager
var spawnTopLeft:Vector2
var spawnBottomRight:Vector2
var canSpawn:bool=true

func _ready()->void:
	var base:Vector2=position
	spawnTopLeft=Vector2(base.x-600,base.y-50)
	spawnBottomRight=Vector2(base.x,base.y+200)
	#spawnBall()
	#print(spawnTopLeft,spawnBottomRight)

#func _process(delta:float)->void:
	#if(Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and canSpawn):
		#checkSpawn()
		#canSpawn=false

func spawnBall()->void:
	var ball:Ball=ballScene.instantiate()
	#var shadowManager:ShadowManager=shadowManagerScene.instantiate()
	#var ballParent:RemoteTransform2D=RemoteTransform2D.new()
	var ballposition:Vector2=randomSpawnLocation()
	#var remotePath:RemoteTransform2D
	ball.rotation=deg_to_rad(randi()%360)
	ball.position=ballposition
	#print(ballposition.x)
	ball.score=2 if ballposition.x <= 1300  else  3
	ball.SpawnNext.connect(checkSpawn)
	#remotePath=ball.get_child(4)
	#print("ball",ball.global_position,position)
	#print("remotepath",remotePath.remote_path)
	#shadowManager.global_position=ball.global_position
	#ball.freeze=true
	call_deferred("add_sibling",ball)
	#call_deferred("add_sibling",shadowManager)
	#remotePath.remote_path=shadowManager.get_path()
	#add_sibling(ball)

func randomSpawnLocation()->Vector2:
	var spawnPosition:Vector2
	spawnPosition=Vector2(randf_range(spawnTopLeft.x,spawnBottomRight.x),randf_range(spawnTopLeft.y,spawnBottomRight.y))
	return spawnPosition

func checkSpawn()->void:
	if get_parent().get_children().filter(filterFrozenBall).size()<1:
		spawnBall()

func filterFrozenBall(node:Object)->Ball:
	if node is Ball :
		if node.freeze == true:
			return node
	return null

func clearBalls()->void:
	var removeball:Array=get_parent().get_children()
	for node:Node in removeball:
		if node is Ball:
			node.queue_free()
			#if node.freeze == false:
				#node.queue_free()

func disableBallSpawn()->void:
	var getBalls:Array=get_parent().get_children()
	for node:Node in getBalls:
		if node is Ball:
			print(node,"this is ball")
			node.disconectThrow()
			#node.disableScore()
			node.disableSpawn=true
