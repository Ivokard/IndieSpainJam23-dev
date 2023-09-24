extends Node2D
class_name Weapon






@export var Bullet = preload("res://scenes/bullet.tscn")


@onready var end_of_gun = $EndGun
@onready var attack_cooldown = $AttackCooldown
@onready var gun_direction = $GunDirection
@onready var audio_shoot = $AudioStreamPlayer



func shoot():
	if attack_cooldown.is_stopped() and Bullet != null:
		var bullet_instance = Bullet.instantiate()
		var direction = (gun_direction.global_position - end_of_gun.global_position).normalized()
		GlobalSignals.emit_signal("bullet_fired",bullet_instance,end_of_gun.global_position,direction)
		attack_cooldown.start()
		audio_shoot.play()

