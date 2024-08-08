extends LevelObject

func _ready():
	interactable = false
	super()

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		player.hurt()

