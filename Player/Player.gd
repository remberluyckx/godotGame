extends Character

#var target = position
@export var inventory_data: InventoryData
var Fireball = preload("res://Projectiles/fireball.tscn")

signal toggle_inventory()


func _ready():
	attack_cooldown = $Timer

func _input(event):
	if (event.is_action_pressed("LeftClick")):
		target = get_global_mouse_position()
		#look_at(target) # determines rotation
		state = STATE.MOVING
	if (event.is_action_pressed("inventory")):
		toggle_inventory.emit()

func _physics_process(delta):	
	if (state == STATE.ATTACKING && can_attack):
		shoot.emit(Fireball, position.direction_to(attack_target.position), position)
		attack_cooldown.start()
		can_attack = false
	if (state == STATE.MOVING || state == STATE.LOOTING):
		move(target)

func _on_timer_timeout():
	can_attack = true
