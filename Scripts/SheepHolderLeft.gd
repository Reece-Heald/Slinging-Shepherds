extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (get_children().size() == 0):
		get_tree().change_scene("res://Prefabs/PlayerTwoWins.tscn")
