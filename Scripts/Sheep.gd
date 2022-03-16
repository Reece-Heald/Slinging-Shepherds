extends KinematicBody2D

export (int) var speed = 5
export (int) var rotateSpeed = 100;

var velocity = Vector2()

var counter = rotateSpeed

func _ready():
	pass

func _physics_process(delta):
#	print(delta)
	if (counter > rotateSpeed-1):
		move()
		counter = 0
	else:
		counter += 1
	move_and_slide(velocity*delta*1000)


func move():
	var directionX = randf()*2 - 1
	var directionY = randf()*2 - 1

	if (position.x >= 900 && directionX > 0):
		directionX *= -1;
	if (position.x <= 125 && directionX < 0):
		directionX *= -1;
	if (position.y >= 475 && directionY > 0):
		directionY *= -1;
	if (position.y <= 125 && directionY < 0):
		directionY *= -1;
	
	velocity.x = directionX
	velocity.y = directionY
	velocity = velocity.normalized() * speed

