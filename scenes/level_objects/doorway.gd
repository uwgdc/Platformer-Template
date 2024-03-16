extends LevelObject

@export_file("*.tscn") var to_level: String

func interaction():
	var test = load(to_level) as PackedScene
	level.level_changed.emit(test)
