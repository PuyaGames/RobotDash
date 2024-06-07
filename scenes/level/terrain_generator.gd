extends Node2D
class_name TerrainGenerator


@onready var terrain_01 : Terrain = $"Terrain1"
@onready var terrain_02 : Terrain = $"Terrain2"
@onready var terrain_03 : Terrain = $"Terrain3"

const terrain_length : float = 1464.0
var update_trigger_position_x : float
var update_trigger_offset : float = 20.0
var temp_terrain : Terrain
var terrain_list : Array[Terrain] = []
var terrain_generating_count : int = 0

func _ready() -> void:
	terrain_list = [terrain_01, terrain_02, terrain_03]


func move_forward(speed : float, delta : float) -> void:
	var moved_distance : float = speed * delta
	for terrain in terrain_list:
		terrain.position.x -= moved_distance
	update_trigger_position_x = terrain_list[1].position.x
	if update_trigger_position_x < 0.0 - update_trigger_offset:
		terrain_list[0].position.x = terrain_list[2].position.x + terrain_length
		temp_terrain = terrain_list[0]
		terrain_list[0] = terrain_list[1]
		terrain_list[1] = terrain_list[2]
		terrain_list[2] = temp_terrain
