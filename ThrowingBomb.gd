extends KinematicBody2D

var xValue  
var yValue

var isRangeBomb = false
var isDamageBomb = false
var isStunBomb = true 

#var singleton = preload("res://GameVarables.gd")

var StationaryBomb =  load("res://StationaryBomb.tscn")
var bombMidpointDetectionResource = load("res://bombMidpointDetection.tscn")

var bombMidpointDetection  = bombMidpointDetectionResource.instance( )
#var newNode = bombMidpointDetection.new()

var damage = 5
var bombRange = 15
var _speed := 5
var velocity = Vector2(0,0)

var isMoving = true
var targetPosition = GameVarables.targetPos
var midPointPosition = GameVarables.midPointPos

# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_parent().add_child(bombMidpointDetection)
	bombMidpointDetection.set_global_position(midPointPosition)
	
func _init():
	pass
 
func _process(delta): 
	var distance_to_Target = self.global_position.distance_to(targetPosition) 
	var distance_to_midpoint = self.global_position.distance_to(midPointPosition)
	if distance_to_Target > 5:
		
		var angle = get_angle_to(targetPosition)
		velocity.x = cos(angle)
		velocity.y = sin(angle)
		self.scale.x += GameVarables.scaleRatio
		self.scale.y += GameVarables.scaleRatio
		
		#print("the end point is: ", self.global_position)
		#print("the midpoint is: ", midPointPosition)
		#print("distance to mid: ", distance_to_midpoint)
		global_position += velocity * _speed  
#		print(self.global_position)
#		print(angle)
	if distance_to_Target < 5 and is_instance_valid(bombMidpointDetection):
		bombMidpointDetection.queue_free()
		#self.visible = false

		#self.setIsMoving(false)
 
func explode():
	pass



func noMove():
	var newStationaryBomb 
	newStationaryBomb = StationaryBomb.instance( )
	get_parent().add_child(newStationaryBomb)
	newStationaryBomb.set_global_position(self.global_position)
	self.visible = false

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
