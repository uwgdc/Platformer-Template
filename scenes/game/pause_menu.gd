extends MarginContainer

# Its a pause menu, runs when the tree is set to paused
# (see Node->Process->Mode in the inspector)

var paused: bool = false
@onready var continue_button := $MarginContainer/VBoxContainer/ContinueButton

# called from game
func pause_game() -> void:
	MenuSounds.play_button_press()
	get_tree().paused = true
	continue_button.grab_focus()  # lets us use arrow keys
	show()
	
# called from ContinueButton via signal
func continue_game() -> void:
	MenuSounds.play_button_press()
	hide()
	paused = false
	get_tree().paused = false

func _process(_delta: float) -> void:
	if !paused:
		paused = true
		return
	# lets us unpause with escape
	if (Input.is_action_just_pressed("ui_cancel")):
		continue_game()

# called from QuitButton via signal
func _on_quit_button_pressed() -> void:
	MenuSounds.play_button_press()
	get_tree().quit()
