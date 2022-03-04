extends KinematicBody2D

var xValue  
var yValue

var isRangeBomb = false
var isDamageBomb = false
var isStunBomb = true 

#var singleton = preload("res://GameVarables.gd")


export var _scaleRatio = Vector2(1,1)

var damage = 5
var bombRange = 15
var _speed := 5
var velocity = Vector2(0,0)

var isMoving = false
var targetPosition = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	print("test")
	
	
	
func setIsMoving(input):
	self.isMoving = input
	print("is move is set to ", input)

func _process(delta):
	var processMove = isMoving
	if processMove == true:
		print("bomb move")
		var angle = get_angle_to(targetPosition)
		velocity.x = cos(angle)
		velocity.y = sin(angle)
		global_position += velocity * _speed  
		#self.setIsMoving(false)
		
func bombThrow(startPos, targetPos):
	self.targetPosition = targetPos
	#first pos
	var startPosX = startPos.x 
	var startPosY = startPos.y
	#second pos
	var targetPosX = targetPos.x
	var targetPosY = targetPos.y
	
	#|ab| = sqrt(sqr(b.x - a.x) + sqr(b.y - a.y))
	var middleOfLineX = ceil(abs(sqrt(pow(targetPosX - startPosX,2))))
	var middleOfLineY  = ceil(abs(sqrt(pow(targetPosY - startPosY,2))))
	var midPoint = Vector2(middleOfLineX, middleOfLineY)
	
	setIsMoving(true)
	print(isMoving)
	self.global_position = startPos

	
	
	#movement part
	
	
	


func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		GameVarables.addBombsInInventory(body)
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
