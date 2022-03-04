extends KinematicBody2D

var xValue  
var yValue

var isRangeBomb = false
var isDamageBomb = false
var isStunBomb = true 

var singleton = preload("res://GameVarables.gd")

export var velocity = 15
export var _scaleRatio = Vector2(1,1)

var damage = 5
var bombRange = 15
# Called when the node enters the scene tree for the first time.
func _ready():
	print("test")
	
	 # Replace with function body.



func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		singleton.addBombsInInventory(body)
		print("collided with player, adding to singleton list of bombs")
		self.visible = false
		queue_free()




#Getters and setters 
func getX():
	return xValue

func getY():
	return yValue
	
func setX(value):
	self.xValue = value

func setY(value):
	self.yValue = value

func getisRange():
	return false
func getIsDamage():
	return false
func getIsStun():
	return false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
