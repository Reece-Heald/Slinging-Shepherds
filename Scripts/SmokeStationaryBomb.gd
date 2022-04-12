extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var bombSpot1 = get_parent().get_node("UI/BombSlot1")
#onready var bombSpot2 = get_parent().get_node("UI/BombSlot2")
#onready var bombSpot3 = get_parent().get_node("UI/BombSlot3")

onready var bombSprite = get_parent().get_node("UI/BombSlotSprite1")
onready var bombSprite2 = get_parent().get_node("UI/BombSlotSprite2")
onready var bombSprite3 = get_parent().get_node("UI/BombSlotSprite3")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
#func _init(position: Vector2):
#	self.global_position = position
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		#BombGameVarables.addBombTypeInInventory("s")
		BombGameVarables.bombType.append("s")
		BombGameVarables.addBombsInInventory(self)
		if(BombGameVarables.bombsInInventory.size() == 1):
			#self.global_position = bombSpot1.global_position
			#remove_child($"Area2D")
			bombSprite.set_texture(self.get_texture())
			bombSprite.visible = true
			queue_free()
		elif(BombGameVarables.bombsInInventory.size() == 2):
			#self.global_position = bombSpot2.global_position
			#remove_child($"Area2D")
			bombSprite2.set_texture(self.get_texture())
			bombSprite2.visible = true
			queue_free()
		elif(BombGameVarables.bombsInInventory.size() == 3):
			#self.global_position = bombSpot3.global_position
			#remove_child($"Area2D")
			bombSprite3.set_texture(self.get_texture())
			bombSprite3.visible = true
			queue_free()
