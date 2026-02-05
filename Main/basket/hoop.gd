extends StaticBody2D

var angle:float=deg_to_rad(1)
var upperAngleRange:float=deg_to_rad(-20)
var lowerAngleRange:float=deg_to_rad(20)
var minAngle:float=upperAngleRange
var maxAngle:float=lowerAngleRange
var speed:float=6
const ANGLE_SHRINK_FACTOR=0.5
var iterations := 0
var max_iterations := 20

func _init()->void:
	rotate(angle)

func _ready()->void:
	SignalBus.ShakeHoop.connect(shakeHoop)


func _process(_delta:float)->void:
	pass

func _physics_process(delta:float)->void:
	if rotation <= angle:
		rotate(angle*delta*speed)


func shakeHoop()->void:
	var down:bool=true
	while iterations < max_iterations :
		if down:
			if rotation < maxAngle:
				var change:float=lerp(maxAngle,rotation, 0.2)
				rotate(change)
				maxAngle -= change
				if abs(rotation - maxAngle) < lowerAngleRange:
					down = false
		else:
			if rotation > minAngle:
				var change:float=lerp(minAngle, rotation, 0.2)
				rotate(change)
				minAngle -= change
				if abs(rotation - minAngle) < upperAngleRange:
					down = true
		iterations += 1
	rotation = 0
	maxAngle=lowerAngleRange
	minAngle=upperAngleRange

func osolate(minAngle:float,maxAngle:float,delta:float)->void:
	if minAngle<1:
		lerp(rotation,maxAngle/2,0.5)
		pass
	if maxAngle>1:
		lerp(rotation,minAngle/2,0.5)
		pass
	if rotation>maxAngle:
		rotate(-delta*speed)
		pass
	if rotation<minAngle:
		rotate(delta*speed)
		pass
