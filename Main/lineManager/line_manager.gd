extends Line2D

var inputManager:InputManager
var maxPoints:int=30
var pointDistance:int=100
var pointRadius:float=12
var tragectoryArray:Array[Vector2]
var currentDirection:Vector2=Vector2.ZERO
var GRAVITY:float=ProjectSettings.get_setting("physics/2d/default_gravity")
var pointPosition:Vector2

func _ready() -> void:
	#arrow=$arrow
	#arrow.set_visible(false)
	#arrow.visible=false
	inputManager=get_parent().get_node("InputManager")
	connectDraw()
	inputManager.Throw.connect(clearTragectory)

func _draw() -> void:
	for point in tragectoryArray:
		draw_circle(point,pointRadius,Color.GRAY)
		draw_circle(point,pointRadius-1,Color.ORANGE)
		pointRadius-=0.5
	tragectoryArray.clear()
	pointRadius=12
	
func drawTragectory(direction:Vector2,_delta:float)->void:
	var dots:int=direction.length()/pointDistance
	var ballArray:Array[Node]=get_parent().get_children().filter(findball)
	if !ballArray.is_empty():
		var ball:Ball=ballArray[0]
		for i in range(dots):
			var t:float=i*pointDistance/direction.length()
			pointPosition = ball.position-global_position + direction * t + 0.5 * Vector2(0,GRAVITY) * t * t 
			tragectoryArray.push_back(pointPosition)
		queue_redraw()

func findball(node:Node)->Ball:
	if node is Ball :
		if node.freeze == true:
			return node
	return null

func clearTragectory(_direction:Vector2)->void:
	tragectoryArray.clear()
	queue_redraw()

func disconnectDraw()->void:
	if inputManager.DrawDirection.is_connected(drawTragectory):
		inputManager.DrawDirection.disconnect(drawTragectory)

func connectDraw()->void:
	if !inputManager.DrawDirection.is_connected(drawTragectory):
		inputManager.DrawDirection.connect(drawTragectory)
