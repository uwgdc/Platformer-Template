extends Node

# Autoloaded global scene
# can be called from any node at any time

# this signal is unused for now, it fires whenever we change level.
# use it to implement something like a score counter!
signal level_changed(level: PackedScene)


func play_button_press_sound() -> void:
	$ButtonSound.play()	


func change_level(level: PackedScene) -> void:
	get_tree().change_scene_to_packed(level)
	level_changed.emit(level)


# generally called by level
func pause_game() -> void:
	$PauseMenu.initialize_pause()
	get_tree().paused = true


func unpause_game() -> void:
	get_tree().paused = false
