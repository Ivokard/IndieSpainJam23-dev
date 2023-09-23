extends CharacterBody2D

@onready var canvas = $"../../../CanvasModulate"
@onready var pathfollow = get_parent()

func _process(delta: float) -> void:
	if(canvas.color.is_equal_approx("0f0c0e")):
		visible = true



func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.is_in_group("Player")):
		print("Te han pillado")
