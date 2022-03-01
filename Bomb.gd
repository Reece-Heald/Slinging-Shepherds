extends RigidBody2D

#variables
var xValue  
var yValue

var isRangeBomb = false
var isDamageBomb = false
var isStunBomb = true 

var singleton = preload("res://GameVarables.gd")

export var velocity = 15
export var _scaleRatio = Vector2(1,1)
export var Bomb: PackedScene 

var damage = 5
var bombRange = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	_scaleRatio = _scaleRatio + Vector2(delta,delta)
	
	#bombThrow(Player.postion, target.postition, scale)
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

#func spawn(xValue, yValue):
#	var new_bomb = Bomb.instance()
#	new_bomb.visble = true
#	self.xValue = xValue
#	self.yValue = yValue
#	var pos = Vector2(xValue,yValue)
#	var postion = pos
	
	 #     int,    int,    boolean,  boolean, boolean
func _init(xValue, yValue, isRange, isDamage, isStun):
	self.xValue = xValue
	self.yValue = yValue
	self.isRangeBomb = isRange
	self.isDamageBomb = isDamage
	self.isStunBomb = isStun
	
	
	#broken currently 
	#          Vector2   Vector2
func bombThrow(startPos, targetPos, scale):
	 
 
	#
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
	self.global_position = startPos
	var direction = (targetPos - startPos).normalized()
	self.apply_central_impulse(direction)
	set_scale(_scaleRatio)
	#if bomb gets   to this start shrinking
	if(self.global_postion == midPoint ):
		_scaleRatio = _scaleRatio - Vector2(1,1)
	set_scale(_scaleRatio)
	if(self.global_position == targetPos):
		self.pause_mode = Node.PAUSE_MODE_STOP
		#exploide animation
	
	
	#scaling part 

	
	
	
func getisRange():
	return false
func getIsDamage():
	return false
func getIsStun():
	return false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#commited out until we combined projects
#detects if the body entered by the 2D area is a player if so add it to the array list
func _on_Area2D_body_entered(body):
	if(body is Player):
		singleton.addBombsInInventory(body)
		print("collided with player, adding to singleton list of bombs")
		self.visible = false
		queue_free()
	
