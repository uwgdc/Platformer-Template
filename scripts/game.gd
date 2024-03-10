extends Node

@onready var current_level: Level

func _ready():
	for child in get_children():
		if child is Level:
			current_level = child
		break
	current_level.level_changed.connect(on_level_changed)
	
func on_level_changed(next_level_scene: PackedScene):
	var next_level := next_level_scene.instantiate()
	add_child(next_level)
	current_level.level_changed.disconnect(on_level_changed)
	current_level.queue_free()
	next_level.level_changed.connect(on_level_changed)
	current_level = next_level

func _process(_delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		$PauseMenu.position = current_level.get_camera_position()
		$PauseMenu.pause_game()
