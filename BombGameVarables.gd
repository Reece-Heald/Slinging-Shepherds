extends Node


var bombsInInventory = []

var bombMoving = false

var targetPos = Vector2()

var midPointPos = Vector2()

var scaleRatio = 0

var isFuseLit = false

#onready var sheep = preload("res://Prefabs/Sheep.tscn")

#can only be 
# "n" = normalBomb 
# "x" = xbomb 
# "f" = fireBomb 
# "s" = smokeBomb 
var bombType = []

func addBombTypeInInventory(bombType):
	bombType.append(bombType)

func addBombsInInventory(bomb):
	bombsInInventory.append(bomb)
	
func getBombsInInventory():
	return self.bombsInInventory

func setBombMoving(input):
	bombMoving = input
func getBombMoving():
	return bombMoving

func getIsFuseLit():
	return isFuseLit

