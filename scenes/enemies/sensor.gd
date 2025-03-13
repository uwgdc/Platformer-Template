extends Node2D

var parent = null
var player: Player = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func atTallWall() -> bool:
	if $TallWallRay.is_colliding():
		return true
	return false
	
func atShortWall() -> bool:
	if !$TallWallRay.is_colliding() and $ShortWallRay.is_colliding():
		return true
	return false

func isFloorInFront() -> bool:
	if $FloorRay.is_colliding():
		return true
	return false
	
func isPlayerNear() -> bool:
	#if player == null: return false
	assert(player!= null)
	if parent.position.distance_to(player.position) < 200.0:
		return true
	return false
	
func playerDirection() -> float:
	assert(player!= null)
	if player == null: return 1.0
	assert(player != null)
	return parent.position.direction_to(player.position).x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		
	
		
