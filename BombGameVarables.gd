extends Node


var bombsInInventory = []

var bombMoving = false

var targetPos = Vector2()

var midPointPos = Vector2()

var scaleRatio = 0

var isFuseLit = false

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
