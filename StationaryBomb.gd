extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _init(position):
	self.global_position = position
	
	
	
func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		GameVarables.addBombsInInventory(body)
		print("collided with player, adding to singleton list of bombs")
		self.visible = false
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
