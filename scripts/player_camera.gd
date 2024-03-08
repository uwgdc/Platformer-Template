extends Camera2D

@onready var viewport_size = get_viewport().content_scale_size

func set_limits(limits: Rect2i):
	if (limits.size[0] < viewport_size[0]):
		limit_left = (limits.position[0]+limits.end[0])/2  - viewport_size[0]/2
		limit_right = limit_left + viewport_size[0]
	else:
		limit_left = limits.position[0]
		limit_right = limits.end[0]
		
	if (limits.size[1] < viewport_size[1]):
		limit_top = (limits.position[1]+limits.end[1])/2  - viewport_size[1]/2
		limit_bottom = limit_top + viewport_size[1]
	else:
		limit_top = limits.position[1]
		limit_bottom = limits.end[1]
