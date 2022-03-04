extends Node


var bombsInInventory = []

var bombMoving = false

func addBombsInInventory(bomb):
	bombsInInventory.insert(bomb)
	
func getBombsInInventory():
	return self.bombsInInventory

func setBombMoving(input):
	bombMoving = input
func getBombMoving():
	return bombMoving

