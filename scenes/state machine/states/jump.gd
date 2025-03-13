extends State

@export var idle_state: State	
@export var walk_state: State	
@export var fall_state: State	

var max_jump_time: float = 0.8
var max_jump_timer: float = 0
var max_grav_m: float = 8
var held: bool = false

func enter(transition_from: State) -> void:
	super(transition_from)
	parent.velocity.y = parent.jump_velocity
	max_jump_timer = max_jump_time
	held = true

func process_input(event: InputEvent) -> State:
	if !move_component.held_jump():
		held = false
	return null
	
func process_frame(delta: float) -> State:
	if (held):
		max_jump_timer -= delta
	return null
	
func process_physics(delta: float) -> State:
	var grav = parent.jump_gravity
	if !held:
		grav *= max(lerp(1.0, max_grav_m, max_jump_timer/max_jump_time), 1)
	parent.velocity.y += grav * delta
	parent.velocity.x = parent.move_speed * move_component.move_direction()
	
	if (parent.left_outer.is_colliding() and !(parent.left_inner.is_colliding() or
										parent.right_inner.is_colliding() or
										parent.right_outer.is_colliding())):
		for i in 10:
			parent.position.x += 1
			if !parent.left_outer.is_colliding(): break
		#parent.position.x += 8
	if (parent.right_outer.is_colliding() and !(parent.left_inner.is_colliding() or
										parent.right_inner.is_colliding() or
										parent.left_outer.is_colliding())):
		for i in 10:
			parent.position.x -= 1
			if !parent.right_outer.is_colliding(): break
		#parent.position.x -= 8
	parent.move_and_slide()
	
	if parent.velocity.y >= 0:
		return fall_state
	
	if parent.is_on_floor():
		if move_component.move_direction() == 0:
			return idle_state
		else:
			return walk_state
	return null
