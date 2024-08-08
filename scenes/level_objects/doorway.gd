extends LevelObject

@export_file("*.tscn") var to_level: String

func _ready():
	interactable = true
	indicator_offset = 115
	super()

func interaction() -> void:
	level.level_cleared(to_level)
