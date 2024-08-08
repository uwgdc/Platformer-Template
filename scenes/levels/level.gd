extends Node
class_name Level

var next_level : PackedScene

@export var flip_blocks : bool
@export var flip_timer : float
var tik_flags = [false, false, false]

@onready var playerStartPos : Vector2 = $Player.position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (flip_blocks):
		$TickTimer.start(flip_timer)
		$TickTimer.connect("timeout", $Player.flip_collision)
	
	# Gives the level objects references to the player and the level
	for child in get_children():
		if (child is LevelObject):
			child.player = $Player
			child.level = self
			
	$LevelTileMap.update_internals()
	for child in $LevelTileMap.get_children():
		if (child is LevelObject):
			child.player = $Player
			child.level = self

	# Give the player a reference to the tile map
	$Player.tile_map = $LevelTileMap

	$Camera2D.set_limits(get_limits())

func _input(event) -> void:
	# pause button pressed!
	if event.is_action_pressed("ui_cancel"):
		Global.play_button_press_sound()
		Global.pause_game()
		get_viewport().set_input_as_handled()


func _process(_delta: float) -> void:
	# center camera on the player
	$Camera2D.global_position = $Player.position
	
	for i in range(0, 3):
		if (!tik_flags[i] and $TickTimer.time_left <= (i+1) * flip_timer/4):
			tik_flags[i] = true
			if $SmallTickSound:
				$SmallTickSound.play()

# return the boundaries of the level
func get_limits() -> Rect2i:
	var limits: Rect2i = $LevelTileMap.get_used_rect()
	var tile_size: Vector2i = $LevelTileMap.tile_set.tile_size
	limits.position.x *= tile_size.x
	limits.position.y *= tile_size.y
	limits.end.x *= tile_size.x
	limits.end.y *= tile_size.y

	return limits

# loads the next level scene and bring up level cleared screen
func level_cleared(level_path : String) -> void:
	%WinSound.play()
	next_level = load(level_path) as PackedScene
	$ClearScreen.visible = true
	%Button.grab_focus()
	get_tree().paused = true
	
func _on_button_pressed() -> void:
	get_tree().paused = false
	Global.change_level(next_level)


func _on_player_player_dead():
	$Player.position = playerStartPos

const greenTilesheets = [preload("res://assets/art/flip_block_green_off_tilesheet.png"),
						 preload("res://assets/art/flip_block_green_on_tilesheet.png")]
const pinkTilesheets = [preload("res://assets/art/flip_block_pink_off_tilesheet.png"),
						preload("res://assets/art/flip_block_pink_on_tilesheet.png")]

var tick : bool = 0
func _on_tick_timer_timeout():
	tik_flags = [false, false, false]
	if $BigTickSound:
		$BigTickSound.play()
	
	tick = !tick 
	var ts : TileSet = $LevelTileMap.tile_set
	ts.get_source(ts.get_source_id(2)).texture = greenTilesheets[int(!tick)]
	ts.get_source(ts.get_source_id(3)).texture = pinkTilesheets[int(tick)]

