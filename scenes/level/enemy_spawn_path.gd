extends Line2D
class_name EnemySpawnPath


@export var spawn_config : EnemySpawnConfig

var tscn_enemy : PackedScene
var tscn_item_chest : PackedScene
var enemy_type_pool : Array[Enums.EEnemyType]
var existing_enemy_list : Array[Enemy]
var player : Player


func _ready() -> void:
	tscn_enemy = load(Paths.tscn_enemy)
	tscn_item_chest = load("res://scenes/level/item_chest.tscn")
	
	for enemy_type in spawn_config.enemy_type_list:
		var key : String = Enums.EEnemyType.keys()[enemy_type]
		var value : float = spawn_config.enemy_occurrence_rate_dict[key]
		for i in range(value * 100):
			enemy_type_pool.append(enemy_type)
	enemy_type_pool.shuffle()
	
	await get_tree().create_timer(2.0).timeout
	var main : Main = get_tree().get_first_node_in_group("main") as Main
	if main.active_level != null &&\
	   main.active_level.enable_main_menu_mode == false:
		player = main.active_level.player


func spawn_enemies() -> void:
	if points.size() != 2:
		return
		
	var owner_platform : Platform2D = owner as Platform2D
	var positions : Array[Vector2]
	
	if owner_platform.type == 0:
		positions = _calculate_spawn_positions(2)
	else:
		positions = _calculate_spawn_positions(1)
	
	for i in positions.size():
		var enemy : Enemy = tscn_enemy.instantiate()
		enemy.init_enemy(enemy_type_pool.pick_random())
		enemy.position = positions[i]
		existing_enemy_list.append(enemy)
		add_child(enemy)
		
		
func spawn_item_chest() -> void:
	if points.size() != 2:
		return
		
	var owner_platform : Platform2D = owner as Platform2D
	var positions : Array[Vector2] = _calculate_spawn_positions(1)
	
	for i in positions.size():
		var item_chest : ItemChest = tscn_item_chest.instantiate()
		item_chest.position = positions[i]
		add_child(item_chest)
		
		
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
	
	
func add_enemy_to_pool(enemy_type : Enums.EEnemyType, number : int) -> void:
	for i in range(number):
		enemy_type_pool.append(enemy_type)

