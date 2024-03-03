class_name Player
extends CharacterBody2D

@onready var camera: Camera2D = $Camera2D

# Player parameters
const MOVE_SPEED = 400.0
const JUMP_VELOCITY = -600.0 # (negative is up, positive is down)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1000 #ProjectSettings.get_setting("physics/2d/default_gravity")

# called when player is loaded into level
#   sets camera limits to match size of level
func init (level: Level):
	camera.set_limits(level.get_limits())

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
