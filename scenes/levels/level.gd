extends Node
class_name Level

signal level_changed(level_name: PackedScene)

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

# center camera on the player
func _process(_delta: float) -> void:
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

# get position of the center of the camera
func get_camera_position() -> Vector2i:
	return $Camera2D.get_screen_center_position() -  \
		   (get_viewport().content_scale_size as Vector2) / 2
