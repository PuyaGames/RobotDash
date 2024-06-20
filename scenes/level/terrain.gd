extends Node2D
class_name Terrain


@export var first_terrain : bool = false

@onready var platform_assembly_01 : PlatformAssembly = $"PlatformAssembly1"
@onready var platform_assembly_02 : PlatformAssembly = $"PlatformAssembly2"


func regenerate_platform_assemply(type_01 : Enums.EPlatformAssemblyType, type_02 : Enums.EPlatformAssemblyType) -> void:
	platform_assembly_01.regenerate(type_01)
	platform_assembly_02.regenerate(type_02)
	
	
func regenerate_platform_assemply_01(type : Enums.EPlatformAssemblyType) -> void:
	platform_assembly_01.regenerate(type)
	platform_assembly_02.regenerate(_random_pick_platform_assembly_type())


func regenerate_platform_assemply_02(type : Enums.EPlatformAssemblyType) -> void:
	platform_assembly_01.regenerate(_random_pick_platform_assembly_type())
	platform_assembly_02.regenerate(type)
	

func random_regenerate_platform_assembly() -> void:
	platform_assembly_01.regenerate(_random_pick_platform_assembly_type())
	platform_assembly_02.regenerate(_random_pick_platform_assembly_type())


func _random_pick_platform_assembly_type() -> Enums.EPlatformAssemblyType:
	return Config.platform_assembly_type_pool.pick_random()
	
	
func init_terrain(map_type : Enums.EMapType) -> void:
	platform_assembly_01.init_platform_assembly(map_type)
	platform_assembly_02.init_platform_assembly(map_type)
	
	if map_type == Enums.EMapType.Halloween_Green:
		_set_terrain_by_bean(load(Paths.map_halloween_green_bean))
	elif map_type == Enums.EMapType.Halloween_Red:
		_set_terrain_by_bean(load(Paths.map_halloween_red_bean))
	elif map_type == Enums.EMapType.Halloween_Blue:
		_set_terrain_by_bean(load(Paths.map_halloween_blue_bean))
	elif map_type == Enums.EMapType.Halloween_Orange:
		_set_terrain_by_bean(load(Paths.map_halloween_orange_bean))
	elif map_type == Enums.EMapType.Sweet_Pink:
		_set_terrain_by_bean(load(Paths.map_sweet_pink_bean))
	elif map_type == Enums.EMapType.Sweet_Blue:
		_set_terrain_by_bean(load(Paths.map_sweet_blue_bean))
	elif map_type == Enums.EMapType.Sweet_Green:
		_set_terrain_by_bean(load(Paths.map_sweet_green_bean))
	elif map_type == Enums.EMapType.Sweet_Cyan:
		_set_terrain_by_bean(load(Paths.map_sweet_cyan_bean))
	elif map_type == Enums.EMapType.Desert_Cactus:
		_set_terrain_by_bean(load(Paths.map_desert_cactus_bean))
	elif map_type == Enums.EMapType.Desert_Rock:
		_set_terrain_by_bean(load(Paths.map_desert_rock_bean))
	elif map_type == Enums.EMapType.Desert_Sky:
		_set_terrain_by_bean(load(Paths.map_desert_sky_bean))
	elif map_type == Enums.EMapType.Desert_Dusk:
		_set_terrain_by_bean(load(Paths.map_desert_dusk_bean))
	elif map_type == Enums.EMapType.Beach_Blue:
		_set_terrain_by_bean(load(Paths.map_beach_blue_bean))
	elif map_type == Enums.EMapType.Beach_Green:
		_set_terrain_by_bean(load(Paths.map_beach_green_bean))
	elif map_type == Enums.EMapType.Beach_Cyan:
		_set_terrain_by_bean(load(Paths.map_beach_cyan_bean))
	elif map_type == Enums.EMapType.Beach_Dusk:
		_set_terrain_by_bean(load(Paths.map_beach_dusk_bean))
	

func _set_terrain_by_bean(map_bean : MapBean) -> void:
	$Sprite2D.texture = map_bean.terrain_texture
	$Sprite2D.position.y = map_bean.y_offset
