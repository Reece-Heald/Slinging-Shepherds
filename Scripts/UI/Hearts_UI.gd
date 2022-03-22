extends Control
class_name HeartUI

export var heart_1 : NodePath
export var heart_2 : NodePath
export var heart_3 : NodePath

var heart_sprites : Array


func _ready():
	PlayerHead.connect_heart_ui(self)
	heart_sprites = [heart_1, heart_2, heart_3]
	update_hearts()

func update_hearts():
	var health = PlayerHead.get_health()
	for i in range(PlayerHead.MAX_HEALTH):
		if health > i:
			var frame = 0 if i%2 == 1 else 1
			get_node(heart_sprites[int(i/2)]).frame = frame
		else:
			if i % 2 == 1 : i+=1 #if we updated half of a heart last time then move to the next heart
			if i >= PlayerHead.MAX_HEALTH : return #if everything is updated return
			get_node(heart_sprites[int(i/2)]).frame = 2
