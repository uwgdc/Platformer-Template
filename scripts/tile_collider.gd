extends Area2D

var tile_map: TileMap = null

func get_friction() -> float:
	var tile_cell_pos: Vector2i = body.local_to_map(global_position)
	var tile_data: TileData = body.get_cell_tile_data(0, tile_cell_pos)
	if (tile_data):
		


func _on_body_entered(body):
	if (body is TileMap):
		var tile_cell_pos: Vector2i = body.local_to_map(global_position)
		var tile_data: TileData = body.get_cell_tile_data(0, tile_cell_pos)
		
		if tile_data:
			var friction = tile_data.get_custom_data("friction")
			print(friction)
