extends KinematicBody2D

var xValue  
var yValue

var isRangeBomb = false
var isDamageBomb = false
var isStunBomb = true 

var singleton = preload("res://GameVarables.gd")


export var _scaleRatio = Vector2(1,1)

var damage = 5
var bombRange = 15
var _speed := 5
var velocity = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("test")
	
	
	 # Replace with function body.

func _physics_process(delta):
	#velocity.x =+ _speed
	#move_and_collide(velocity)
	#print(global_position.x,global_position.y)
	var angle = get_angle_to(Vector2(300,300))
	velocity.x = cos(angle)
	velocity.y = sin(angle)
	global_position += velocity * _speed  
	
func bombThrow(startPos, targetPos):
	
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
	
	
	
	#movement part
	#self.global_position = startPos
	var direction = (targetPos - startPos).normalized()
	


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
