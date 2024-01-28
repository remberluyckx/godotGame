extends Control

@onready var player_weapon_slot = $WeaponSlot

signal equip_weapon

func set_player_weapon_data(weapon_data: SlotData):
	player_weapon_slot.set_slot_data(weapon_data)
	equip_weapon.emit(weapon_data)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
