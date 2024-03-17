extends MarginContainer

var paused: bool = false

@onready var continue_button = $MarginContainer/VBoxContainer/ContinueButton

#func _ready():
	#continue_button.grab_focus()

func pause_game():
	$ButtonSound.play()
	get_tree().paused = true
	continue_button.grab_focus()
	show()
	
func continue_game():
	$ButtonSound.play()
	hide()
	get_tree().paused = false

func _process(_delta):
	if !paused:
		paused = true
		return
	if (Input.is_action_just_pressed("ui_cancel")):
		paused = false
		continue_game()


func _on_quit_button_pressed():
	$ButtonSound.play()
	get_tree().quit()
