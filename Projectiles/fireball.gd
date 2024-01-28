extends Area2D

var velocity = Vector2.RIGHT

enum STATE {IDLE, MOVING, ATTACKING, LOOTING}
var target

# Called when the node enters the scene tree for the first time.
func _ready():
	if (target != null):
		look_at(target)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += velocity * 150 * delta

func _on_body_entered(body):
	if (body.is_in_group("Obstacles") || body.is_in_group("Tilemap")):
		print("hit obstacle")
		queue_free()
		return
	if (!body.is_in_group("Player") && is_in_group("PlayerProjectiles")):
		print("hit enemy")
		if (body.health != null && body.state != null):
			body.health = body.health -1
			body.state = STATE.ATTACKING
		queue_free()
	if (!body.is_in_group("Enemies") && is_in_group("EnemyProjectiles")):
		print("hit player")
		queue_free()
	# send signal to body that got hit and handle damage etc there
