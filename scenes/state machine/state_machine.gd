extends Node
class_name StateMachine

@export
var initial_state: State
var current_state: State
var previous_state: State = null

# give children states a reference to the parent and set the state
# to the initial state
func init(parent: CharacterBody2D) -> void:
	for child in get_children():
		if child is State:
			child.parent = parent
		
	assert(initial_state != null)
	change_state(initial_state)
	
# change to new state by calling exit on the old state and 
# enter on the new one
func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
		
	previous_state = current_state
	current_state = new_state
	current_state.enter(previous_state)

# Pass through functions for the player to call, states manage
# the actual processes. Handles state changes as requested by
# the transitioning state
func process_physics(delta: float) -> void:
	var new_state: State = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state: State = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state: State = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
