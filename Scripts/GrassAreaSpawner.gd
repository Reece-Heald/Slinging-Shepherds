extends Node

export (int) var areaSize = 60
export (int) var maxNumOfAreas = 5

var screenSizeHoriz
var screenSizeVert
const grassAreaLocation = preload("res://Prefabs/GrassArea.tscn")
var grassArea
var counter
var numOfAreas = 0




func _ready():
	counter = 0
	
	screenSizeHoriz = get_viewport().get_visible_rect().size.x
	screenSizeVert = get_viewport().get_visible_rect().size.y


func _on_GrassAreaSpawnTimer_timeout():
	if (numOfAreas < maxNumOfAreas):
		var posHoriz = randf() * (screenSizeHoriz - areaSize)
		var posVert = randf() * (screenSizeVert - areaSize)
		grassArea = grassAreaLocation.instance()
		grassArea.set_global_position(Vector2(posHoriz, posVert))
		add_child(grassArea)
		numOfAreas += 1
