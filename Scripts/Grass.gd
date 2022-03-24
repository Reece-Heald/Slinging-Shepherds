extends Sprite

var grow1 = preload("res://Sprites/Grass/Grass1.png")
var grow2 = preload("res://Sprites/Grass/Grass2.png")
var grow3 = preload("res://Sprites/Grass/Grass3.png")

export (int) var timeToSprite2 = 3
export (int) var timeToSprite3 = 6
export (int) var timeToDeath = 10

var stage = 1

func _ready():
	set_texture(grow1)
	print("grass spawns: ", position)



# every second
func _on_Timer_timeout():
	if (stage == timeToSprite2):
		set_texture(grow2)
	if (stage == timeToSprite3):
		set_texture(grow3)
	if (stage == timeToDeath):
		$Timer.stop()
		get_parent().GrassDies()
		print("grass dies: ", position)
		queue_free()
	stage += 1
