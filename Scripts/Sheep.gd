extends MovingCharacter

export var random_perterbation_scale : float = PI/3
export var look_back_number : int = 8
export var herding_radius : float = 90
export var eat_radius : float = 25
export var debug_draw : bool = false
export var look_at_player_num : int = 1
export var flip_threshold : float = .1
export var grass_attraction_power : float = .85
var connected = false
var just_herded : bool = false
var direction = 0
var known_grasses = []
var best_grass : Grass = null
var best_grass_dist : float = 100000
var health = 2
onready var fire_speed = 2.5 * run_speed
onready var smoke_speed =  0 * run_speed
onready var og_speed = run_speed

const bombLocation = preload("res://Prefabs/StationaryBomb.tscn")
const smokeBombLocation = preload("res://Prefabs/SmokeStationaryBomb.tscn")
const xBombLocation = preload("res://Prefabs/XStationaryBomb.tscn")
const fireBombLocation = preload("res://Prefabs/FireStationaryBomb.tscn")
var bomb

const EATING = 2

func _ready():
	TheSheepConnection.add_sheep(look_at_player_num)
	#called when a new grass enters the chat
	TheSheepConnection.connect("grass_entered_chat",self,"_a_grass_has_entered_chat")
	TheSheepConnection.connect("grass_left_chat",self,"_a_grass_has_left_chat")
	randomize()
	set_process(true)
	
	if PlayerHead.is_body_connected(look_at_player_num):
		PlayerHead.get_body(look_at_player_num).connect("player_position", self, "_player_position_updated")
	
	_on_Turn_Timer_timeout()

func _process(delta):
	._process(delta)
	#if we are not going towards our taget position (meaning we are colliding with something)
	if (direction_real - (target_pos-global_position).normalized()).length() > flip_threshold:
		direction = direction - PI
	var og_color = Color(1,1,1) if health == 2 else Color(1,.5,.5)
	var color_mix = $"Damage Timer".time_left * 4
	$SpriteHolder/AnimatedSprite.modulate = og_color * (1 - color_mix) + Color(1,0,0) * color_mix
	
	target_pos = global_position + Vector2(200,0).rotated(direction)
	update()

func _on_Turn_Timer_timeout():
	direction += (randf() - .5) * random_perterbation_scale
	
	if state == MOVING and $"Fire Timer".time_left == 0:
		attract_to_grass()
		if best_grass_dist < eat_radius and state != EATING:
			state = EATING
			eat_grass()
			$"Eat Timer".start()

func eat_grass():
	var anim = get_node(animation_node_one) as AnimatedSprite
	if anim.animation == "walk_down": anim.play("eat_down")
	if anim.animation == "walk_up": anim.play("eat_up")
	if anim.animation == "walk_left": anim.play("eat_left")
	if anim.animation == "walk_right": anim.play("eat_right")
	anim.playing = true
	

func attract_to_grass():
	calculate_best_grass()
	#if we have a best grass then change the direction by the attraction power
	if best_grass != null and not just_herded:
		direction *= 1-grass_attraction_power
		direction += grass_attraction_power*(global_position.angle_to_point(best_grass.global_position) + PI)


#just finds the closest known grass
func calculate_best_grass():
	#if we don't know of any grass just leave
	if known_grasses.size() == 0: 
		best_grass = null
		return
	#if we have a best grass, relive it's claim for now
	if best_grass != null and is_instance_valid(best_grass):
		best_grass.claimed = false
		best_grass.update()
	
	#start the algorithm
	var any_real_winners : bool = false
	best_grass_dist = 100000
	
	#for each grass we know of
	for grass in known_grasses:
		if is_instance_valid(grass):
			grass = grass as Grass
			#makes sure the grass is still alive
			if grass.is_inside_tree():
				#calc grass distance
				var dist = grass.global_position.distance_to(global_position)
				if dist <= best_grass_dist and dist <= herding_radius and grass.claimed == false:
					any_real_winners = true #remind us we have a winner
					best_grass = grass #assign it to be our best grass
					best_grass_dist = dist #update the best grass distance
	
	
	if not any_real_winners: 
		best_grass = null
		best_grass_dist = 100000
	else:
		best_grass.claimed = true
		best_grass.update()
	

func _player_position_updated(who, positions: Array):
	var combined_direction = Vector2(0,0)
	for i in range(1,min(look_back_number,positions.size())): #for each point in the herding radius
		var dist = global_position.distance_to(positions[-1*i])
		if dist < herding_radius: 
			combined_direction += global_position.direction_to(positions[-1*i]) / dist #our direction to it to the sum
	
	if combined_direction != Vector2(0,0) and $"Fire Timer".time_left == 0:
		just_herded = true
		direction = combined_direction.angle() + PI
	else:
		just_herded = false

func _draw():
	if debug_draw:
		var c = Color(1,1,0,.1) if not just_herded else Color(1,.25,0,.1)
		if state == EATING:
			c += Color(0,-.25,1,.1)
		draw_circle(Vector2(0,0), herding_radius, c)
		draw_circle(Vector2(0,0), eat_radius, Color(.5,1,.5,.1))
		if not state == EATING:
			draw_line(Vector2(0,0), target_pos - position, Color(1,0,0))
			draw_line(Vector2(0,0), direction_real * 100, Color(1,1,0))
		
		if best_grass != null and is_instance_valid(best_grass): 
			draw_line(Vector2(0,0), best_grass.global_position - global_position, Color(1,1,1,1))
		
func _a_grass_has_entered_chat(grass):
	known_grasses.append(grass)

func _a_grass_has_left_chat(grass):
	known_grasses.remove(known_grasses.find(grass))
	if best_grass == grass:
		best_grass = null

func _on_Eat_Timer_timeout():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = ceil(rng.randf_range(1, 4))
	
	if best_grass != null and is_instance_valid(best_grass):
		best_grass.die()
	
	best_grass = null
	state = IDLE
	
#	print(my_random_number)
#	bomb = bombLocation.instance()
#	get_tree().root.get_child(3).add_child(bomb)
#	bomb.set_global_position(global_position - (direction_real*20))
	if(my_random_number == 1):
		#norm bomb
		bomb = bombLocation.instance()
		get_tree().root.get_child(3).add_child(bomb)
		bomb.set_global_position(global_position - (direction_real*20))
	if(my_random_number == 2):
		#fire
		bomb = fireBombLocation.instance()
		get_tree().root.get_child(3).add_child(bomb)
		bomb.set_global_position(global_position - (direction_real*20))
	if(my_random_number == 3):
		#smoke
		bomb = smokeBombLocation.instance()
		get_tree().root.get_child(3).add_child(bomb)
		bomb.set_global_position(global_position - (direction_real*20))
	if(my_random_number == 4):
		#X
		bomb = xBombLocation.instance()
		get_tree().root.get_child(3).add_child(bomb)
		bomb.set_global_position(global_position - (direction_real*20))
	

func set_on_fire():
	run_speed = fire_speed
	$"Fire Timer".start()
	$CPUParticles2D.emitting = true

func getConfused():
	run_speed = smoke_speed
	$"Smoke Timer".start()
	$"ConfusionEffect".visible = true
	$"ConfusionEffect".play("default")

func take_damage():
	#print("sheep get hurt")
	health -= 1
	$"Damage Timer".start()
	
	if health <= 0:
		die()

func die():
	TheSheepConnection.subtract_sheep(look_at_player_num)
	queue_free()

func _on_Fire_Timer_timeout():
	run_speed = og_speed
	



func _on_Smoke_Timer_timeout():
	$ConfusionEffect.play("default")
	run_speed = og_speed
