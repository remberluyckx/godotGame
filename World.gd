extends Node2D

@onready var player = $Player
@onready var inventory_interface = $UI/InventoryInterface
@onready var equipment_interface = $UI/EquipmentInterface
var loot = preload("res://Items/ground_item.tscn")
const STAFF_FIREBALL = preload("res://item/items/staff_fireball.tres")
const POISON = preload("res://item/items/poison.tres")
const loot_collection: Array[ItemData] = [STAFF_FIREBALL, POISON]
const Slot = preload("res://inventory/slot.tscn")
#var slot1: SlotData = SlotData.new() dit moet in ready
#var slot2: SlotData = SlotData.new()
#const slot_collection: Array[SlotData] = [STAFF_FIREBALL, POISON]

func _ready():
	player.toggle_inventory.connect(toggle_inventory_interface) #connect the toggle_inventory signal from the player to the local toggle_inv_interface method
	player.toggle_equipment.connect(toggle_equipment_interface)
	inventory_interface.set_player_inventory_data(player.inventory_data)
	
func _process(delta):
	pass

func toggle_inventory_interface():
	inventory_interface.visible = not inventory_interface.visible

func toggle_equipment_interface():
	equipment_interface.visible = not equipment_interface.visible

func _on_player_shoot(projectile, direction, location):
	spawn_player_projectile(projectile, direction, location)
	
func _on_enemy_shoot(projectile, direction, location):
	spawn_enemy_projectile(projectile, direction, location)

func _on_enemy_2_shoot(projectile, direction, location):
	spawn_enemy_projectile(projectile, direction, location)

func _on_enemy_drop_loot(loot_roll, location):
	var item = loot_collection[loot_roll]
	var spawned_loot = loot.instantiate()
	
	var new_slot_data = SlotData.new()
	new_slot_data.item_data = item
	new_slot_data.set_quantity(1)

	spawned_loot.slot_data = new_slot_data
	spawned_loot.position = location

	add_child(spawned_loot)	

func spawn_player_projectile(projectile, target_location, location):
	var spawned_projectile = projectile.instantiate()
	spawned_projectile.velocity = location.direction_to(target_location)
	spawned_projectile.add_to_group("PlayerProjectiles")
	spawned_projectile.target = target_location
	spawned_projectile.position = location
	add_child(spawned_projectile)
	
func spawn_enemy_projectile(projectile, target_location, location):
	var spawned_projectile = projectile.instantiate()
	spawned_projectile.velocity = location.direction_to(target_location)
	spawned_projectile.add_to_group("EnemyProjectiles")
	spawned_projectile.target = target_location
	spawned_projectile.position = location
	add_child(spawned_projectile)
	
