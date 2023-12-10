extends CharacterBody2D

@export var speed = 400
var target = position
var attack_target = null
var state = "Idle"
@onready var cd = $Timer
var can_attack = true

signal shoot(bullet, direction, location)
var Bullet = preload("res://fireball.tscn")

func is_enemy_clicked(point_clicked):
	var size = attack_target.myhurtbox.shape.size;
	var baddieposition = attack_target.position
	var rectangle = Rect2(baddieposition, size)
	return rectangle.has_point(point_clicked)

func _input(event):
	if (event.is_action_pressed("LeftClick")):
		target = get_global_mouse_position()
		#look_at(target) # determines rotation
		state = "Moving"
		

func move(target):
	velocity = position.direction_to(target) * speed
	print(position.direction_to(target))
	if position.distance_to(target) > 10:
		move_and_slide()		

func _physics_process(delta):	
	if (state == "Attacking" && can_attack):
		shoot.emit(Bullet, position.direction_to(attack_target.position), position)
		cd.start()
		can_attack = false
	if (state == "Moving"):
		move(target)

func _on_timer_timeout():
	can_attack = true
