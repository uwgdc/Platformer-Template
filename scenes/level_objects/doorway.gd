extends LevelObject

@export_file("*.tscn") var to_level: String

func interaction() -> void:
	var level := load(to_level) as PackedScene
	Global.change_level(level)
