extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if(Input.is_action_just_pressed("Inventory")):
		$Inventory.visible = !$Inventory.visible
		$Inventory.initialize_inventory()
