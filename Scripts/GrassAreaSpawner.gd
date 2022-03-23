extends Node

export (int) var areaSize = 60
export (int) var maxNumOfAreas = 5

var screenSizeHoriz
var screenSizeVert
const grassAreaLocation = preload("res://Prefabs/GrassArea.tscn")
var grassArea
var numOfAreas = 0




func _ready():
	
	randomize()
	
	screenSizeHoriz = get_viewport().get_visible_rect().size.x
	screenSizeVert = get_viewport().get_visible_rect().size.y
	print(screenSizeHoriz)
	print(screenSizeVert)
	


func _on_GrassAreaSpawnTimer_timeout():
	if (numOfAreas < maxNumOfAreas):
		var posHoriz = randf() * (screenSizeHoriz - areaSize) + (.5 * areaSize)
		var posVert = randf() * (screenSizeVert - areaSize) + (.5 * areaSize)
#		print(posHoriz)
		grassArea = grassAreaLocation.instance()
		grassArea.set_global_position(Vector2(posHoriz, posVert))
		add_child(grassArea)
		numOfAreas += 1
	
func _input(event):
   # Mouse in viewport coordinates.
   if event is InputEventMouseButton:
	   print("Mouse Click/Unclick at: ", event.position)
