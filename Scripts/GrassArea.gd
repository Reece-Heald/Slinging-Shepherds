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
#	print("Grass area spawned: ", position)
	
	areaSize = get_parent().areaSize
	


# run every time timer ends
func _on_grassSpawn_timeout():
	if (numOfGrass < maxNumOfGrass):
#		var posHoriz = position.x + ((randf() - .5) * areaSize)
#		var posVert = position.y + ((randf() - .5) * areaSize)
		var posHoriz = (randf() - .5) * areaSize
		var posVert = (randf() - .5) * areaSize
		grassSprite = grassLocation.instance()
		grassSprite.set_global_position(Vector2(posHoriz, posVert))
		add_child(grassSprite)
		numOfGrass += 1
#	else:
#		get_children()[0].stop()

func GrassDies():
	numOfGrass -= 1
