extends Node

export (int) var areaSpawnSpeed = 60
export (int) var areaSize = 60

var screenSizeHoriz
var screenSizeVert
const grassAreaLocation = preload("res://Prefabs/GrassArea.tscn")
var grassArea
var counter

func _ready():
	counter = 0
	
	screenSizeHoriz = get_viewport().get_visible_rect().size.x
	screenSizeVert = get_viewport().get_visible_rect().size.y
	
func _process(delta):
	if (counter > 100):
		var posHoriz = randf() * (screenSizeHoriz - areaSize)
		var posVert = randf() * (screenSizeVert - areaSize)
		grassArea = grassAreaLocation.instance()
		grassArea.set_global_position(Vector2(posHoriz, posVert))
		add_child(grassArea)
		
		counter = 0
	else:
		counter += areaSpawnSpeed * delta
