extends Node

var screen_size: Vector2i
@onready var window_size: Vector2i = DisplayServer.window_get_size()
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = DisplayServer.screen_get_size()
	window_size = screen_size*0.7
	DisplayServer.window_set_size(window_size)
	DisplayServer.window_set_position(screen_size/2 - window_size/2)


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
