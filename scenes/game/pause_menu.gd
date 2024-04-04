extends CanvasLayer

# Its a pause menu, runs when the tree is set to paused
# (see Node->Process->Mode in the inspector)

@onready var continue_button := $MarginContainer/MarginContainer/VBoxContainer/ContinueButton
	

func initialize_pause() -> void:
	show()
	continue_button.grab_focus()  # lets us use arrow keys


func _input(event: InputEvent) -> void:
	# unpause on ui_cancel
	if event.is_action_pressed("ui_cancel"):
		_on_continue_button_pressed()
		get_viewport().set_input_as_handled()


# called from QuitButton via signal
func _on_quit_button_pressed() -> void:
	Global.play_button_press_sound()
	get_tree().quit()


# called from ContinueButton via signal, or from above when ui_cancel is pressed
func _on_continue_button_pressed() -> void:
	Global.play_button_press_sound()
	hide()
	Global.unpause_game()
