extends KinematicBody2D
class_name MovingCharacter

#movement parameters
export var run_speed = 5.0
export var slow_down_power = 1.0
export var stop_radius = 16
export var walk_radius = 256
export var sprite_turn_threshold : float = PI/3 #in radiants

#movement / sprite direction variables
var target_pos : Vector2
var direction_real : Vector2 = Vector2(0,0) #any angle
var direction_sprite : Vector2 = Vector2(0,0) #only up down left right
var rotational_offset = 0

export var animation_node_one : NodePath
export var animation_node_two : NodePath
export var spirite_holder : NodePath


#flags and such
enum {IDLE, MOVING}
var state = IDLE
#player movement flags
var is_target_in_stop_zone = false
var is_target_on_screen = true


func _ready():
	set_process(true)

func _process(delta):
	if state == IDLE or state == MOVING:
		follow_target()
	
	update_direction()
	update_sprite()

func follow_target():
	#make sure mousepos exists
	#and make sure mouse is on screen
	if target_pos != null and is_target_on_screen:
		#get our mouse pos - our pos
		var diff : Vector2 = target_pos - global_position
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
	#get the nodes from the exported node paths
	var anim1 = get_node(animation_node_one) as AnimatedSprite
	var anim2 = get_node(animation_node_two) as AnimatedSprite
	
	if anim1 != null :
		_help_update_sprite(anim1)
	if anim2 != null :
		_help_update_sprite(anim2)

#updates single animation player
func _help_update_sprite(anim):
	var sp = get_node(spirite_holder) as Node2D
	
	if state == MOVING:
		anim.playing = true
		if direction_sprite == Vector2(1,0):
			anim.animation = "walk_right"
			sp.rotation = 0
			rotational_offset = 0
		if direction_sprite == Vector2(-1,0):
			anim.animation = "walk_left"
			sp.rotation = 0
			rotational_offset = PI
		if direction_sprite == Vector2(0,-1):
			anim.animation = "walk_up"
			rotational_offset = PI/2
			fine_tune_rotation()
		if direction_sprite == Vector2(0,1):
			anim.animation = "walk_down"
			rotational_offset = -PI/2
			fine_tune_rotation()
	else:
		anim.playing = false

#that good good turn towards the target
func fine_tune_rotation():
	var sp = get_node(spirite_holder) as Node2D
	sp.rotation = (direction_real.angle() + rotational_offset)
