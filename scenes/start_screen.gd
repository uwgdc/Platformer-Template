extends Node

var screen_size: Vector2i
@onready var window_size: Vector2i = DisplayServer.window_get_size()
@onready var start_button: Button = $MarginContainer/VBoxContainer/VBoxContainer/StartButton

var game_scene: PackedScene = preload("res://scenes/game/game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Make the window a bit bigger on startup
	screen_size = DisplayServer.screen_get_size()
	window_size = Vector2i(round(screen_size[0]*0.7),
						   round(screen_size[0]*0.7)*window_size[1]/window_size[0])
	DisplayServer.window_set_size(window_size)
	DisplayServer.window_set_position(screen_size/2 - window_size/2)
	
	# lets us use arrow keys
	start_button.grab_focus()


func _on_start_button_pressed() -> void:
	MenuSounds.play_button_press()
	get_tree().change_scene_to_packed(game_scene)

func _on_quit_button_pressed() -> void:
	MenuSounds.play_button_press()
	get_tree().quit()
