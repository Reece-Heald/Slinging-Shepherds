extends MovingCharacter

export var perterbation_scale : float = 3.0

func _ready():
	._ready()
	
	target_pos = global_position

func _on_Turn_Timer_timeout():
	target_pos += Vector2(randf(), randf()) * perterbation_scale
