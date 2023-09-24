extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var slot_indices: Array = PlayerInventory.inventory.keys()

		slot_indices.sort()
		for item in slot_indices:		
			var slot = get_tree().root.get_node("/root/GameManager/CanvasLayer/Inventory/GridContainer/Slot" + str(item + 1))
			if PlayerInventory.inventory[item][0] == "Green Key":
				queue_free()

