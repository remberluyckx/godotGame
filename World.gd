extends Node2D

@onready var player = $Player
@onready var inventory_interface = $UI/InventoryInterface

func _ready():
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player.inventory_data)
	
func _process(delta):
	pass

func toggle_inventory_interface():
	inventory_interface.visible = not inventory_interface.visible

func _on_player_shoot(projectile, direction, location):
	spawn_player_projectile(projectile, direction, location)
	
func _on_enemy_shoot(projectile, direction, location):
	spawn_enemy_projectile(projectile, direction, location)

func _on_enemy_2_shoot(projectile, direction, location):
	spawn_enemy_projectile(projectile, direction, location)

func _on_enemy_drop_loot(item, location):
	var spawned_loot = item.instantiate()
	add_child(spawned_loot)
	spawned_loot.position = location

func spawn_player_projectile(projectile, direction, location):
	var spawned_projectile = projectile.instantiate()
	spawned_projectile.velocity = direction
	spawned_projectile.add_to_group("PlayerProjectiles")
	add_child(spawned_projectile)
	spawned_projectile.position = location
	
func spawn_enemy_projectile(projectile, direction, location):
	var spawned_projectile = projectile.instantiate()
	spawned_projectile.velocity = direction
	spawned_projectile.add_to_group("EnemyProjectiles")
	add_child(spawned_projectile)
	spawned_projectile.position = location
