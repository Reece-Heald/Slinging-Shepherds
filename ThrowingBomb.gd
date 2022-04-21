extends KinematicBody2D

var StationaryBomb =  load("res://Prefabs/StationaryBomb.tscn")
var bombMidpointDetectionResource = load("res://bombMidpointDetection.tscn")

var explosionArea = load("res://Prefabs/ExplosionArea.tscn")
var smokeEffect = load("res://Prefabs/smokeExplosion.tscn")

onready var _animated_fuse = $"AnimatedSprite"
onready var _animated_explosion = $"AnimatedSprite2"


onready var default_sprite = $"Sprite"
onready var fireBomb_Sprite = load("res://Assets/Bombs/Firebomb.png")
onready var smokeBomb_Sprite = load("res://Assets/Bombs/SmokeBomb.png")
onready var xBomb_Sprite = load("res://Assets/Bombs/Xbomb.png")
 
var bombMidpointDetection  = bombMidpointDetectionResource.instance( )

var numOfXBombs = 0
var numOfFireBombs = 0
var numOfSmokeBombs = 0
#var numOfNorBombs = 0

var currBombType = ""
var isHit = false

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
	numOfFireBombs = 0
	numOfSmokeBombs = 0
	numOfXBombs = 0
	#changeSprite()
	default_sprite.visible = true
	#print(name)
	resetBombSprite()

	
	
	
func _process(delta): 
	var distance_to_Target = self.global_position.distance_to(targetPosition) 
	#var distance_to_midpoint = self.global_position.distance_to(midPointPosition)
	if distance_to_Target > 5:
		var angle = get_angle_to(targetPosition)
		velocity.x = cos(angle)
		velocity.y = sin(angle)
		
		self.scale.x += BombGameVarables.scaleRatio
		self.scale.y += BombGameVarables.scaleRatio
		
		
		#print("the end point is: ", self.global_position)
		#print("the midpoint is: ", midPointPosition)
		#print("distance to mid: ", distance_to_midpoint)
		global_position += velocity * delta
		global_position += velocity * _speed 
		#print("velocity: " , velocity)
		#print("delta:" ,delta)
	if BombGameVarables.isFuseLit == true:
		#print(currBombType)
		if currBombType == "norm":
			litNorBomb()
		if currBombType == "fire":
			litFireBomb()
		if currBombType == "smoke":
			litSmokeBomb()
		if currBombType == "x":
			litXBomb()
	#if distance_to_Target < 5 and is_instance_valid(bombMidpointDetection):
		
	if distance_to_Target < 5 && isHit == false:
		hitTarget()
		bombMidpointDetection.queue_free()
		bombMidpointDetection.destroy_self()
		#self.visible = false
		
		#self.setIsMoving(false)

func hitTarget():
	#var distance_to_Target = self.global_position.distance_to(targetPosition) 
	#print("hit target")
	
	if(currBombType == "smoke"):
		#print("lmao smoke bomb go smmmmmmoke") 
		_animated_fuse.visible = false
		var newSmoke = smokeEffect.instance()
		newSmoke.global_position = self.global_position
		get_parent().add_child(newSmoke)
		#var timer = Timer.new()
		#newSmoke.add_child(timer)
		#timer.set_wait_time(3)
		#timer.connect("timeout", self, "noMoreSmoke")

		#newSmoke.queue_free()
		
	else:
		_animated_explosion.visible = true
		_animated_fuse.visible = false
		_animated_explosion.play("explosion")
		default_sprite.visible = false
		if _animated_explosion.playing == false:
			self.queue_free()
	
	
		var newExplosion = explosionArea.instance()
		newExplosion.global_position = self.global_position
		get_parent().add_child(newExplosion)
	isHit = true
	_animated_fuse.visible = false
	
func litNorBomb( ):
	#print("norm fuse animation")
	default_sprite.visible = false
	_animated_fuse.visible = true
	_animated_fuse.play("litFuse")
func litFireBomb():
	#print("fire fuse animation")	
	default_sprite.visible = false
	_animated_fuse.visible = true
	_animated_fuse.play("fireFuse")
func litSmokeBomb():
	#print("SMOKE fuse animation")
	default_sprite.visible = false
	_animated_fuse.visible = true
	_animated_fuse.play("smokeFuse")
func litXBomb():
	#print("x fuse animation")
	default_sprite.visible = false
	_animated_fuse.visible = true
	_animated_fuse.play("xFuse")
func resetBombSprite():
	_animated_fuse.visible = false
	_animated_explosion.visible = false
	default_sprite.visible = true 
	
func changeSprite():
	#print("start  ---------------------------------------")
	calculateBombNumbers()
	#print("fire  ", numOfFireBombs)
	#print("x  ", numOfXBombs)
	#print("smoke  ", numOfSmokeBombs)
	if numOfFireBombs >= 2:
		default_sprite.set_texture(fireBomb_Sprite)
		currBombType = "fire"
	elif numOfXBombs >= 2:
		default_sprite.set_texture(xBomb_Sprite)
		currBombType = "x"
	elif numOfSmokeBombs >= 2: 
		default_sprite.set_texture(smokeBomb_Sprite)
		currBombType = "smoke"
	elif numOfFireBombs == 0 && numOfSmokeBombs == 0 && numOfXBombs == 0: 
		currBombType = "norm"

	#sprites for if there is only one bomb in inventory 
	 
	elif numOfFireBombs == 0 && numOfSmokeBombs == 0 && numOfXBombs == 1:
 
		currBombType = "x"
	elif numOfFireBombs == 0 && numOfSmokeBombs == 1 && numOfXBombs == 0:
		 
		currBombType = "smoke"
	elif numOfFireBombs == 1  && numOfSmokeBombs == 0 && numOfXBombs == 0:
		 
		currBombType = "fire"
	numOfFireBombs = 0
	numOfSmokeBombs = 0
	numOfXBombs = 0
	#print("end  ---------------------------------------")

func calculateBombNumbers():
	var bombTypeArr = BombGameVarables.bombType
	
	for type in bombTypeArr:
		
		if(type == "f"):
			numOfFireBombs += 1
			
		if(type == "x"):
			numOfXBombs += 1
			
		if(type == "s"):
			numOfSmokeBombs += 1
			
	BombGameVarables.bombType.clear()
	#print("bomb array: ", bombTypeArr)
	#print("num of x: ", numOfXBombs)
	#print("num of fire: ", numOfFireBombs)
	#print("num of Smoke: ", numOfSmokeBombs)
		
 
