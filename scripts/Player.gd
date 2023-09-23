extends CharacterBody2D
class_name Player

#signal player_fired_bullet(bullet,position,direction)
signal player_fired_smoke(smoke,position,direction)

signal weapon_switched(prev_index,new_index)

var is_aiming = false

var move_speed = 200

var health = 100

var aiming_mouse = load("res://textures/Aiming_mouse.png")
var default_mouse = load("res://textures/cursor_pointerFlat.png")

@export var smoke = preload("res://scenes/smoke.tscn")


@onready var inventory_slots = get_tree().root.get_node("/root/GameManager/CanvasLayer/Inventory/GridContainer")
@onready var weapon = $Weapon

const SlotClass = preload("res://scripts/Slot.gd")
const ItemClass = preload("res://scripts/Item.gd")


@onready var player_sprite = "res://sprites/hitman1_stand.png"
@onready var player_shoot_sprite = "res://sprites/hitman1_silencer.png"


var aimline_from 
var col = Color.RED
var aimline_to

	
func _physics_process(delta: float) -> void:
	
	var direction = Input.get_vector("MoveLeft","MoveRight","MoveUp","MoveDown")
	velocity = direction * move_speed
	
	move_and_slide()
	
	look_at(get_global_mouse_position())
	
	if(Input.is_action_pressed("Scope")):
		Input.set_custom_mouse_cursor(aiming_mouse)
		move_speed = 100
		if(Input.is_action_just_pressed("Shoot")):
			weapon.shoot()

		$Sprite2D.texture = load(player_shoot_sprite)

	else:
		Input.set_custom_mouse_cursor(default_mouse)
		move_speed = 200
		$Sprite2D.texture = load(player_sprite)
	
	if(Input.is_action_just_pressed("Grenade")):
		var slot_indices: Array = PlayerInventory.inventory.keys()

		slot_indices.sort()
		for item in slot_indices:		
			var slot = get_tree().root.get_node("/root/GameManager/CanvasLayer/Inventory/GridContainer/Slot" + str(item + 1))
			if PlayerInventory.inventory[item][0] == "Smoke":
				print(PlayerInventory.inventory[item][1])
				PlayerInventory.inventory[item][1] = PlayerInventory.inventory[item][1] -1
				print(PlayerInventory.inventory[item][1])
				if PlayerInventory.inventory[item][1] == 0:
					print("Ya no tengo humo")
					PlayerInventory.remove_item(slot)
					slot.refresh_style()
#				smoke_trow()
	


#func smoke_trow():
#	var bullet_instance = smoke.instantiate()
#	var direction = (gun_direction.global_position - end_gun.global_position).normalized()
#	emit_signal("player_fired_smoke",bullet_instance,end_gun.global_position,direction)



func _input(event):
	if event.is_action_pressed("PickUp"):
		if $PickUpArea2D.items_in_range.size() > 0:
			var pickup_item = $PickUpArea2D.items_in_range.values()[0]
			pickup_item.pick_up_item(self)
			$PickUpArea2D.items_in_range.erase(pickup_item)

func handle_hit():
	
	print(health)
