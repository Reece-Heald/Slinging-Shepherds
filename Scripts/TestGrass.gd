extends Node2D

const grassLocation = preload("res://Prefabs/Grass.tscn")
var grassSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		spawnGrass(event.position)

func spawnGrass(var pos):
	var posHoriz = pos.x
	var posVert = pos.y
	grassSprite = grassLocation.instance()
	grassSprite.set_global_position(Vector2(posHoriz, posVert))
	add_child(grassSprite)


func GrassDies():
	pass
