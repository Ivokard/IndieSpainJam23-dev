extends Node2D
class_name SmokeManager



func handle_smoke_spawned(smoke_,position,direction):
	add_child(smoke_)
	smoke_.global_position = position
	smoke_.set_direction(position)
