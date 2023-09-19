extends CharacterBody2D
class_name Player

signal player_fired_bullet(bullet,position,direction)


var move_speed = 200

@export var bullet = preload("res://scenes/bullet.tscn")

@onready var end_gun = $EndGun
@onready var gun_direction = $GunDirection


func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	
	var direction = Input.get_vector("MoveLeft","MoveRight","MoveUp","MoveDown")
	velocity = direction * move_speed
	
	move_and_slide()
	
	look_at(get_global_mouse_position())
	
	if(Input.is_action_just_pressed("Shoot")):
		fire()

func fire():
	var bullet_instance = bullet.instantiate()
	var direction = (gun_direction.global_position - end_gun.global_position).normalized()

	emit_signal("player_fired_bullet",bullet_instance,end_gun.global_position,direction)

