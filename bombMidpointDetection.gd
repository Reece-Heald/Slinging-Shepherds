extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var bomb =  load("res://ThrowingBomb.gd")

# Called when the node enters the scene tree for the first time.
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func destroy_self():
	self.queue_free()

func _on_Area2D_area_entered(area):
	#print(area.name)
	if(area.name == "ThrowingBombArea"):
		BombGameVarables.scaleRatio = -.05
		BombGameVarables.isFuseLit = true
	#print("bomb collided with midpoint ")
	#print(bomb)
