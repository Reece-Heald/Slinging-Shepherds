extends KinematicBody2D
class_name Player

#player movement parameters
export var run_speed = 5.0
export var slow_down_power = 1.0
export var stop_radius = 16
export var walk_radius = 256
export var sprite_turn_threshold : float = PI/3 #in radiants

#player throwing parameters
export var draw_back_scale = 60.0
export var draw_back_power = .75
export var no_throw_radius = 32
export var line_color : Color = Color(1,1,1)
export var line_width = 5
export var dot_color : Color = Color(1,1,1)
export var dot_radius = 5

#player movement / sprite direction variables
var mouse_pos : Vector2
var direction_real : Vector2 = Vector2(0,0) #any angle
var direction_sprite : Vector2 = Vector2(0,0) #only up down left right
var rotational_offset = 0
var bomb = load("res://Bomb.tscn") as PackedScene 
#var bomb_script = load("res://StunBomb.gd") as Script

#bomb variables
var ThrowingBomb = load("res://ThrowingBomb.tscn")
var bomb_speed := 5
var bomb_velocity = Vector2(0,0)
var targetPosition = Vector2(444,333)


#flags and such
enum {IDLE, MOVING, THROWING, STOPPED}
var state = IDLE
#player movement flags
var is_mouse_in_stop_zone = false
var is_mouse_on_screen = false
#player throwing flags
var is_in_no_throw_zone = false

#throwing variables
var init_mouse_pos : Vector2 = Vector2(0,0)
var throw_end_pos : Vector2

func _ready():
	set_process(true)

func _process(delta):
	if state == IDLE or state == MOVING:
		follow_mouse()
		
	
	if state == THROWING:
		update() #keeps drawing if throwing is happening
	
	update_direction()
	update_sprite()

func follow_mouse():
	#make sure mousepos exists
	#and make sure mouse is on screen
	if mouse_pos != null and is_mouse_on_screen:
		#get our mouse pos - our pos
		var diff : Vector2 = mouse_pos - position
		#stop if we are in the stop area
		var diff_length = diff.length()
		if diff_length < stop_radius : 
			state = IDLE
			return
		#define speed based on position
		var current_speed = run_speed
		if diff_length < walk_radius : 
			#calculate percentage distance to stopping
			var p = diff_length / walk_radius
			current_speed = run_speed * pow(p,slow_down_power) #speed based on distance to stop & slow down power
		#change angle into vector of length 1
		diff = diff.normalized()
		#move in that direction time speed
		direction_real = move_and_slide(diff * current_speed).normalized()
		if direction_real == Vector2(0,0) : state = IDLE
		else: state = MOVING
	else:
		state = IDLE
		

func update_direction():
	#compare real direction to sprite direction
	var dir_diff = direction_sprite.angle() - direction_real.angle()
	#if the direction is more different than the threshold allows
	if abs(dir_diff) > sprite_turn_threshold:
		#update sprite direction to reflect real direction
		direction_sprite = Vector2(round(direction_real.x), round(direction_real.y))

func update_sprite():
	if state == MOVING:
		$"SpriteHolder/Fore Ground".playing = true
		$"SpriteHolder/Back Ground".playing = true
		if direction_sprite == Vector2(1,0):
			$"SpriteHolder/Fore Ground".animation = "walk_right"
			$"SpriteHolder/Back Ground".animation = "walk_side"
			rotational_offset = 0
			$SpriteHolder.rotation = 0
		if direction_sprite == Vector2(-1,0):
			$"SpriteHolder/Fore Ground".animation = "walk_left"
			$"SpriteHolder/Back Ground".animation = "walk_side"
			rotational_offset = PI
			$SpriteHolder.rotation = 0
		if direction_sprite == Vector2(0,-1):
			$"SpriteHolder/Fore Ground".animation = "walk_up"
			$"SpriteHolder/Back Ground".animation = "walk_up"
			rotational_offset = PI/2
			fine_tune_rotation()
		if direction_sprite == Vector2(0,1):
			$"SpriteHolder/Fore Ground".animation = "walk_down"
			$"SpriteHolder/Back Ground".animation = "walk_down"
			rotational_offset = -PI/2
			fine_tune_rotation()
	else:
		$"SpriteHolder/Fore Ground".playing = false
		$"SpriteHolder/Back Ground".playing = false

#draw stuff
func _draw():
	#lots of throwing calculations
	if state == THROWING: #if we throwing
		draw_circle(init_mouse_pos - position, dot_radius, dot_color)
		if not is_in_no_throw_zone:
			var mouse_diff = (init_mouse_pos - mouse_pos) * draw_back_scale #get mouse diff
			var signs = Vector2(0,0) #set up sign vector
			if mouse_diff.x != 0: signs.x = mouse_diff.x / abs(mouse_diff.x)#get signs
			if mouse_diff.y != 0: signs.y = mouse_diff.y / abs(mouse_diff.y)
			mouse_diff.x = pow(abs(mouse_diff.x), draw_back_power) * signs.x #do the power
			mouse_diff.y = pow(abs(mouse_diff.y), draw_back_power) * signs.y
			throw_end_pos = global_position + mouse_diff
			draw_line(Vector2(0,0), mouse_diff, line_color, line_width) #draw the line

#that good good turn towards the mouse
func fine_tune_rotation():
	$SpriteHolder.rotation = (direction_real.angle() + rotational_offset)


#make and throw bomb
func throw_bomb():
	GameVarables.targetPos = throw_end_pos
	var newBomb = ThrowingBomb.instance()
	newBomb.global_position = self.global_position
	newBomb.visible  = true
	get_parent().add_child(newBomb)

func _input(event):
	#if mouse do thing
	if event is InputEventMouse:
		mouse_pos = event.position #update mouse position
		if mouse_pos.distance_to(init_mouse_pos) < no_throw_radius : is_in_no_throw_zone = true
		else : is_in_no_throw_zone = false
		
		if event is InputEventMouseButton: #if mouse button happened
			if (event as InputEventMouseButton).button_index == 1: #if that button is left button
				if event.pressed: 
					state = THROWING #if pressed state is throwing
					init_mouse_pos = mouse_pos #set the starting mouse pos
				if not event.pressed:
					throw_bomb()
					state = IDLE #if released state is idle
					update() #makes sure to undraw line
	
	#make stopping happen if space is hit
	if event is InputEventKey:
		if event.scancode == KEY_SPACE:
			if event.pressed and state == MOVING: state = STOPPED
			if not event.pressed and state == STOPPED: state = IDLE

#make sure the mouse is on screen
func _notification(what):
	if what == NOTIFICATION_WM_MOUSE_ENTER:
		is_mouse_on_screen = true
	if what == NOTIFICATION_WM_MOUSE_EXIT:
		is_mouse_on_screen = false
		
	

