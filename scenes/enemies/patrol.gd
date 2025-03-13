extends State

@export var fall_state: State	
@export var chase_state: State

func enter(transition_from: State) -> void:
	super(transition_from)
	parent.animatedSprite.animation = "walk"
	
func process_input(event: InputEvent) -> State:
	return null
	
func process_physics(delta: float) -> State:
	var x_direction = parent.facing
	
	# turn around at ledge
	if !parent.sensor.isFloorInFront():
		x_direction *= -1
		
	parent.velocity.x = parent.WALK_SPEED * x_direction
	parent.move_and_slide()
		
	if !parent.is_on_floor():
		return fall_state
	#print(parent.sensor.isPlayerNear())
	if parent.sensor.isPlayerNear():
		return chase_state
	
	return null
