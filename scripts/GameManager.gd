extends Node2D

class_name GameManager

signal toggle_game

@onready var bullet_manager = $BulletManager
@onready var smoke_manager = $SmokeManager
@onready var player = $Player
var level_complete = false

var game_paused: bool = false:
	get: 
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
#		emit_signal("toggle_game_paused", game_paused)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.connect("bullet_fired", Callable(bullet_manager, "handle_bullet_spawned"))
	player.connect("player_fired_smoke", Callable(smoke_manager, "handle_smoke_spawned"))
	
	
func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("toggle_ui")):
		game_paused = !game_paused

func _process(delta: float) -> void:

	if get_tree().get_nodes_in_group("Enemy").size() <= 0 and level_complete == false:
		print("nivel completado")
		level_complete=true
	if level_complete == true:
		$CanvasLayer/NextLevel.visible = true
		get_tree().paused = true
	if player.health <= 0:
		$CanvasLayer/Deadmenu.visible = true
		get_tree().paused = true

	
