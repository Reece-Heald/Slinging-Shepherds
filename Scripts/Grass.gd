extends Sprite

var grow1 = preload("res://Sprites/Grass/Grass1.png")
var grow2 = preload("res://Sprites/Grass/Grass2.png")
var grow3 = preload("res://Sprites/Grass/Grass3.png")

var counter
export (int) var timeToSprite2 = 100
export (int) var timeToSprite3 = 200

func _ready():
	counter = 0
	set_texture(grow1)

func _process(delta):
	if (counter > timeToSprite2):
		set_texture(grow2)
	if (counter > timeToSprite3):
		set_texture(grow3)
	counter += delta
