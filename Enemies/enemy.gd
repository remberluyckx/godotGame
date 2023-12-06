extends CharacterBody2D

var myname = "baddie"
@onready var myhurtbox = $Hurtbox/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_hurtbox_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var player = get_node("../Player")
		player.state = "Attacking"
		player.attack_target = get_node(".")
		print("set player state in enemy")
