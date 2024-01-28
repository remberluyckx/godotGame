extends Control

var grabbed_slot_data: SlotData

@onready var player_inventory = $PlayerInventory
@onready var equipment_interface = $"../EquipmentInterface"

func set_player_inventory_data(inventory_data: InventoryData):
	inventory_data.inventory_interact.connect(on_inventory_interact)
	player_inventory.set_inventory_data(inventory_data)

func on_inventory_interact(inventory_data: InventoryData, index: int, button: int):
	#match [grabbed_slot_data, button]:
		#[null, MOUSE_BUTTON_LEFT]:
			##grabbed_slot_data = inventory_data.grab_slot_data(index)
			#print(grabbed_slot_data)
			
	match [grabbed_slot_data, button]:
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
			print(grabbed_slot_data)
			if grabbed_slot_data.item_data.type == Constants.ITEM_TYPE.WEAPON:
				equipment_interface.set_player_weapon_data(grabbed_slot_data)
			if grabbed_slot_data.item_data.type == Constants.ITEM_TYPE.CONSUMABLE:
				print("cliecked on comsum")
				#equipment_interface.set_player_weapon_data(grabbed_slot_data)

