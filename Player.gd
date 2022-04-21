extends MovingCharacter
class_name Player

export var debug_draw : bool = false
export var use_controller : bool = false
export var player_prefix : String = "p1"
export var player_position_array_length = 8

#signals
var positions : Array = []
signal player_position(who, positions)

#player throwing parameters
export var controller_base_scale : float = 30
export var controller_throw_extension_scale : float = 280
export var draw_back_scale = 60.0
export var draw_back_power = .75
export var no_throw_radius = 32
export var line_color : Color = Color(1,1,1)
export var line_width = 5
export var dot_color : Color = Color(1,1,1)
export var dot_radius = 5


#bomb variables
var ThrowingBomb = load("res://ThrowingBomb.tscn")
onready var bombSlot1 = get_parent().get_node("UI/BombSlotSprite1")
onready var bombSlot2 = get_parent().get_node("UI/BombSlotSprite2")
onready var bombSlot3 = get_parent().get_node("UI/BombSlotSprite3")
var bomb_speed := 5

var is_in_no_throw_zone : bool = false

const STOPPED = 2
const THROWING = 3

#throwing variables
var init_mouse_pos : Vector2 = Vector2(0,0)
var throw_end_pos : Vector2

func _ready():
	target_pos = position
	PlayerHead.connect_body(self, int(player_prefix[1]))
	set_process(true)

func _process(delta):
	._process(delta)
	
	#update controler scale if throwing
	if use_controller:
		#get direction and set target positon with it
		var direction = Input.get_vector(player_prefix + "_move_left", player_prefix + "_move_right", player_prefix + "_move_up", player_prefix + "_move_down")
		
		#if we are throwing
		if Input.is_action_just_pressed(player_prefix + "_throw"):
			state = THROWING
			init_mouse_pos = global_position
		if Input.is_action_just_released(player_prefix + "_throw"):
			if direction != Vector2(0,0): throw_bomb()
			state = IDLE
		if Input.is_action_pressed(player_prefix + "_extend_1"):
				controller_vector_scale += controller_throw_extension_scale * delta
		if Input.is_action_pressed(player_prefix + "_extend_2"):
				controller_vector_scale -= controller_throw_extension_scale * delta
		if state == THROWING :
			controller_vector_scale = max(1,controller_vector_scale)
			target_pos = global_position + (controller_vector_scale*direction)
		else:
			target_pos = global_position + (controller_base_scale*direction)
	
	#emit if moving
	if state == MOVING:
		$Particles2D.emitting = true
	else:
		$Particles2D.emitting = false
	
	update()

#draw stuff
func _draw():
	#lots of throwing calculations
	if state == THROWING: #if we throwing
		draw_circle(init_mouse_pos - position, dot_radius, dot_color)
		if not is_in_no_throw_zone:
			var mouse_diff = (init_mouse_pos - target_pos) * draw_back_scale #get mouse diff
			var signs = Vector2(0,0) #set up sign vector
			if mouse_diff.x != 0: signs.x = mouse_diff.x / abs(mouse_diff.x)#get signs
			if mouse_diff.y != 0: signs.y = mouse_diff.y / abs(mouse_diff.y)
			mouse_diff.x = pow(abs(mouse_diff.x), draw_back_power) * signs.x #do the power
			mouse_diff.y = pow(abs(mouse_diff.y), draw_back_power) * signs.y
			throw_end_pos = global_position + mouse_diff
			draw_line(Vector2(0,0), mouse_diff, line_color, line_width) #draw the line
	
	#draw pathing debug
	if debug_draw:
		for i in range(1,min(8,positions.size())): #for each point in the herding radius
			draw_line(positions[-1*i] - position,positions[-1*i -1] - position, Color("FFFFFFFF"))


#make and throw bomb
func throw_bomb():
	if(BombGameVarables.bombsInInventory.size() > 0):
		#stuff for scaling
		var midPosX = ceil(abs((throw_end_pos.x + self.global_position.x)/2))
		var midPosY = ceil(abs((throw_end_pos.y + self.global_position.y)/2))
		BombGameVarables.targetPos = throw_end_pos
		BombGameVarables.midPointPos = Vector2(midPosX,midPosY)
		BombGameVarables.scaleRatio = .08
		#stuff for multi type 
		BombGameVarables.bombsInInventory.clear()
		#stuff for item pickup
		bombSlot1.visible = false
		bombSlot2.visible = false
		bombSlot3.visible = false
		var newBomb = ThrowingBomb.instance()
		newBomb.global_position = self.global_position
		newBomb.visible  = true
		get_parent().add_child(newBomb)
		
		#stuff for changing sprite for multi bomb
		newBomb.changeSprite()
		#newBomb.noMove()

const base_controller_vector_scale = 30
var controller_vector_scale = base_controller_vector_scale
func _input(event):
	#if using keyboard controls
	if(not use_controller):
		#if mouse do thing
		if event is InputEventMouse:
			target_pos = event.position #update mouse position
			if target_pos.distance_to(init_mouse_pos) < no_throw_radius : is_in_no_throw_zone = true
			else : is_in_no_throw_zone = false
			
			if event is InputEventMouseButton: #if mouse button happened
				if (event as InputEventMouseButton).button_index == 1: #if that button is left button
					if event.pressed: 
						state = THROWING #if pressed state is throwing
						init_mouse_pos = target_pos #set the starting mouse pos
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
		is_target_on_screen = true
	if what == NOTIFICATION_WM_MOUSE_EXIT:
		is_target_on_screen = false


func _on_PositionUpdateTimer_timeout():
	positions.append(global_position)
	if positions.size() > player_position_array_length:
		positions.remove(0)
	emit_signal("player_position", self, positions)
	update()
