extends CharacterBody2D


@onready var pathfollow = get_parent()



func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.is_in_group("Player")):
		print("Te han pillado")
