extends CharacterBody2D

@onready var stateMachine : StateMachine = $StateMachine
@onready var animatedSprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var sensor = $Sensor

var level: Level = null
var player: Player = null

@export var facing = 1
	
# movement parameters (play with them in the inspector ->)
@export var WALK_SPEED: float = 200
@export var RUN_SPEED: float = 300
@export var ACCEL_TIME: float = 0.2  # time to full speed in seconds
@export var JUMP_VELOCITY: float = -700 # (negative is up, positive is down)
@export var JUMP_GRAVITY: float = 1200
@export var FALL_GRAVITY: float = 1500  # fall faster than you rise
@export var TERMINAL_VELOCITY := 800.0

func _ready() -> void:
	$AnimatedSprite2D.play()
	if facing < 0:
		scale = Vector2(-1,1)
	
	stateMachine.init(self)

func init(_player:Player, _level:Level):
	player = _player
	level = _level
	sensor.player = player
	sensor.parent = self

func _unhandled_input(event: InputEvent) -> void:
	stateMachine.process_input(event)
	
func _physics_process(delta: float) -> void:
	stateMachine.process_physics(delta)
	
func _process(delta: float) -> void:
	stateMachine.process_frame(delta)
	if facing == -1 and velocity.x > 0:
		scale = Vector2(-1,-1)
		facing = 1
	if facing == 1 and velocity.x < 0:
		scale = Vector2(-1,1)
		facing = -1
	
	
func flip_collision():
	set_collision_mask_value(2, !get_collision_mask_value(2))	
	set_collision_mask_value(3, !get_collision_mask_value(3))	
