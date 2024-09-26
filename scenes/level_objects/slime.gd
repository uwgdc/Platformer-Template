extends Area2D

@export var knock_strength : float = 2000


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body = body as Player
		var dir := global_position.direction_to(body.position)
		if body.set_knockback(knock_strength * dir):
			$BounceSound.play()
		
