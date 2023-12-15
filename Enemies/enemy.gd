extends CharacterBody2D

var myname = "baddie"
@onready var myhurtbox = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var player = get_node("../Player")
		player.state = "Attacking"
		player.attack_target = get_node(".")





func _on_area_2d_area_entered(area):
	if (area.is_in_group("Projectiles")):
		area.queue_free()
		print("HIT")
