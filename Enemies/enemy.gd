extends CharacterBody2D

var myname = "baddie"
@onready var myhurtbox = $Area2D/CollisionShape2D
@onready var player = get_node("../Player")
var health = 1
var loot = preload("res://Items/ground_item.tscn")

signal drop_loot(item, location)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (health <= 0):
		die()

func _on_area_2d_area_entered(area):
	if (area.is_in_group("Projectiles")):
		area.queue_free()
		health = health - 1


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var player = get_node("../Player")
		player.state = "Attacking"
		player.attack_target = get_node(".")

func die():
		queue_free()	
		player.state = "Idle"
		player.attack_target = null
		drop_loot.emit(loot, position)
