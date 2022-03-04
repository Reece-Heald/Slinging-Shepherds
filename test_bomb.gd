extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bomb = load("res://Bomb.tscn")
var targetPost = Vector2(global_position.x+100, global_position.y)
var newBomb = bomb.instance()

var _scaleRatio = Vector2(1,1)
# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().add_child(newBomb)
	
	
func _physics_process(delta):

	pass
	#newBomb.bombThrow(self.global_position,targetPost, scale)
	#newBomb.bombThrow(newBomb.global_position, targetPost)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
