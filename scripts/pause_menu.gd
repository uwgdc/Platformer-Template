extends MarginContainer

var paused: bool = false
func pause_game():
	get_tree().paused = true
	show()
	
func continue_game():
	hide()
	get_tree().paused = false

func _process(_delta):
	if !paused:
		paused = true
		return
	if (Input.is_action_just_pressed("ui_cancel")):
		paused = false
		continue_game()
