extends Node

signal grass_entered_chat(grass)
signal grass_left_chat(grass)

var known_grass = []

func _ready():
	connect("grass_entered_chat",self, "_on_grass_entered_chat")
	connect("grass_left_chat",self, "_on_grass_left_chat")

func _on_grass_entered_chat(grass):
	known_grass.append(grass)

func _on_grass_left_chat(grass):
	known_grass.remove(known_grass.find(grass))
