extends Node2D

var frontMesh:MeshInstance2D
var backMesh:MeshInstance2D

var frontPolygon:Polygon2D
var backPolygon:Polygon2D

var topLeft:StaticBody2D
var topRight:StaticBody2D
var midRight:RigidBody2D
var midLeft:RigidBody2D
var bottomRight:RigidBody2D
var bottomLeft:RigidBody2D

var frontPositionDifferenceArray:Array[Vector2]
var backPositionDifferenceArray:Array[Vector2]

func _ready() -> void:
	
	topLeft=$topLeft
	topRight=$topRight
	midLeft=$midLeft
	midRight=$midRight
	bottomLeft=$bottomLeft
	bottomRight=$bottomRight
	
	#frontPolygon=$frontPolygon
	backPolygon= $Polygon2D3
	
	initiatePoligonArray(frontPositionDifferenceArray)

func _process(_delta: float) -> void:
	updateMeshPositions($frontPolygon,frontPositionDifferenceArray)
	#print(frontPositionDifferenceArray)
	#testUVMaping(frontPositionDifferenceArray)
	#frontPolygon.polygon=frontPositionDifferenceArray
	#frontPolygon.
	pass

func getGlobalPointPosition()->void:
	
	pass

func initiatePoligonArray(differenceArray:Array[Vector2])->void:
	#print($frontPolygon.polygon[0],$frontPolygon.global_position,topLeft.global_position,topLeft.position)
	differenceArray.append(-$frontPolygon.global_position+(topLeft.global_position))
	differenceArray.append(-$frontPolygon.global_position+(midLeft.global_position))
	differenceArray.append(-$frontPolygon.global_position+(bottomLeft.global_position))
	differenceArray.append(-$frontPolygon.global_position+(bottomRight.global_position))
	differenceArray.append(-$frontPolygon.global_position+(midRight.global_position))
	differenceArray.append(-$frontPolygon.global_position+(topRight.global_position))
	#differenceArray.append($frontPolygon.polygon[5]+$frontPolygon.global_position-(topRight.global_position-topRight.position)+Vector2.RIGHT*80)
	#differenceArray.append()

func testUVMaping(differenceArray:Array[Vector2])->void:
	#differenceArray[0]=$frontPolygon.polygon[0]-(topLeft.global_position-topLeft.position)
	##differenceArray[0]=frontPolygon.polygon[0]-(topLeft.global_position-topLeft.position)
	#differenceArray[3]=$frontPolygon.polygon[1]-(midLeft.global_position-midLeft.position)
	#differenceArray[4]=$frontPolygon.polygon[2]-(bottomLeft.global_position-bottomLeft.position)
	#differenceArray[3]=$frontPolygon.polygon[3]-(bottomRight.global_position-bottomRight.position)
	#differenceArray[2]=$frontPolygon.polygon[4]-(midRight.global_position-midRight.position)
	#differenceArray[1]=$frontPolygon.polygon[5]-(topRight.global_position-topRight.position)
	#frontPolygon.uv[0]=topLeft.position
	#frontPolygon.uv[1]=midLeft.position
	#frontPolygon.uv[2]=bottomLeft.position
	#frontPolygon.uv[3]=bottomRight.position
	#frontPolygon.uv[4]=midRight.position
	#frontPolygon.uv[5]=topRight.position
	#frontPolygon.uv=uvArray
	pass

func updateMeshPositions(polygon:Polygon2D,meshArray:Array)->void:
	#print(polygon.get_polygon())
	polygon.set_polygon(meshArray)
	#print($frontPolygon.polygon[0])
	meshArray[0]=lerp(meshArray[0],-$frontPolygon.global_position+(topLeft.global_position),1)
	meshArray[1]=lerp(meshArray[0],-$frontPolygon.global_position+(midLeft.global_position),1)
	meshArray[2]=lerp(meshArray[0],-$frontPolygon.global_position+(bottomLeft.global_position),1)
	meshArray[3]=lerp(meshArray[0],-$frontPolygon.global_position+(bottomRight.global_position),1)
	meshArray[4]=lerp(meshArray[0],-$frontPolygon.global_position+(midRight.global_position),1)
	meshArray[5]=lerp(meshArray[0],-$frontPolygon.global_position+(topRight.global_position),1)
	#var tempArray:Array=mesh.mesh.get_mesh_arrays()
	#print(mesh.mesh.get_mesh_arrays())
	#mesh.global_position
	#print(mesh.global_position)
	#tempArray.map(translateToGlobal.bind(mesh.global_position))
	#print(tempArray)
	pass
	
func translateToGlobal(position:Vector2,meshPosition:Vector2)->Vector2:
	#print(position,meshPosition)
	return position+meshPosition
