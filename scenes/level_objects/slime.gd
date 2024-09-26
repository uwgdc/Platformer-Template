extends Area2D

@export var knock_strength : float = 2000


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body = body as Player
		body.set_knockback(knock_strength * global_position.direction_to(body.position))
