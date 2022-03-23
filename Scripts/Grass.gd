extends Sprite

var grow1 = preload("res://Sprites/Grass/Grass1.png")
var grow2 = preload("res://Sprites/Grass/Grass2.png")
var grow3 = preload("res://Sprites/Grass/Grass3.png")

export (int) var timeToSprite2 = 2
export (int) var timeToSprite3 = 4

func _ready():
	set_texture(grow1)
	print("grass spawns:", position)


func _on_Timer_timeout():
	if (texture.get_width() == grow1.get_width()):
		set_texture(grow2)
	if (texture.get_width() == grow2.get_width()):
		set_texture(grow3)
	if (texture.get_width() == grow3.get_width()):
		$Timer.stop()
