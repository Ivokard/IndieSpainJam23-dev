extends Node

const SlotClass = preload("res://scripts/Slot.gd")
const ItemClass = preload("res://scripts/Item.gd")

const NUM_INVENTORY_SLOTS = 4

var inventory = {
	3:["Pistol",1],
	1:["Pistol",1],
	2:["Smoke",3]
}

func add_item(item_name, item_quantity):
	var slot_indices: Array = inventory.keys()
	slot_indices.sort()
	for item in slot_indices:
		if inventory[item][0] == item_name:
			var stack_size = int(JsonData.item_data[item_name]["StackSize"])
			var able_to_add = stack_size - inventory[item][1]
			if able_to_add >= item_quantity:
				inventory[item][1] += item_quantity
				update_slot_visual(item,inventory[item][0], inventory[item][1])
				return
			else:
				inventory[item][1] += able_to_add
				item_quantity = item_quantity - able_to_add
	
	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			update_slot_visual(i,inventory[i][0], inventory[i][1])
			return
				
func update_slot_visual(slot_index, item_name, new_quantity):
	var slot = get_tree().root.get_node("/root/world/CanvasLayer/Inventory/GridContainer/Slot" + str(slot_index + 1))
	if slot.item != null:
		slot.item.set_item(item_name,new_quantity)
	else:
		slot.initialize_item(item_name,new_quantity)

func add_item_empty_slot(item: ItemClass, slot: SlotClass):
	inventory[slot.slot_index] = [item.item_name, item.item_quantity]


func remove_item(slot: SlotClass):
	inventory.erase(slot.slot_index)
	
func add_item_quantity(slot : SlotClass, quantity_to_add: int):
	inventory[slot.slot_index][1] += quantity_to_add
