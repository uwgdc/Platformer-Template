extends State

@export var jump_state: State	
@export var walk_state: State	
@export var fall_state: State	

func enter(transition_from: State) -> void:
	super(transition_from)
	parent.velocity.x = 0
	
func process_input(event: InputEvent) -> State:
	if move_component.wants_jump() and parent.is_on_floor():
		return jump_state
	if move_component.move_direction() != 0:
		return walk_state
	return null
	
func process_physics(delta: float) -> State:
	if !parent.is_on_floor():
		return fall_state
	return null
