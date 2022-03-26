# What I know about the grass spawning issue:
# not all grass spawned can be seen in the player view
# when the player view is expanded some more grass can be seen?
# when player view is expanded and new area clicked on it has unusual x/y position
# all 5 grass areas spawn and all of their x/y positions are numerically in frame
# all 6 grass sprites in each area spawns with x/y positions numerically in frame
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


var posHoriz = -10
var posVert = -10

func _ready():
	randomize()
	
	screenSizeHoriz = get_viewport().get_visible_rect().size.x
	screenSizeVert = get_viewport().get_visible_rect().size.y
#	print("screen size horizontal: ", screenSizeHoriz)
#	print("screen size vertical: ", screenSizeVert)
	

func _draw():
	draw_circle(Vector2(posHoriz,posVert), 5, Color(0.55, 0, 0, 1))

func _on_GrassAreaSpawnTimer_timeout():
	if (numOfAreas < maxNumOfAreas):
		posHoriz = randf() * (screenSizeHoriz - areaSize) + (.5 * areaSize)
		posVert = randf() * (screenSizeVert - areaSize) + (.5 * areaSize)
		grassArea = grassAreaLocation.instance()
		grassArea.set_global_position(Vector2(posHoriz, posVert))
		add_child(grassArea)
		numOfAreas += 1
		_draw()
		update()
	
#func _input(event):
#   # Mouse in viewport coordinates.
#   if event is InputEventMouseButton:
#	   print("Mouse Click/Unclick at: ", event.position)
