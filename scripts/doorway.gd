extends LevelObject

@export var to_level: String

func interaction():
	level.level_changed.emit(to_level)
