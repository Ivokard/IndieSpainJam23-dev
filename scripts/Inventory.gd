extends Control

const SlotClass = preload("res://scripts/Slot.gd")

@onready var inventory_slots = $GridContainer

var holding_item = null

func _ready() -> void:
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		slots[i].gui_input.connect(slot_gui_input.bind(slots[i]))



		slots[i].slot_index = i
	initialize_inventory()

func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range (slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0],PlayerInventory.inventory[i][1])

func slot_gui_input(event: InputEvent, slot : SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if holding_item != null:
				if !slot.item:
					PlayerInventory.add_item_empty_slot(holding_item,slot)
					slot.put_into_slot(holding_item)
					holding_item = null
				else:
					if holding_item.item_name != slot.item.item_name:
						PlayerInventory.remove_item(slot)	
						PlayerInventory.add_item_empty_slot(holding_item,slot)
						var temp_item = slot.item
						slot.pick_from_slot()
						temp_item.global_position = event.global_position
						slot.put_into_slot(holding_item)
						holding_item = temp_item
					else:
						var stack_size = int(JsonData.item_data[slot.item.item_name]["StackSize"])
						var able_to_add = stack_size - slot.item.item_quantity
						if able_to_add >= holding_item.item_quantity:
							PlayerInventory.add_item_quantity(slot, holding_item.item_quantity)
							slot.item.add_item_quantity(holding_item.item_quantity)
							holding_item.queue_free()
							holding_item = null
						else:
							PlayerInventory.add_item_quantity(slot, able_to_add)
							slot.item.add.item_quantity(able_to_add)
							holding_item.decrease_item_quantity(able_to_add)
			elif slot.item:
				PlayerInventory.remove_item(slot)
				holding_item = slot.item
				slot.pick_from_slot()
				holding_item.global_position = get_global_mouse_position()

func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
			

