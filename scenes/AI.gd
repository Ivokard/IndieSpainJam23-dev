extends Node2D

signal state_changed(new_state)

@onready var player_detection_zone = $Area2D

enum State{
	PATROL,
	ENGAGE
}

var current_state = State.PATROL : set= set_state


signal player_fired_bullet(bullet,position,direction)


@export var bullet = preload("res://scenes/bullet.tscn")

var actor = null
var player:Player=null
var weapon: Weapon = null

func initialize(actor,weapon: Weapon):
	self.actor = actor
	self.weapon = weapon

func _process(delta: float) -> void:
	match current_state:
		State.PATROL:
			pass
		State.ENGAGE:
			if player!= null and weapon != null:
				actor.rotation = actor.global_position.direction_to(player.global_position).angle()
				weapon.shoot()
			else:
				pass

func set_state(new_state:int):
	if new_state == current_state:
		return
	
	current_state = new_state
	emit_signal("state_changed",current_state)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		set_state(State.ENGAGE)
		player = body
		print(body)
	
