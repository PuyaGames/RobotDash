extends Line2D


func _ready() -> void:
	if points.size() != 2:
		return
		
	var point_left : Vector2 = points[0]
	var point_right : Vector2 = points[1]
	var path_length : float = point_right.x - point_left.x
	var path_y : float = point_left.y
	
	var tscn_enemy : PackedScene = load("res://scenes/character/enemy/enemy.tscn")
	var enemy : Enemy = tscn_enemy.instantiate()
	
	enemy.position = Vector2(path_length / 2, path_y)
	add_child(enemy)
