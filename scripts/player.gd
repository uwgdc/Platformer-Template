extends CharacterBody2D
class_name Player

@onready var camera: Camera2D = $Camera2D

# Player parameters
const MOVE_SPEED = 400.0
const JUMP_VELOCITY = -600.0 # (negative is up, positive is down)
var gravity = 1000

var start_pos: Vector2

# called when player is loaded into level
#   sets camera limits to match size of level
func init (level: Level) -> void:
	camera.set_limits(level.get_limits())

func _ready():
	start_pos = position

func _physics_process(delta):
	# Add the gravity if in the air
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump if on the ground
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * MOVE_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, MOVE_SPEED)

	move_and_slide()
	
func reset_position():
	position = start_pos
	print("hi")
