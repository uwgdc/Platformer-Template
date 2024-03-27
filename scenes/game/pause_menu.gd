extends MarginContainer

var paused: bool = false

@onready var continue_button = $MarginContainer/VBoxContainer/ContinueButton

#func _ready():
	#continue_button.grab_focus()

func pause_game():
	MenuSounds.play_button_press()
	get_tree().paused = true
	continue_button.grab_focus()
	show()
	
func continue_game():
	MenuSounds.play_button_press()
	hide()
	paused = false
	get_tree().paused = false

func _process(_delta):
	if !paused:
		paused = true
		return
	if (Input.is_action_just_pressed("ui_cancel")):
		continue_game()


func _on_quit_button_pressed():
	MenuSounds.play_button_press()
	get_tree().quit()
