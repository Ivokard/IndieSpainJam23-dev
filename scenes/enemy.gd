extends CharacterBody2D
class_name  enemy

@export var bullet = preload("res://scenes/bullet.tscn")
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var health = 1
@onready var ai = $AI
@onready var weapon = $Weapon
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	ai.initialize(self,weapon)


func handle_hit():
	health-=20
	print(health)
	if health <= 0:
		queue_free()

