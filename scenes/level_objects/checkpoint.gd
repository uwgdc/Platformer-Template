extends LevelObject


func _ready():
	interactable = false
	super()
	
func _on_body_entered(body:Node2D) -> void:
	if (body is Player):
		level.playerRespawn = position + Vector2(32,-32)
		$AnimatedSprite2D.animation = "activated"
