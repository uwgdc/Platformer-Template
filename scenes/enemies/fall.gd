extends State

@export var patrol_state: State	
@export var chase_state: State	

func enter(transition_from: State) -> void:
	super(transition_from)
	parent.animatedSprite.animation = "fall"
	
func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null
	
func process_physics(delta: float) -> State:
	parent.velocity.y += parent.FALL_GRAVITY * delta
	parent.velocity.y = min(parent.velocity.y, parent.TERMINAL_VELOCITY)
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if previous_state == chase_state:
			return chase_state
		return patrol_state
	return null
