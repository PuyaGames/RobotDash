extends Node


# TapTapADN
const media_id : int = 1008256
const media_name : String = "机器人快跑"
const media_key : String = "EcUJwj9otm1MWVrb5dv6HIMarxAefiKA7egruir72hcikTU3lpbSSLhHiasdVRmO"
const revive_space_id : int = 1037811
const store_space_id : int = 1037810
const map_theme_space_id : int = 1036744

var platform_assembly_occurrence_rate_dict : Dictionary = {
	Enums.EPlatformAssemblyType.L_L_N_N : 1.0,
	Enums.EPlatformAssemblyType.S_L_L_N : 1.0,
	Enums.EPlatformAssemblyType.S_L_R_N : 1.0,
	Enums.EPlatformAssemblyType.L_S_N_L : 0.4,
	Enums.EPlatformAssemblyType.L_S_N_R : 0.4,
	Enums.EPlatformAssemblyType.S_S_L_L : 0.2,
	Enums.EPlatformAssemblyType.S_S_R_R : 0.2,
	Enums.EPlatformAssemblyType.S_S_L_R : 0.2,
	Enums.EPlatformAssemblyType.S_S_R_L : 0.2,
	Enums.EPlatformAssemblyType.S_N_L_N : 0.1,
	Enums.EPlatformAssemblyType.S_N_R_N : 0.1,
	Enums.EPlatformAssemblyType.N_S_N_L : 0.1,
	Enums.EPlatformAssemblyType.N_S_N_R : 0.1,
	Enums.EPlatformAssemblyType.L_N_N_N : 0.1,
	Enums.EPlatformAssemblyType.N_L_N_N : 0.1,
	Enums.EPlatformAssemblyType.N_N_N_N : 0.1,
}

var platform_assembly_type_pool : Array[Enums.EPlatformAssemblyType]


func _ready() -> void:
	for key : int in Enums.EPlatformAssemblyType.values():
		var value : float = platform_assembly_occurrence_rate_dict[key]
		for i in range(value * 10):
			platform_assembly_type_pool.append(key)
	platform_assembly_type_pool.shuffle()
