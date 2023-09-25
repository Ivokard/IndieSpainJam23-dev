extends Control

@onready var menu = $VBoxContainer
@onready var options = $Options
@onready var video = $Video
@onready var audio = $Audio
@onready var level_selection = $LevelSelection
@onready var how_to = $HowToPlay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.


func toggle():
	visible = !visible
	get_tree().paused = visible

func _on_play_button_pressed() -> void:
	show_hide(level_selection,$VBoxContainer)


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func show_hide(first,second):
	first.show()
	second.hide()


func _on_setting_button_pressed() -> void:
	show_hide(options,$VBoxContainer)
	
func _on_fullscreen_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_borderless_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_v_sync_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


func _on_video_pressed() -> void:
	show_hide(video,options) # Replace with function body.


func _on_audio_pressed() -> void:
	show_hide(audio,options) # Replace with function body.




func _on_back_options_pressed() -> void:
	show_hide(menu,options) # Replace with function body.


func _on_back_video_pressed() -> void:
	show_hide(options,video) # Replace with function body.


func _on_back_audio_pressed() -> void:
	show_hide(options,audio)
	
func volume(bus_index,value):
	AudioServer.set_bus_volume_db(bus_index,linear_to_db(value))

func _on_master_value_changed(value: float) -> void:
	volume(0,value) 
	
	


func _on_music_value_changed(value: float) -> void:
	volume(1,value) 


func _on_sfx_value_changed(value: float) -> void:
	volume(2,value)  # Replace with function body.


func _on_level_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world3.tscn")


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world2.tscn")


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")



func _on_back_levels_pressed() -> void:
	show_hide(menu,level_selection) # Replace with function body.


func _on_back_howto_pressed() -> void:
	show_hide(menu,how_to) # Replace with function body.


func _on_how_to_button_pressed() -> void:
	show_hide(how_to,menu) # Replace with function body.
