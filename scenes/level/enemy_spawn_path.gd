extends Line2D
class_name EnemySpawnPath


@export var spawn_config : EnemySpawnConfig

var tscn_enemy : PackedScene
var enemy_type_pool : Array[Enums.EEnemyType]
var existing_enemy_list : Array[Enemy]
var player : Player


func _ready() -> void:
	tscn_enemy = load("res://scenes/character/enemy/enemy.tscn")
	player = get_tree().get_first_node_in_group("player") as Player
	
	for enemy_type in spawn_config.enemy_type_list:
		var key : String = Enums.EEnemyType.keys()[enemy_type]
		var value : float = spawn_config.enemy_occurrence_rate_dict[key]
		for i in range(value * 10):
			enemy_type_pool.append(enemy_type)
	enemy_type_pool.shuffle()


func spawn_enemies() -> void:
	if points.size() != 2:
		return
		
	var owner_platform : Platform2D = owner as Platform2D
	var positions : Array[Vector2]
	
	if owner_platform.type == 0:
		positions = _calculate_spawn_positions(4)
	else:
		positions = _calculate_spawn_positions(2)
	
	for i in positions.size():
		var enemy : Enemy = tscn_enemy.instantiate()
		enemy.init_enemy(enemy_type_pool.pick_random())
		enemy.hp = randi_range(int(player.hp * 0.8), int(player.hp * 1.2))
		enemy.position = positions[i]
		existing_enemy_list.append(enemy)
		add_child(enemy)
		
		
func clear_enemies() -> void:
	for enemy in existing_enemy_list:
		if enemy != null:
			enemy.queue_free()
	existing_enemy_list.clear()
	
	
func _calculate_spawn_positions(spawn_number : int) -> Array[Vector2]:
	var positions : Array[Vector2] = []
	
	var point_left : Vector2 = points[0]
	var point_right : Vector2 = points[1]
	var path_length : float = point_right.x - point_left.x
	var position_y : float = point_left.y
	
	for i in range(1, spawn_number * 2):
		if i % 2 == 0: continue
		positions.append(Vector2(path_length * (float(i) / (spawn_number * 2)), position_y))
		
	return positions
	
	
