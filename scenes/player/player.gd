extends CharacterBody2D
class_name Player

# movement parameters (play with them in the inspector ->)
@export var SPEED: float = 400
@export var ACCEL_TIME: float = 0.2  # time to full speed in seconds
@export var JUMP_VELOCITY: float = -700 # (negative is up, positive is down)
@export var JUMP_GRAVITY_MIN: float = 1200  # Short press
@export var JUMP_GRAVITY_MAX: float = 3600  # Long press
@export var FALL_GRAVITY: float = 1500  # fall faster than you rise

const terminal_velocity := 800.0
const max_jump_held_time := 1.0
var jump_held_timer := 0.0
var jump_held := false                  # if jump button is held

var knockback := Vector2.ZERO

# for friction
var tile_map_layer: TileMapLayer = null
@onready var tile_collider := $TileCollider
var friction: float = 1

func _ready() -> void:
	$AnimatedSprite2D.play()

# Handles player input and movement
func _physics_process(delta: float) -> void:

	# VERTICAL MOVEMENT
	# --------------------------------------------
	if jump_held:
		jump_held_timer += delta
	
	# Add gravity if in the air
	if not is_on_floor():
		var grav := 0.0
		if (velocity.y <= 0):
			if jump_held:
				grav = JUMP_GRAVITY_MIN
			else:
				# variable jump height, based on holding jump
				grav = clamp(lerp(JUMP_GRAVITY_MIN, JUMP_GRAVITY_MAX,
								  1-jump_held_timer/max_jump_held_time),
							 JUMP_GRAVITY_MIN, JUMP_GRAVITY_MAX)
		else:
			grav = FALL_GRAVITY

		velocity.y += minf(grav * delta, terminal_velocity)

	# Handle jump if on the ground
	if Input.is_action_just_pressed("jump") and is_on_floor():
		$JumpSound.play()
		velocity.y = JUMP_VELOCITY
		jump_held = true
		jump_held_timer = 0.0
		
	if Input.is_action_just_released("jump") and jump_held:
		jump_held = false

	# HORIZONTAL MOVEMENT
	# -------------------------------------------------
	# if on floor, get friction of tile below
	if is_on_floor():
		if get_tile_friction() != -1:
			friction = get_tile_friction()
	else:
		friction = 1

	var accel: float = SPEED/ACCEL_TIME  # acceleration = velocity / time
	var true_accel: float = accel * friction  # less friction less acceleration
	var max_speed: float = SPEED / friction   # less friction more speed

	# direction player is trying to move
	#    left=-1, not moving=0, right=1
	var direction := Input.get_axis("move_left", "move_right")

	# if moving, we accelerate in that direction
	if (direction != 0):
		if (direction > 0 and velocity.x < max_speed) or \
		   (direction < 0 and velocity.x > -max_speed) or \
		   is_on_floor():
			velocity.x += direction * true_accel * delta
			velocity.x = clamp(velocity.x, -max_speed, max_speed)

	# otherwise slow the player down
	else:
		velocity.x = move_toward(velocity.x, 0, true_accel*delta)
		
	if (jump_held and velocity.y >= 0):
		jump_held = false
		jump_held_timer = 0.0
		
	if (knockback != Vector2.ZERO):
		velocity += knockback
		knockback = Vector2.ZERO

	# ANIMATION
	# -------------------------------------------------
	if (is_on_floor()):
		if (direction != 0):
			$AnimatedSprite2D.animation = "walk"
		else:
			$AnimatedSprite2D.animation = "idle"
	elif (velocity.y <= 0):
		$AnimatedSprite2D.animation = "jump"
	else:
		$AnimatedSprite2D.animation = "fall"
	if (direction != 0):
		$AnimatedSprite2D.flip_h = direction == -1
		
	
	move_and_slide() # moves and collides player based on velocity

signal player_dead
func hurt() -> void:
	$HitSound.play()
	player_dead.emit()

func _on_hurt_box_body_entered(body):
	hurt()
	
func _on_hurt_box_area_entered(area: Area2D) -> void:
	hurt()
	
func flip_collision():
	set_collision_mask_value(2, !get_collision_mask_value(2))	
	set_collision_mask_value(3, !get_collision_mask_value(3))	

# get friction (custom data value) of tile directly below player
# returns friction as a percentage were 1.0 is normal friction
# if there is no tile, return -1
func get_tile_friction() -> float:
	if tile_map_layer == null:
		return -1
	var tile_cell_pos: Vector2i = tile_map_layer.local_to_map(tile_collider.global_position)
	var tile_data: TileData = tile_map_layer.get_cell_tile_data(tile_cell_pos)
	if tile_data:
		var tile_friction: float = tile_data.get_custom_data("friction")
		return(tile_friction)
	return -1
	
func set_knockback(knock : Vector2):
	if knockback == Vector2.ZERO:
		knockback = knock
