extends MovingCharacter

export var perterbation_scale : float = PI/3
export var look_back_number : int = 8
export var herding_radius : float = 90
export var debug_draw : bool = false
var connected = false
var direction = 0

func _ready():
	randomize()
	set_process(true)
	
	if PlayerHead.is_body_connected():
		PlayerHead.get_body().connect("player_position", self, "_player_position_updated")
	
	_on_Turn_Timer_timeout()

func _process(delta):
	._process(delta)
	update()

func _on_Turn_Timer_timeout():
	direction += (randf() - .5) * perterbation_scale
	target_pos = global_position + Vector2(0,200).rotated(direction)

func _player_position_updated(who, positions: Array):
	var combined_direction = Vector2(0,0)
	for i in range(1,min(look_back_number,positions.size())): #for each point in the herding radius
		var dist = global_position.distance_to(positions[-1*i])
		if dist < herding_radius: 
			combined_direction += global_position.direction_to(positions[-1*i]) / dist #our direction to it to the sum
	
	if combined_direction != Vector2(0,0):
		direction = combined_direction.angle() + PI/2
		target_pos = global_position + Vector2(0,200).rotated(direction)

func _draw():
	if debug_draw:
		draw_circle(Vector2(0,0), herding_radius, Color(1,1,0,.1))
		draw_line(Vector2(0,0), target_pos - position, Color(1,0,0))
