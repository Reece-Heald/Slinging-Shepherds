extends Node2D

export (int) var grassSpawnSpeed = 60
export (int) var maxNumOfGrass = 6

var screenSizeHoriz
var screenSizeVert
const grassLocation = preload("res://Prefabs/Grass.tscn")
var grassSprite
var numOfGrass = 0
var areaSize


func _ready():
	
	randomize()
	
	areaSize = get_parent().areaSize
	



func _on_grassSpawn_timeout():
	if (numOfGrass < maxNumOfGrass):
		var posHoriz = position.x + ((randf() - .5) * areaSize)
		var posVert = position.y + ((randf() - .5) * areaSize)
		grassSprite = grassLocation.instance()
		grassSprite.set_global_position(Vector2(posHoriz, posVert))
		add_child(grassSprite)
		numOfGrass += 1
