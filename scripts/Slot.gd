extends Panel

var ItemClass = preload("res://scenes/UI/Item.tscn")
var item = null



var default_tex = preload("res://textures/white_square.png")
var empty_tex = preload("res://textures/white_square.png")
var selected_tex = preload("res://textures/white_square.png")

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null
var selected_style: StyleBoxTexture = null

var slot_index


enum SlotType{
	HOTBAR = 0,
	INVENTORY
}

var slot_type = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	selected_style = StyleBoxTexture.new()
	
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	selected_style.texture = selected_tex
	

	
	#if randi() % 2 == 0:
	#	item = ItemClass.instantiate()
	#	add_child(item)
	refresh_style()
	
func refresh_style():
	if slot_type == SlotType.HOTBAR and PlayerInventory.active_item_slot == slot_index:
		set('custom_styles/panel', selected_style);

	elif item == null:
		set('custom_styles/panel', empty_style);

	else:
		set('custom_styles/panel', default_style);
		


func pick_from_slot():
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item)
	item = null
	refresh_style()
	
func put_into_slot(new_item):
	item = new_item
	item.position = Vector2(0,0)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.remove_child(item)
	add_child(item)
	refresh_style()
	
	
func initialize_item(item_name, item_quantity):
	if item == null:
		item = ItemClass.instantiate()
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name,item_quantity)
	refresh_style()
