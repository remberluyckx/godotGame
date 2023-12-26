extends Resource
class_name InventoryData

signal inventory_updated(inventory_data: InventoryData)
signal inventory_interact(inventory_data: InventoryData, index: int, button: int)

@export var slot_datas: Array[SlotData]

func grab_slot_data(index: int) -> SlotData:
	var slot_data = slot_datas[index]
	
	return slot_data # comment this out and uncomment the lines under if you want to move items in the future
	#if slot_data:
		#slot_datas[index] = null
		#inventory_updated.emit(self)
		#return slot_data
	#else:
		#return null

func pick_up_slot_data(slot_data: SlotData):
	for index in slot_datas.size():
		if not slot_datas[index]:
			slot_datas[index] = slot_data
			inventory_updated.emit(self)
			return true
			
	return false


func on_slot_clicked(index: int, button: int):
	inventory_interact.emit(self, index, button)
