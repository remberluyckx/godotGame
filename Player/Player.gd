extends Character

@export var inventory_data: InventoryData
@export var weapon_data: ItemData
var Fireball = preload("res://Projectiles/fireball.tscn")
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var weapon_sprite = $WeaponSprite
@onready var can_move: bool = true

signal toggle_inventory()
signal toggle_equipment()

func _ready():
	attack_cooldown = $Timer
	#motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

func _input(event):
	if (event.is_action_pressed("LeftClick") && can_move):
		target = get_global_mouse_position()
		state = STATE.MOVING
	if (event.is_action_pressed("inventory")):
		toggle_inventory.emit()
		toggle_equipment.emit()

func _physics_process(delta):	
	if (state == STATE.ATTACKING && can_attack):
		shoot.emit(Fireball, attack_target.position, position)
		attack_cooldown.start()
		can_attack = false
	if (state == STATE.MOVING || state == STATE.LOOTING):
		move(target)

func _on_timer_timeout():
	can_attack = true

func _on_inventory_interface_mouse_entered():
	can_move = false

func _on_inventory_interface_mouse_exited():
	can_move = true

func _on_equipment_interface_equip_weapon(equiped_weapon):
	print("equiped weapon", equiped_weapon.item_data.name)
	animated_sprite_2d.frame = 1
# set weapon_sprite.texture to equiped weapon texture
	weapon_sprite.texture = equiped_weapon.item_data.texture
	weapon_sprite.visible = true
