extends Camera2D

@onready var viewport_size := get_window().content_scale_size

# Sets the camera limits to the given rectangle bounding box
#   If the bounding box is smaller than the viewport, make the limit size the same
#   as the viewport
func set_limits(limits: Rect2i) -> void:
	var x: int = int((limits.position.x +limits.end.x) / 2.0)
	var y: int = int((limits.position.y +limits.end.y) / 2.0)
	var limit_center := Vector2i(x, y)

	if (limits.size.x < viewport_size.x):
		limit_left = int(limit_center.x - viewport_size.x * .5)
		limit_right = limit_left + viewport_size.x
	else:
		limit_left = limits.position.x
		limit_right = limits.end.x

	if (limits.size.y < viewport_size.y):
		limit_top = int(limit_center.y - viewport_size.y * .5)
		limit_bottom = limit_top + viewport_size.y
	else:
		limit_top = limits.position.y
		limit_bottom = limits.end.y
