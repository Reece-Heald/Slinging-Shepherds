extends CollisionShape2D

#func _on_Collision_input_event(viewport, event, shape_idx):
#	if event is InputEventMouseButton:
#		if event.is_pressed():
#			get_tree().change_scene("res://path/to/scene.tscn")


func _on_Button_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			get_tree().change_scene("res://Test Room.tscn")
