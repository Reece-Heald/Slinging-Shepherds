extends KinematicBody2D

var xValue  
var yValue

var isRangeBomb = false
var isDamageBomb = false
var isStunBomb = true 

#var singleton = preload("res://GameVarables.gd")

var StationaryBomb =  load("res://StationaryBomb.tscn")
var bombMidpointDetectionResource = load("res://bombMidpointDetection.tscn")

var explosionArea = load("res://ExplosionArea.tscn")

onready var _animated_fuse = $"AnimatedSprite"
onready var _animated_explosion = $"AnimatedSprite2"
onready var default_sprite = $"Sprite"
 
var bombMidpointDetection  = bombMidpointDetectionResource.instance( )
#var newNode = bombMidpointDetection.new()

var damage = 5
var bombRange = 15
var _speed := 5
var velocity = Vector2(0,0)

var isMoving = true
var targetPosition = BombGameVarables.targetPos
var midPointPosition = BombGameVarables.midPointPos

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().add_child(bombMidpointDetection)
	bombMidpointDetection.set_global_position(midPointPosition)
	default_sprite.visible = true
	#print(name)
	resetBombSprite()
func _init():
	#$"AnimatedSprite".play() 
	#self.name = "ThrowingBomb"
	#_animated_explosion.visible = false
	#default_sprite.visible = true 
	pass
	
	
	
	
func _process(delta): 
	var distance_to_Target = self.global_position.distance_to(targetPosition) 
	#var distance_to_midpoint = self.global_position.distance_to(midPointPosition)
	if distance_to_Target > 5:
		var angle = get_angle_to(targetPosition)
		velocity.x = cos(angle)
		velocity.y = sin(angle)
		self.scale.x += BombGameVarables.scaleRatio
		self.scale.y += BombGameVarables.scaleRatio
		#_speed = _speed * delta
		#print("the end point is: ", self.global_position)
		#print("the midpoint is: ", midPointPosition)
		#print("distance to mid: ", distance_to_midpoint)
		global_position += velocity * _speed 
#		print(self.global_position)
#		print(angle)
	if BombGameVarables.isFuseLit == true:
		litBomb()
	if distance_to_Target < 5 and is_instance_valid(bombMidpointDetection):
		bombMidpointDetection.queue_free()
		bombMidpointDetection.destroy_self()
	if distance_to_Target < 5:
		hitTarget()
		#self.visible = false
		
		#self.setIsMoving(false)

func hitTarget():
	#var distance_to_Target = self.global_position.distance_to(targetPosition) 
	#print("hit target")
	_animated_explosion.visible = true
	_animated_fuse.visible = false
	_animated_explosion.play("explosion")
	if _animated_explosion.playing == false:
		self.queue_free()
	
	
	var newExplosion = explosionArea.instance()
	newExplosion.global_position = self.global_position
	get_parent().add_child(newExplosion)
	
func litBomb( ):
	default_sprite.visible = false
	_animated_fuse.visible = true
	_animated_fuse.play("litFuse")

func resetBombSprite():
	_animated_fuse.visible = false
	_animated_explosion.visible = false
	default_sprite.visible = true 



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
