extends Camera2D

func set_limits(limits: Rect2i):
	print(limits.position, limits.end)
	self.limit_left = limits.position[0]
	self.limit_top = limits.position[1]
	self.limit_right = limits.end[0]
	self.limit_bottom = limits.end[1]
