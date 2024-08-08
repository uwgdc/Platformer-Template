extends Node

# Autoloaded global scene
# can be called from any node at any time

var startScreen : PackedScene = load("res://scenes/game/start_screen.tscn")

var screen_size: Vector2i
@onready var window_size: Vector2i = DisplayServer.window_get_size()
var resolution: float = 16.0/9.0

func _ready() -> void:
	# set the window size to be 70% of the height, then set the width based off the resolution
	screen_size = DisplayServer.screen_get_size()
	window_size = Vector2i(round(screen_size.y*0.5*resolution),
						   round(screen_size.y*0.5))
	
	DisplayServer.window_set_size(window_size)
	DisplayServer.window_set_position(screen_size/2 - window_size/2)

# this signal is unused for now, it fires whenever we change level.
# use it to implement something like a score counter!
signal level_changed(level: PackedScene)


func play_button_press_sound() -> void:
	$ButtonSound.play()	


func change_level(level: PackedScene) -> void:
	level_changed.emit(level)
	if (level != null):
		get_tree().change_scene_to_packed(level)
	else:
		get_tree().change_scene_to_packed(startScreen)


# generally called by level
func pause_game() -> void:
	$PauseMenu.initialize_pause()
	get_tree().paused = true


func unpause_game() -> void:
	get_tree().paused = false
