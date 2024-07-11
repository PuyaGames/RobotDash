extends Line2D


@export var spawn_config : EnemySpawnConfig

var tscn_enemy : PackedScene


func _ready() -> void:
	tscn_enemy = load("res://scenes/character/enemy/enemy.tscn")
	spawn_enemy(0)


func spawn_enemy(current_odometer : int) -> void:
	if points.size() != 2:
		return
		
	var owner_platform : Platform2D = owner as Platform2D
	var positions : Array[Vector2]
	
	if owner_platform.type == 0:
		positions = _calculate_spawn_positions(4)
	else:
		positions = _calculate_spawn_positions(2)
	
	for pos in positions:
		var enemy : Enemy = tscn_enemy.instantiate()
		enemy.position = pos
		add_child(enemy)
	
	
func _calculate_spawn_positions(spawn_number : int) -> Array[Vector2]:
	var positions : Array[Vector2]
	
	var point_left : Vector2 = points[0]
	var point_right : Vector2 = points[1]
	var path_length : float = point_right.x - point_left.x
	var position_y : float = point_left.y
	
	for i in range(1, spawn_number * 2):
		if i % 2 == 0: continue
		positions.append(Vector2(path_length * (float(i) / (spawn_number * 2)), position_y))
		
	return positions
