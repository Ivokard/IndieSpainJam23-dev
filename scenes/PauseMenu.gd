extends Control

@onready var menu = $VBoxContainer
@onready var options = $Options
@onready var video = $Video
@onready var audio = $Audio

@export var game_manager : GameManager
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_ui"):
		toggle()

func toggle():
	visible = !visible
	get_tree().paused = visible

func _on_play_button_pressed() -> void:
	toggle()


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
	AudioServer.set_bus_volume_db(bus_index,value)

func _on_master_value_changed(value: float) -> void:
	volume(0,value) 
	
	


func _on_music_value_changed(value: float) -> void:
	volume(1,value) 


func _on_sfx_value_changed(value: float) -> void:
	volume(2,value)  # Replace with function body.


func _on_how_to_button_pressed() -> void:
	pass # Replace with function body.
