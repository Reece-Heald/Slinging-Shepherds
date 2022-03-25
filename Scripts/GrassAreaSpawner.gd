# What I know about the grass spawning issue:
# all 5 grass areas spawn and all of their positions are in frame
# all 6 grass sprites in each area spawns with positions in frame
# getting mouse position when over a grass sprite returns the correct position
# grass spawned at cursor position is visible


extends Node2D

export (int) var areaSize = 60
export (int) var maxNumOfAreas = 5

var screenSizeHoriz
var screenSizeVert
const grassAreaLocation = preload("res://Prefabs/GrassArea.tscn")
var grassArea
var numOfAreas = 0




func _ready():
	
#	randomize()
	
	screenSizeHoriz = get_viewport().get_visible_rect().size.x
	screenSizeVert = get_viewport().get_visible_rect().size.y
	print("screen size horizontal: ",screenSizeHoriz)
	print("screen size vertical: ",screenSizeVert)
	


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
