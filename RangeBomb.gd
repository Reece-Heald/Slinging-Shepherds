extends "res://Bomb.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


#bombRange = 12

func _init(args).(5,5,true,false,false):
   get_parent().bombRange = 12

# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.

func getIsRange():
	return true


	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
