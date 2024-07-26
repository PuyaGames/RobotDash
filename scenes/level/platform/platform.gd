extends StaticBody2D
class_name Platform2D


@export_enum("Long : 0", "Short : 1") var type : int = 0


func init_platform(map_type : Enums.EMapType) -> void:
	if map_type == Enums.EMapType.Halloween_Green:
		_set_platform_by_bean(type, load(Paths.map_halloween_green_bean))
	elif map_type == Enums.EMapType.Halloween_Red:
		_set_platform_by_bean(type, load(Paths.map_halloween_red_bean))
	elif map_type == Enums.EMapType.Halloween_Blue:
		_set_platform_by_bean(type, load(Paths.map_halloween_blue_bean))
	elif map_type == Enums.EMapType.Halloween_Orange:
		_set_platform_by_bean(type, load(Paths.map_halloween_orange_bean))
	elif map_type == Enums.EMapType.Sweet_Pink:
		_set_platform_by_bean(type, load(Paths.map_sweet_pink_bean))
	elif map_type == Enums.EMapType.Sweet_Blue:
		_set_platform_by_bean(type, load(Paths.map_sweet_blue_bean))
	elif map_type == Enums.EMapType.Sweet_Green:
		_set_platform_by_bean(type, load(Paths.map_sweet_green_bean))
	elif map_type == Enums.EMapType.Sweet_Cyan:
		_set_platform_by_bean(type, load(Paths.map_sweet_cyan_bean))
	elif map_type == Enums.EMapType.Desert_Cactus:
		_set_platform_by_bean(type, load(Paths.map_desert_cactus_bean))
	elif map_type == Enums.EMapType.Desert_Rock:
		_set_platform_by_bean(type, load(Paths.map_desert_rock_bean))
	elif map_type == Enums.EMapType.Desert_Sky:
		_set_platform_by_bean(type, load(Paths.map_desert_sky_bean))
	elif map_type == Enums.EMapType.Desert_Dusk:
		_set_platform_by_bean(type, load(Paths.map_desert_dusk_bean))
	elif map_type == Enums.EMapType.Beach_Blue:
		_set_platform_by_bean(type, load(Paths.map_beach_blue_bean))
	elif map_type == Enums.EMapType.Beach_Green:
		_set_platform_by_bean(type, load(Paths.map_beach_green_bean))
	elif map_type == Enums.EMapType.Beach_Cyan:
		_set_platform_by_bean(type, load(Paths.map_beach_cyan_bean))
	elif map_type == Enums.EMapType.Beach_Dusk:
		_set_platform_by_bean(type, load(Paths.map_beach_dusk_bean))
	
	
func spawn_enemies() -> void:
	var enemy_spawn_path : EnemySpawnPath
	if has_node("EnemySpawnPath"):
		enemy_spawn_path = get_node("EnemySpawnPath")
		enemy_spawn_path.spawn_enemies()
	
	
func clear_enemies() -> void:
	var enemy_spawn_path : EnemySpawnPath
	if has_node("EnemySpawnPath"):
		enemy_spawn_path = get_node("EnemySpawnPath")
		enemy_spawn_path.clear_enemies()
	
	
func _set_platform_by_bean(platform_type : int, map_bean : MapBean) -> void:
	if platform_type == 0:
		$Sprite2D.texture = map_bean.long_platform_texture
	else:
		$Sprite2D.texture = map_bean.short_platform_texture
