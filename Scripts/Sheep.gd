extends MovingCharacter

export var random_perterbation_scale : float = PI/3
export var look_back_number : int = 8
export var herding_radius : float = 90
export var debug_draw : bool = false
export var look_at_player_num : int = 1
export var flip_threshold : float = .1
export var grass_attraction_power : float = .85
var connected = false
var just_herded : bool = false
var direction = 0
var known_grasses = []
var best_grass = null

func _ready():
	#called when a new grass enters the chat
	TheSheepConnection.connect("grass_entered_chat",self,"_a_grass_has_entered_chat")
	randomize()
	set_process(true)
	
	if PlayerHead.is_body_connected():
		PlayerHead.get_body(look_at_player_num).connect("player_position", self, "_player_position_updated")
	
	_on_Turn_Timer_timeout()

func _process(delta):
	._process(delta)
	#if we are not going towards our taget position (meaning we are colliding with something)
	if (direction_real - (target_pos-global_position).normalized()).length() > flip_threshold:
		direction = direction - PI
	
	target_pos = global_position + Vector2(200,0).rotated(direction)
	update()

func _on_Turn_Timer_timeout():
	direction += (randf() - .5) * random_perterbation_scale
	
	if state == MOVING:
		attract_to_grass()

func attract_to_grass():
	calculate_best_grass()
	#if we have a best grass then change the direction by the attraction power
	if best_grass != null and not just_herded:
		direction *= 1-grass_attraction_power
		direction += grass_attraction_power*(global_position.angle_to_point(best_grass.global_position) + PI)


#just finds the closest known grass
func calculate_best_grass():
	if known_grasses.size() == 0: 
		best_grass = null
		return
	var any_real_winners : bool = false
	best_grass = known_grasses[0]
	var best_grass_dist = best_grass.global_position.distance_to(global_position)
	for grass in known_grasses:
		grass = grass as Sprite
		#makes sure the grass is still alive
		if grass.is_inside_tree():
			#calc grass distance
			var dist = grass.global_position.distance_to(global_position)
			if dist <= best_grass_dist and dist <= herding_radius:
				any_real_winners = true
				best_grass = grass 
				best_grass_dist = dist
	if not any_real_winners: best_grass = null


func _player_position_updated(who, positions: Array):
	var combined_direction = Vector2(0,0)
	for i in range(1,min(look_back_number,positions.size())): #for each point in the herding radius
		var dist = global_position.distance_to(positions[-1*i])
		if dist < herding_radius: 
			combined_direction += global_position.direction_to(positions[-1*i]) / dist #our direction to it to the sum
	
	if combined_direction != Vector2(0,0):
		just_herded = true
		direction = combined_direction.angle() + PI
	else:
		just_herded = false

func _draw():
	if debug_draw:
		var c = Color(1,1,0,.1) if not just_herded else Color(1,.25,0,.1)
		draw_circle(Vector2(0,0), herding_radius, c)
		draw_line(Vector2(0,0), target_pos - position, Color(1,0,0))
		draw_line(Vector2(0,0), direction_real * 100, Color(1,1,0))
		
		if best_grass != null: 
			draw_line(Vector2(0,0), best_grass.global_position - global_position, Color(1,1,1,1))
		
func _a_grass_has_entered_chat(grass):
	known_grasses.append(grass)
