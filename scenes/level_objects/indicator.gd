extends Sprite2D

@onready var animation_player = $AnimationPlayer

func appear():
	animation_player.play("appear")
	
func disappear():
	animation_player.play("disappear")
