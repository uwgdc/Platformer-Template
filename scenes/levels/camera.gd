extends Camera2D

@onready var viewport_size = get_viewport().content_scale_size

# Sets the camera limits to the given rectangle bounding box
#   If the bounding box is smaller than the viewport, make the limit size the same
#   as the viewport
func set_limits(limits: Rect2i):
	var limit_center = Vector2i((limits.position.x +limits.end.x) * .5, \
								(limits.position.y +limits.end.y) * .5) 
								
	if (limits.size.x < viewport_size.x):
		limit_left = limit_center.x - viewport_size.x * .5 
		limit_right = limit_left + viewport_size.x
	else:
		limit_left = limits.position.x
		limit_right = limits.end.x
		
	if (limits.size.y < viewport_size.y):
		limit_top = limit_center.y   - viewport_size.y * .5
		limit_bottom = limit_top + viewport_size.y
	else:
		limit_top = limits.position.y
		limit_bottom = limits.end.y
