extends Node2D
class_name PlatformAssembly


@export var platform_assembly_type : Enums.EPlatformAssemblyType = Enums.EPlatformAssemblyType.N_N_N_N

const long_platform_length : float = 640.0
const short_platform_length : float = 400.0
const offset_x : float = long_platform_length - short_platform_length

const platform_position_dict : Dictionary = {
	Enums.EPlatformAssemblyType.L_L_N_N : Vector4(0.0, 0.0, 0.0, 232.0),
	Enums.EPlatformAssemblyType.S_L_L_N : Vector4(0.0, 0.0, 0.0, 232.0),
	Enums.EPlatformAssemblyType.S_L_R_N : Vector4(offset_x, 0.0, 0.0, 232.0),
	Enums.EPlatformAssemblyType.L_S_N_L : Vector4(0.0, 0.0, 0.0, 232.0),
	Enums.EPlatformAssemblyType.L_S_N_R : Vector4(0.0, 0.0, offset_x, 232.0),
	Enums.EPlatformAssemblyType.S_S_L_L : Vector4(0.0, 0.0, 0.0, 232.0),
	Enums.EPlatformAssemblyType.S_S_R_R : Vector4(offset_x, 0.0, offset_x, 232.0),
	Enums.EPlatformAssemblyType.S_S_L_R : Vector4(0.0, 0.0, offset_x, 232.0),
	Enums.EPlatformAssemblyType.S_S_R_L : Vector4(offset_x, 0.0, 0.0, 232.0),
	Enums.EPlatformAssemblyType.S_N_L_N : Vector4(0.0, 0.0, 0.0, 232.0),
	Enums.EPlatformAssemblyType.S_N_R_N : Vector4(offset_x, 0.0, 0.0, 232.0),
	Enums.EPlatformAssemblyType.N_S_N_L : Vector4(0.0, 0.0, 0.0, 232.0),
	Enums.EPlatformAssemblyType.N_S_N_R : Vector4(0.0, 0.0, offset_x, 232.0),
	Enums.EPlatformAssemblyType.L_N_N_N : Vector4(0.0, 0.0, 0.0, 232.0),
	Enums.EPlatformAssemblyType.N_L_N_N : Vector4(0.0, 0.0, 0.0, 232.0),
	Enums.EPlatformAssemblyType.N_N_N_N : Vector4(0.0, 0.0, 0.0, 232.0),
}


func _ready() -> void:
	var TypeString : String = Enums.EPlatformAssemblyType.keys()[platform_assembly_type]
	var platform_position : Vector4 = platform_position_dict[platform_assembly_type]
	
	if TypeString[0] != 'N':
		var platform_01 : Platform2D
		if TypeString[0] == 'L':
			platform_01 = Preload.tscn_long_platform.instantiate()
		else:
			platform_01 = Preload.tscn_short_platform.instantiate()
		platform_01.position = Vector2(platform_position.x, platform_position.y)
		add_child(platform_01)
		
	if TypeString[2] != 'N':
		var platform_02 : Platform2D
		if TypeString[2] == 'L':
			platform_02 = Preload.tscn_long_platform.instantiate()
		else:
			platform_02 = Preload.tscn_short_platform.instantiate()
		platform_02.position = Vector2(platform_position.z, platform_position.w)
		add_child(platform_02)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
