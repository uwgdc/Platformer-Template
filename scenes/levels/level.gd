extends Node
class_name Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Gives the level objects references to the player and the level
	for child in get_children():
		if (child is LevelObject):
			child.player = $Player
			child.level = self

	# Give the player a reference to the tile map
	$Player.tile_map = $LevelTileMap

	$Camera2D.set_limits(get_limits())

func _input(event):
	# pause button pressed!
	if event.is_action_pressed("ui_cancel"):
		Global.play_button_press_sound()
		Global.pause_game()
		get_viewport().set_input_as_handled()


func _process(_delta: float) -> void:
	# center camera on the player
	$Camera2D.global_position = $Player.position


# return the boundaries of the level
func get_limits() -> Rect2i:
	var limits: Rect2i = $LevelTileMap.get_used_rect()
	var tile_size: Vector2i = $LevelTileMap.tile_set.tile_size
	limits.position.x *= tile_size.x
	limits.position.y *= tile_size.y
	limits.end.x *= tile_size.x
	limits.end.y *= tile_size.y

	return limits

