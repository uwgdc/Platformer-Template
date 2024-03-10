extends Node
class_name Level

@onready var tile_map: TileMap = $LevelTileMap
@onready var camera: Camera2D = $Player/Camera2D
@onready var player: Player = $Player
signal level_changed(level_name: PackedScene)

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if (child is LevelObject):
			child.player = $Player
			child.level = self

	$Player/Camera2D.set_limits(get_limits())
	$Player.tile_map = tile_map

# return the boundaries of the level
func get_limits() -> Rect2i:
	var limits: Rect2i = tile_map.get_used_rect()
	var tile_size: Vector2i = tile_map.tile_set.tile_size
	limits.position.x *= tile_size.x
	limits.position.y *= tile_size.y
	limits.end.x *= tile_size.x
	limits.end.y *= tile_size.y
	
	return limits
	
func get_camera_position():
	return camera.get_screen_center_position() -  \
		   (get_viewport().content_scale_size as Vector2) / 2
