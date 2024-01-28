extends Area2D

@onready var player = get_node("../Player")
@export var slot_data: SlotData
@onready var sprite_2d = $Sprite2D
@onready var rich_text_label = $RichTextLabel
var playerOnItem = false

enum STATE {IDLE, MOVING, ATTACKING, LOOTING}

func _ready():
	sprite_2d.texture = slot_data.item_data.texture
	rich_text_label.clear()
	rich_text_label.add_text(slot_data.item_data.name)

func _process(delta):
	pass

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:				
		player.state = STATE.LOOTING
		if (playerOnItem):
			loot()

func loot():
	if player.inventory_data.pick_up_slot_data(slot_data):
		queue_free()

func _on_body_entered(body):
	if (body.is_in_group("Player")):
		playerOnItem = true
		if (player.state == STATE.LOOTING):
			loot()

func _on_body_exited(body):
	if (body.is_in_group("Player")):
		playerOnItem = false
