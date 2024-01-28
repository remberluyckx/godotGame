extends Node2D

@onready var player = $Player
@onready var inventory_interface = $UI/InventoryInterface
@onready var equipment_interface = $UI/EquipmentInterface

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

func _on_enemy_drop_loot(item, location):
	var spawned_loot = item.instantiate()
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
	
