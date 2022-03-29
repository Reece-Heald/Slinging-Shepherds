extends Node2D

export (int) var grassSpawnSpeed = 60
export (int) var maxNumOfGrass = 6

var screenSizeHoriz
var screenSizeVert
const grassLocation = preload("res://Prefabs/Grass.tscn")
var grassSprite
var numOfGrass = 1
var areaSize


func _ready():
	areaSize = get_parent().areaSize
	create_grass()

# run every time timer ends
func _on_grassSpawn_timeout():
	if (numOfGrass == 0):
		destroy_area()
	if (numOfGrass < maxNumOfGrass):
		numOfGrass += 1
		create_grass()


func grass_dies():
	numOfGrass -= 1


func create_grass():
	var posHoriz = (randf() - .5) * areaSize
	var posVert = (randf() - .5) * areaSize
	grassSprite = grassLocation.instance()
	grassSprite.set_global_position(Vector2(posHoriz, posVert))
	add_child(grassSprite)

func destroy_area():
	get_parent().grass_area_destroyed()
	queue_free()


