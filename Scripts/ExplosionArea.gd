extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var sheep = load("res://Scripts/Sheep.gd")

# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
onready var sheep = preload("res://Prefabs/Sheep.tscn")


func _on_ExplosionArea_body_entered(body):
	#print(body)
	if body.is_in_group("Sheep"):
		#print("Sheep die")
		body.take_damage()
		#BombGameVarables.sheep_hurt()
		self.queue_free()
		self.visible = false
	
	 # Replace with function body.

