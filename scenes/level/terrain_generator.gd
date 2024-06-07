extends Node2D
class_name TerrainGenerator


@onready var terrain_root_01 : Node2D = $"Terrain1"
@onready var terrain_root_02 : Node2D = $"Terrain2"
@onready var terrain_root_03 : Node2D = $"Terrain3"

const terrain_length : float = 1464.0
var update_trigger_position_x : float
var update_trigger_offset : float = 20.0
var temp_terrain_root : Terrain
var terrain_root_list : Array[Terrain] = []
var terrain_generating_count : int = 0

func _ready() -> void:
	terrain_root_list = [terrain_root_01, terrain_root_02, terrain_root_03]


func move_forward(speed : float, delta : float) -> void:
	var moved_distance : float = speed * delta
	for terrain in terrain_root_list:
		terrain.position.x -= moved_distance
	update_trigger_position_x = terrain_root_list[1].position.x
	if update_trigger_position_x < 0.0 - update_trigger_offset:
		terrain_root_list[0].position.x = terrain_root_list[2].position.x + terrain_length
		temp_terrain_root = terrain_root_list[0]
		terrain_root_list[0] = terrain_root_list[1]
		terrain_root_list[1] = terrain_root_list[2]
		terrain_root_list[2] = temp_terrain_root
