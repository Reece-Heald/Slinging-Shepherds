extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bomb = load("res://Bomb.tscn")
var targetPost = Vector2(global_position.x+100, global_position.y)

var _scaleRatio = Vector2(1,1)
# Called when the node enters the scene tree for the first time.
func _ready():
	var newBomb = bomb.instance()
	get_parent().add_child(newBomb)
	#newBomb.bombThrow(self.global_position,targetPost, scale)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
