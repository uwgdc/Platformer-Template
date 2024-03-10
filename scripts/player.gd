extends CharacterBody2D
class_name Player

# Player parameters
const MOVE_SPEED = 400.0
const JUMP_VELOCITY = -600.0 # (negative is up, positive is down)
var gravity = 1000

func _physics_process(delta):
	# Add the gravity if in the air
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump if on the ground
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * MOVE_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, MOVE_SPEED)

	move_and_slide()

