extends Node2D

export (int) var areaSize = 60
export (int) var maxNumOfAreas = 5
# determines which side of the screen the area spawns on
enum LeftRight {Left = 0, Right = 1}
export(LeftRight) var leftRight


const grassAreaLocation = preload("res://Prefabs/GrassArea.tscn")
var grassArea
var numOfAreas = 0

# never modified, determined by screen size
var screenSizeHoriz
var screenSizeVert
# modified at the beginning, determined by Left or Right
var leftRightMod
# to be modified every time a new random grass area spawns
var posHoriz = -10
var posVert = -10

func _ready():
	randomize()
	
	screenSizeHoriz = get_viewport().get_visible_rect().size.x
	screenSizeVert = get_viewport().get_visible_rect().size.y
	
	if (leftRight == LeftRight.Right):
		leftRightMod = screenSizeHoriz * .5
	else:
		leftRightMod = 0

#func _draw():
#	draw_circle(Vector2(posHoriz,posVert), 5, Color(0.55, 0, 0, 1))

func _on_GrassAreaSpawnTimer_timeout():
	if (numOfAreas < maxNumOfAreas):
		posHoriz = ( randf() * ((screenSizeHoriz * .5) - areaSize) + (.5 * areaSize) ) + (leftRightMod)
		posVert = randf() * (screenSizeVert - areaSize) + (.5 * areaSize)
		
		grassArea = grassAreaLocation.instance()
		grassArea.set_global_position(Vector2(posHoriz, posVert))
		grassArea.set_grow_timer(get_node("grassGrow"))
		add_child(grassArea)
		$grassSpawn.connect("timeout", grassArea, "_on_grassSpawn_timeout")
		numOfAreas += 1
#		update()

func grass_area_destroyed():
	numOfAreas -= 1
