extends RigidBody2D
class_name Ball

var timer:SceneTreeTimer
var inputManager:InputManager
var scoreCollider:Node
var spawnNext:bool=true
var airSpin:bool=false
var spinDirection:int
var disableSpawn:bool=false

var score:int
signal SpawnNext
#signal ShakeHoop(signalConnect:bool)

func _init()->void:
	freeze=true

func _ready()->void:
	spawnNext=true
	set_contact_monitor(true)
	set_max_contacts_reported(1)
	self.body_entered.connect(collided)
	inputManager=get_parent().get_node("InputManager")
	scoreCollider=get_parent().get_node("Basket").get_node("Hoop").get_node("ScoreCollider")
	inputManager.Throw.connect(throw)
	scoreCollider.score.connect(spawnBall)
	#print("ball position",position)
	
func _process(_delta:float)->void:
	pass

func collided(body:PhysicsBody2D)->void:
	airSpin=false
	if body.name=="Branch":
		if !timer:
			timer=get_tree().create_timer(1.5,true,true)
			timer.timeout.connect(fallOfBranch)
	
	if body.name=="Floor":
		if !disableSpawn:
			spawnBall(0)
		disableScore()
		#set_collision_layer_value(3,false)
		var removecollision:SceneTreeTimer=get_tree().create_timer(0.8,true,true)
		removecollision.timeout.connect(set_collision_mask_value.bind(3,false))
		var despawn:SceneTreeTimer=get_tree().create_timer(3,true,true)
		despawn.timeout.connect(queue_free)
	
	if body.name=="Hoop" and linear_velocity.length() > 300:
		SignalBus.ShakeHoop.emit()

func fallOfBranch()->void:
	self.set_collision_mask_value(2,false)

func throw(direction:Vector2)->void:
	freeze=false
	apply_central_impulse(direction*2)
	set_angular_velocity(deg_to_rad(randf_range(-30,-60)))
	inputManager.Throw.disconnect(throw)

func spawnBall(_score:int)->void:
	#if spawnNext:
	if spawnNext  and  !disableSpawn:
		spawnNext=false
		SpawnNext.emit()
	if scoreCollider.score.is_connected(spawnBall):
		scoreCollider.score.disconnect(spawnBall)

func disableScore()->void:
	set_collision_layer_value(3,false)

func disconectThrow()->void:
	if inputManager.Throw.is_connected(throw):
		inputManager.Throw.disconnect(throw)
