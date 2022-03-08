extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ThrowingBomb = load("res://ThrowingBomb.tscn")
#var singleton = preload("res://GameVarables.gd")
var targetPost = Vector2(global_position.x+100, global_position.y)


var _scaleRatio = Vector2(1,1)
# Called when the node enters the scene tree for the first time.
func _ready():

	var newBomb = ThrowingBomb.instance()
	get_parent().add_child(newBomb)
	#print(newBomb.global_position)
	newBomb.global_position = Vector2(300,300)
	#newBomb.bombThrow(newBomb.global_position, targetPost)
	
func _physics_process(delta):
	#pass
	#newBomb.bombThrow(self.global_position,targetPost, scale)
	#newBomb.bombThrow(newBomb.global_position, targetPost)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	pass
