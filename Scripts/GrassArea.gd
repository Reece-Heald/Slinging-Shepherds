extends Node2D

export (int) var grassSpawnSpeed = 60

var screenSizeHoriz
var screenSizeVert
const grassLocation = preload("res://Prefabs/Grass.tscn")
var grassSprite
var counter
var areaSize


func _ready():
	areaSize = get_parent().areaSize
	counter = 0
	
	screenSizeHoriz = get_viewport().get_visible_rect().size.x
	screenSizeVert = get_viewport().get_visible_rect().size.y
	
func _process(delta):
	if (counter > 100):
		var posHoriz = position.x + (randf() - .5) * areaSize
		var posVert = position.y + (randf() - .5) * areaSize
		#var posHoriz = screenSizeHoriz * randf()
		#var posVert = screenSizeVert * randf()
		grassSprite = grassLocation.instance()
		grassSprite.set_global_position(Vector2(posHoriz, posVert))
		add_child(grassSprite)
		
		counter = 0
	else:
		counter += grassSpawnSpeed * delta
