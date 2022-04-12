extends Node2D


export var path_to_animated_sprite: NodePath
onready var animatedSprite = get_node(path_to_animated_sprite) as AnimatedSprite


# Called when the node enters the scene tree for the first time.
func _process(delta):
	if (animatedSprite.animation == "walk_down" || animatedSprite.animation == "walk_up" || animatedSprite.animation == "eat_up" || animatedSprite.animation == "eat_down"):
		rotation = 90
		position = Vector2(0,0)
	else:
		rotation = 0
		position = Vector2(-1,9)
