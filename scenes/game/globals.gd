extends Node

# Autoloaded global scene
# can be called from any node at any time

signal level_changed(level: PackedScene)


func play_button_press_sound() -> void:
	$ButtonSound.play()


func change_scene(scene: PackedScene) -> void:
	get_tree().change_scene_to_packed(scene)


func change_level(level: PackedScene) -> void:
	change_scene(level)
	level_changed.emit(level)


# generally called by level
func pause_game() -> void:
	$PauseMenu.initialize_pause()
	get_tree().paused = true


func unpause_game() -> void:
	get_tree().paused = false
