extends CharacterBody2D
class_name Player

var tile_map: TileMap = null
@onready var tile_collider = $TileCollider

# Player parameters
@export var SPEED: float = 400
@export var ACCEL_TIME: float = 0.2  # time to full speed in seconds
@export var JUMP_VELOCITY: float = -800 # (negative is up, positive is down)
@export var GRAVITY = 1200

func _physics_process(delta):
	# Add the gravity if in the air
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle jump if on the ground
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var ACCEL: float = SPEED/ACCEL_TIME
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x += direction * ACCEL * get_friction() * delta
		velocity.x = clamp(velocity.x, -SPEED, SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, ACCEL*get_friction()*delta)
	move_and_slide()

func get_friction() -> float:
	var tile_cell_pos: Vector2i = tile_map.local_to_map(tile_collider.global_position)
	var tile_data: TileData = tile_map.get_cell_tile_data(0, tile_cell_pos)
	if tile_data:
		var friction = tile_data.get_custom_data("friction")
		print(friction)
		return(friction)
	return 1
