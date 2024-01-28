extends Character

@onready var myhurtbox = $Area2D/CollisionShape2D
@onready var player = get_node("../Player")
var loot = preload("res://Items/ground_item.tscn")
var Fireball = preload("res://Projectiles/fireball.tscn")

signal drop_loot(item, location)

# Called when the node enters the scene tree for the first time.
func _ready():
	health = 2
	attack_cooldown = $Timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (health <= 0):
		die()
	else:
		if (state == STATE.ATTACKING && can_attack):
			attack_target = player
			shoot.emit(Fireball, attack_target.position, position)
			attack_cooldown.start()
			can_attack = false

func die():
		queue_free()	
		player.state = STATE.IDLE
		player.attack_target = null
		drop_loot.emit(loot, position)

func _on_timer_timeout():
	can_attack = true

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:		
		player.state = STATE.ATTACKING
		player.attack_target = get_node(".")
