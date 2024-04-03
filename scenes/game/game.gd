extends Node

@onready var current_level: Level

# Handles switching levels and pausing

func _ready() -> void:
	# get reference to level currently in the tree
	for child in get_children():
		if child is Level:
			current_level = child
		break
	# listens for when the level says it wants to change
	current_level.level_changed.connect(on_level_changed)

# Switches out the level child node to the one given
func on_level_changed(next_level_scene: PackedScene) -> void:
	# Makes the next level a scene from a packed scene
	var next_level := next_level_scene.instantiate()

	# removes previous level
	current_level.level_changed.disconnect(on_level_changed)
	current_level.queue_free()

	# adds new level
	add_child(next_level)
	next_level.level_changed.connect(on_level_changed)
	current_level = next_level

# Press escape to pause
# Everything else doesn't run when paused
func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("ui_cancel")):
		$PauseMenu.position = current_level.get_camera_position()
		$PauseMenu.pause_game()
