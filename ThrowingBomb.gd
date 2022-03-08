extends KinematicBody2D

var xValue  
var yValue

var isRangeBomb = false
var isDamageBomb = false
var isStunBomb = true 

#var singleton = preload("res://GameVarables.gd")

var StationaryBomb =  load("res://StationaryBomb.tscn")
export var _scaleRatio = Vector2(1,1)

var damage = 5
var bombRange = 15
var _speed := 5
var velocity = Vector2(0,0)

var isMoving = true
var targetPosition = GameVarables.targetPos
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
 
func _process(delta):
	 
		var angle = get_angle_to(targetPosition)
		velocity.x = cos(angle)
		velocity.y = sin(angle)
		global_position += velocity * _speed  
#		print(self.global_position)
#		print(angle)
		#var newStationaryBomb 
		#newStationaryBomb = StationaryBomb.instance( )
		#get_parent().add_child(newStationaryBomb)
		#newStationaryBomb.global_postition = self.global_position
		#self.visible = false
		 
		#self.setIsMoving(false)
 
func explode():
	pass







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
