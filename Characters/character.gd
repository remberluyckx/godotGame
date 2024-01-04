extends CharacterBody2D

class_name Character

enum STATE {IDLE, MOVING, ATTACKING, LOOTING}

var state: STATE = STATE.IDLE
var health: int
var speed: int = 200
var can_attack: bool = true
var target: Vector2 = position
var attack_target: Character = null
var attack_cooldown: Timer

signal shoot(projectile, direction, location)

func move(target):
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 10:
		move_and_slide()	
		var collision = get_slide_collision(0)
		if (collision):
			print("Collided with: ", collision.get_collider().name)

