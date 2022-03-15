extends Node

export (int) var spawnSpeed = 5

var screenSizeHoriz
var screenSizeVert
const grassLocation = preload("res://Prefabs/Grass.tscn")
var grassSprite
var counter

func _ready():
	counter = 0
	
	screenSizeHoriz = get_viewport().get_visible_rect().size.x
	screenSizeVert = get_viewport().get_visible_rect().size.y
	
func _process(delta):
	if (counter > 100):
		var posHoriz = randf() * screenSizeHoriz
		var posVert = randf() * screenSizeVert
		grassSprite = grassLocation.instance()
		grassSprite.set_global_position(Vector2(posHoriz, posVert))
		add_child(grassSprite)
		
		counter = 0
	else:
		counter += spawnSpeed * delta
