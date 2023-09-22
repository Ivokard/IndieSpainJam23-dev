extends Control

const SlotClass = preload("res://scripts/Slot.gd")

@onready var hotbar = $HotbarSlots
@onready var slots = hotbar.get_children()


func _ready() -> void:
	for i in range(slots.size()):
		#slots[i].gui_input.connect(slot_gui_input.bind(slots[i]))
		PlayerInventory.active_item_updated.connect(Callable(slots[i],"refresh_style"))
		#PlayerInventory.connect("active_item_updated", self, "update_active_item_label")

		slots[i].slot_index = i
		slots[i].slot_type = SlotClass.SlotType.INVENTORY
	initialize_hotbar()

func initialize_hotbar():
	for i in range (slots.size()):
		if PlayerInventory.hotbar.has(i):
			slots[i].initialize_item(PlayerInventory.hotbar[i][0],PlayerInventory.hotbar[i][1])
