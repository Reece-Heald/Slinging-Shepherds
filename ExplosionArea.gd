extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ExplosionArea_body_entered(body):
	if body.name == "testDummy":
		print(body, "has been damaged by bomb")
		self.queue_free()
		self.visible = false
	 # Replace with function body.
