extends Node2D
class_name TerrainGenerator


@onready var terrain_root_01 : Node2D = $"TerrainRoot1"
@onready var terrain_root_02 : Node2D = $"TerrainRoot2"
@onready var terrain_root_03 : Node2D = $"TerrainRoot3"
@onready var terrain_01 : Terrain = $"TerrainRoot1/Terrain1"
@onready var terrain_02 : Terrain = $"TerrainRoot2/Terrain2"
@onready var terrain_03 : Terrain = $"TerrainRoot3/Terrain3"

const terrain_length : float = 1784.0
var update_trigger_position_x : float
var update_trigger_offset : float = 20.0
var terrain_generating_count : int = 0
var terrain_root_list : Array[Node2D] = []
var terrain_list : Array[Node2D] = []
var level : Level


func _ready() -> void:
	level = get_tree().get_first_node_in_group("level") as Level
	terrain_root_list = [terrain_root_01, terrain_root_02, terrain_root_03]
	terrain_list = [terrain_01, terrain_02, terrain_03]
	terrain_01.regenerate_platform_assemply_01(Enums.EPlatformAssemblyType.N_S_N_R)
	terrain_02.random_regenerate_platform_assembly()
	terrain_03.random_regenerate_platform_assembly()


var temp_terrain_root : Node2D
var temp_terrain : Terrain

func move_forward(speed : float, delta : float) -> void:
	var moved_distance : float = speed * delta
	for terrain_root in terrain_root_list:
		terrain_root.position.x -= moved_distance
	update_trigger_position_x = terrain_root_list[1].position.x
	if update_trigger_position_x < 0.0 - update_trigger_offset:
		terrain_root_list[0].position.x = terrain_root_list[2].position.x + terrain_length
		terrain_list[0].random_regenerate_platform_assembly()
		terrain_generating_count += 1
		temp_terrain_root = terrain_root_list[0]
		temp_terrain = terrain_list[0]
		terrain_root_list[0] = terrain_root_list[1]
		terrain_list[0] = terrain_list[1]
		terrain_root_list[1] = terrain_root_list[2]
		terrain_list[1] = terrain_list[2]
		terrain_root_list[2] = temp_terrain_root
		terrain_list[2] = temp_terrain
		
		
func init_terrain_generator(map_type : Enums.EMapType) -> void:
	terrain_01.init_terrain(map_type)
	terrain_02.init_terrain(map_type)
	terrain_03.init_terrain(map_type)
	
