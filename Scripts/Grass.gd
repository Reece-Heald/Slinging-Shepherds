# requires parent function GrassDies()

extends Sprite
class_name Grass

const bombLocation = preload("res://StationaryBomb.tscn")
var bomb

var grow1 = preload("res://Sprites/Grass/Grass1.png")
var grow2 = preload("res://Sprites/Grass/Grass2.png")
var grow3 = preload("res://Sprites/Grass/Grass3.png")

export (int) var timeToSprite2 = 3
export (int) var timeToSprite3 = 6
export var debug_draw = false

var stage = 1
var claimed = false

func _ready():
	TheSheepConnection.emit_signal("grass_entered_chat",self)
	set_texture(grow1)

# every second
func _on_Timer_timeout():
	if (stage == timeToSprite2):
		set_texture(grow2)
	if (stage == timeToSprite3):
		set_texture(grow3)
		$Timer.stop()
	stage += 1
	

# if you click and the mouse is near grass, the grass dies
func _input(event):
	if event is InputEventMouseButton:
		if (abs(event.position.x - global_position.x) < 10 && abs(event.position.y - global_position.y) < 10):
			get_parent().grass_dies()
			queue_free()


func _on_Area2D_body_entered(body):
	pass
#	if body.is_in_group("Sheep") && stage >= timeToSprite3:
#		bomb = bombLocation.instance()
#		bomb.set_global_position(self.global_position)
#		get_parent().get_parent().get_parent().add_child(bomb)
#		get_parent().grass_dies()
#		queue_free()

func _draw():
	if debug_draw:
		if claimed:
			draw_circle(Vector2(0,0), 32, Color(.2,1,.2,.5))
