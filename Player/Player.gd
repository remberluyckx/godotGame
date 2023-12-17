extends CharacterBody2D

@export var speed = 200
var target = position
var attack_target = null
var state = "Idle"
@onready var attack_cooldown = $Timer
var can_attack = true

signal shoot(projectile, direction, location)
var Fireball = preload("res://fireball.tscn")

func is_enemy_clicked(point_clicked):
	var size = attack_target.myhurtbox.shape.size;
	var baddieposition = attack_target.position
	print(size)
	print(baddieposition)
	var rectangle = Rect2(baddieposition, size)
	return rectangle.has_point(point_clicked)

func _input(event):
	if (event.is_action_pressed("LeftClick")):
		target = get_global_mouse_position()
		#look_at(target) # determines rotation
		state = "Moving"

func move(target):
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 10:
		move_and_slide()	
		var collision = get_slide_collision(0)
		if (collision):
			print("Collided with: ", collision.get_collider().name)
	

func _physics_process(delta):	
	if (state == "Attacking" && can_attack):
		shoot.emit(Fireball, position.direction_to(attack_target.position), position)
		attack_cooldown.start()
		can_attack = false
	if (state == "Moving"):
		move(target)

func _on_timer_timeout():
	can_attack = true
