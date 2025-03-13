class_name State
extends Node

var parent: CharacterBody2D
var move_component: Node
var previous_state: State = null

func enter(previous_state: State) -> void:
	previous_state = previous_state
	
func exit() -> void:
	pass
	
func process_input(event: InputEvent) -> State:
	return null
	
func process_frame(delta: float) -> State:
	return null
	
func process_physics(delta: float) -> State:
	return null
