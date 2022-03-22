extends Node


var bombsInInventory = []

var bombMoving = false

var targetPos = Vector2()

var midPointPos = Vector2()

var scaleRatio = 0

func addBombsInInventory(bomb):
	bombsInInventory.insert(bomb)
	
func getBombsInInventory():
	return self.bombsInInventory

func setBombMoving(input):
	bombMoving = input
func getBombMoving():
	return bombMoving


