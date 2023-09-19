extends Area2D
class_name bullet

var bullet_speed = 20

@onready var kill_timer = $KillTimer

var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	kill_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if (direction != Vector2.ZERO):
		var velocity = direction * bullet_speed
		
		global_position += velocity
	
	
	
	
func set_direction(direction: Vector2):
	self.direction = direction
	rotation += direction.angle()


func _on_area_entered(area: Area2D) -> void:
	queue_free() # Replace with function body.


func _on_kill_timer_timeout() -> void:
	queue_free()
