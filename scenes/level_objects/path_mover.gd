extends Path2D

@export var SPEED = 100
@onready var path_follow = $PathFollow2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path_follow.progress += SPEED * delta
