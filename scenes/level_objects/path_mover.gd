extends Path2D

@export var closed := false
@export var SPEED = 100
@onready var path_follow = $PathFollow2D
@export var debug := false


var path_velocity : float
var path_length : float = -1
var progress : float = 0

func _ready() -> void:
	path_velocity = SPEED
	
	if !closed:
		path_length = curve.get_baked_length()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !closed:
		progress += path_velocity * delta
		if (progress > path_length or progress < 0):
			progress = pingpong(progress, path_length)
			path_velocity *= -1
			
		path_follow.progress = progress
		
	else: path_follow.progress += path_velocity * delta
