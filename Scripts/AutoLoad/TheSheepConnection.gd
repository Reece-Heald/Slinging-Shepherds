extends Node

signal grass_entered_chat(grass)
signal grass_left_chat(grass)

var p1_sheep_count = -1
var p2_sheep_count = -1

func add_sheep(player_num):
	if player_num == 1:
		if p1_sheep_count == -1:
			p1_sheep_count = 1
		else:
			p1_sheep_count += 1
	
	if player_num == 2:
		if p2_sheep_count == -1:
			p2_sheep_count = 1
		else:
			p2_sheep_count += 1

func subtract_sheep(player_num):
	if player_num == 1: p1_sheep_count -= 1
	if player_num == 2: p2_sheep_count -= 1
	
	if p1_sheep_count == 0:
		#goto end screen
		get_tree().change_scene("res://Prefabs/PlayerTwoWins.tscn")
	if p2_sheep_count == 0:
		#goto end screen
		get_tree().change_scene("res://Prefabs/PlayerOneWins.tscn")
