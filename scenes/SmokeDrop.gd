extends CharacterBody2D

const acceleration = 460
const max_speed = 225
var item_name

var player = null
var being_picked_up = false

func _ready():
	item_name = "Smoke"
	
func _physics_process(delta):

	if being_picked_up == true:		
		var direction = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
		
		var distance = global_position.distance_to(player.global_position)
		if distance < 10:
			PlayerInventory.add_item(item_name,1)
			queue_free()

	move_and_slide()
			
func pick_up_item(body):
	player = body
	being_picked_up = true


func _on_body_entered(body: Node2D) -> void:
	print("tex")
