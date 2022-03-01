extends Node


var bombsInInventory = []


func addBombsInInventory(bomb):
	bombsInInventory.insert(bomb)
	
func getBombsInInventory():
	return self.bombsInInventory




