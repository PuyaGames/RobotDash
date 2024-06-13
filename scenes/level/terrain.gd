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
