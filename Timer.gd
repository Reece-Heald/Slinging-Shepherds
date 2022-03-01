extends Timer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var normalBomb = preload("res://Bomb.tscn")
var rangeBomb = preload("res://RangeBomb.tscn")
var stunBomb = preload("res://StunBomb.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	rng.randomize()
	
	var randomX = rng.randf_range(0,555)
	var randomY = rng.randf_range(0,555)
	
	var bombs = [normalBomb, rangeBomb, stunBomb]
	var kindsOfBombs = bombs[randi()% bombs.size()]
	var bomb = kindsOfBombs.instance()
	#bomb.postion = get_viewport().get_mouse_position()
	add_child(bomb)
	
