class_name LevelObject
extends Area2D

var player: Player
var level: Level

# Level objects can be interactable
#  When the player touches the object, an arrow appears and allows the player
#  to interact with it
#  The interaction is determinted by interact()  (eg see doorway.gd)

@export var interactable: bool = false	
@export var indicator_offset: int = 0  # relative position of indicator to object
var can_interact: bool = false
var indicator_scene := preload("res://scenes/level_objects/indicator.tscn")
var indicator: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (interactable):
		body_entered.connect(_on_body_entered)
		body_exited.connect(_on_body_exited)
		indicator = indicator_scene.instantiate()
		add_child(indicator)
		indicator.position[1] -= indicator_offset

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if can_interact and Input.is_action_just_pressed("interact"):
		interaction()

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		indicator.appear()
		can_interact = true

func _on_body_exited(body: Node2D) -> void:
	if body == player:
		indicator.disappear()	
		can_interact = false
	
func interaction() -> void:
	pass
