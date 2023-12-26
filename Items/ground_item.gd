extends Area2D

@onready var player = get_node("../Player")
@onready var playerArea = get_node("../Player/Area2D")
@export var slot_data: SlotData
@onready var sprite_2d = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.texture = slot_data.item_data.texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:				
		player.state = "Looting"
		if (overlaps_area(playerArea)):
			loot()
		


func _on_area_entered(area):
	if (player.state == "Looting" && area.is_in_group("Player")):
		loot()

func loot():
	if player.inventory_data.pick_up_slot_data(slot_data):
		queue_free()
