extends CharacterBody2D
class_name Player

var tile_map: TileMap = null
@onready var tile_collider = $TileCollider

# movement parameters (play with them in the inspector ->)
@export var SPEED: float = 400
@export var ACCEL_TIME: float = 0.2  # time to full speed in seconds
@export var JUMP_VELOCITY: float = -600 # (negative is up, positive is down)
@export var GRAVITY = 1200

# Handles player input and movement
func _physics_process(delta):
	# VERTICAL MOVEMENT
	# Add gravity if in the air
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle jump if on the ground
	if Input.is_action_just_pressed("jump") and is_on_floor():
		$JumpSound.play()
		velocity.y = JUMP_VELOCITY


	# HORIZONTAL MOVEMENT
	var ACCEL: float = SPEED/ACCEL_TIME  # acceleration = velocity / time
	var true_accel: float = ACCEL * get_tile_friction()
	var max_speed: float = SPEED / get_tile_friction()
	
	# direction player is trying to move
	#    left=-1, not moving=0, right=1
	var direction = Input.get_axis("move_left", "move_right")
	
	# if moving, we accelerate in that direction
	if direction != 0:
		velocity.x += direction * true_accel * delta
		velocity.x = clamp(velocity.x, -max_speed, max_speed)
	
	# otherwise slow the player down
	else:
		velocity.x = move_toward(velocity.x, 0, true_accel*delta)
		
	move_and_slide() # moves and collides player based on velocity

# get friction (custom data value) of tile directly below player
# returns friction as a percentage were 1.0 is normal friction
func get_tile_friction() -> float:
	if tile_map == null:
		return 1
	var tile_cell_pos: Vector2i = tile_map.local_to_map(tile_collider.global_position)
	var tile_data: TileData = tile_map.get_cell_tile_data(0, tile_cell_pos)
	if tile_data:
		var friction = tile_data.get_custom_data("friction")
		return(friction)
	return 1
