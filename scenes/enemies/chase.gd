extends State

@export var fall_state: State	
@export var patrol_state: State

func enter(transition_from: State) -> void:
	super(transition_from)
	parent.animatedSprite.animation = "walk"
	
func process_input(event: InputEvent) -> State:
	return null
	
func process_physics(delta: float) -> State:
	var x_direction = parent.sensor.playerDirection()
		
	parent.velocity.x = parent.RUN_SPEED * x_direction
	parent.move_and_slide()
		
	if !parent.is_on_floor():
		return fall_state
	#if !parent.sensor.isPlayerNear():
		#return patrol_state
	
	return null
