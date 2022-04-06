extends MovingCharacter

export var random_perterbation_scale : float = PI/3
export var look_back_number : int = 8
export var herding_radius : float = 90
export var debug_draw : bool = false
export var look_at_player_num : int = 1
export var flip_threshold : float = .1
var connected = false
var direction = 0

func _ready():
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
	
	target_pos = global_position + Vector2(0,200).rotated(direction)
	update()

func _on_Turn_Timer_timeout():
	direction += (randf() - .5) * random_perterbation_scale

func _player_position_updated(who, positions: Array):
	var combined_direction = Vector2(0,0)
	for i in range(1,min(look_back_number,positions.size())): #for each point in the herding radius
		var dist = global_position.distance_to(positions[-1*i])
		if dist < herding_radius: 
			combined_direction += global_position.direction_to(positions[-1*i]) / dist #our direction to it to the sum
	
	if combined_direction != Vector2(0,0):
		direction = combined_direction.angle() + PI/2

func _draw():
	if debug_draw:
		draw_circle(Vector2(0,0), herding_radius, Color(1,1,0,.1))
		draw_line(Vector2(0,0), target_pos - position, Color(1,0,0))
		draw_line(Vector2(0,0), direction_real * 100, Color(1,1,0))
		draw_line(Vector2(0,0), Vector2(0,200).rotated(direction), Color(0,1,1))
