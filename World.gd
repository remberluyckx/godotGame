extends Node2D

@onready var player = $Player
@onready var inventory_interface = $UI/InventoryInterface

# Called when the node enters the scene tree for the first time.
func _ready():
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player.inventory_data)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func toggle_inventory_interface():
	inventory_interface.visible = not inventory_interface.visible

func _on_player_shoot(projectile, direction, location):
	var spawned_projectile = projectile.instantiate()
	spawned_projectile.velocity = direction
	add_child(spawned_projectile)
	spawned_projectile.position = location


func _on_enemy_drop_loot(item, location):
	var spawned_loot = item.instantiate()
	add_child(spawned_loot)
	spawned_loot.position = location
