extends Particles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var smoke = $"SmokeEffect"

# Called when the node enters the scene tree for the first time.
func _init():
	self.set_emitting(true)
	self.set_one_shot(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	print("time one")
	#self.hide()
	self.set_emitting(false)
	self.visible = false
	self.queue_free()
	print(self.visible)
	
	
 
