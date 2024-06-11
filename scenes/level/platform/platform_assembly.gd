extends Node
class_name PlatformAssembly


@export var platform_assembly_type : Enums.EPlatformAssemblyType = Enums.EPlatformAssemblyType.LLNN

@onready var platform_position_dict : Dictionary = {
	Enums.EPlatformAssemblyType.LLNN : Vector4(),
	Enums.EPlatformAssemblyType.SLLN : Vector4(),
	Enums.EPlatformAssemblyType.SLRN : Vector4(),
	Enums.EPlatformAssemblyType.LSNL : Vector4(),
	Enums.EPlatformAssemblyType.LSNR : Vector4(),
	Enums.EPlatformAssemblyType.SSLL : Vector4(),
	Enums.EPlatformAssemblyType.SSRR : Vector4(),
	Enums.EPlatformAssemblyType.SSLR : Vector4(),
	Enums.EPlatformAssemblyType.SSRL : Vector4(),
	Enums.EPlatformAssemblyType.SNLN : Vector4(),
	Enums.EPlatformAssemblyType.SNRN : Vector4(),
	Enums.EPlatformAssemblyType.NSNL : Vector4(),
	Enums.EPlatformAssemblyType.NSNR : Vector4(),
	Enums.EPlatformAssemblyType.LNNN : Vector4(),
	Enums.EPlatformAssemblyType.NLNN : Vector4(),
	Enums.EPlatformAssemblyType.NNNN : Vector4()
}

func _ready() -> void:
	var platform_positions : Vector4 = platform_position_dict[platform_assembly_type]

	var TypeString : String = Enums.EPlatformAssemblyType.keys()[platform_assembly_type]
	var platform_position : Vector4 = platform_position_dict[platform_assembly_type]
	
	if TypeString[0] != 'N':
		var platform_01 : Platform2D
		if TypeString[0] == 'L':
			platform_01 = Preload.tscn_long_platform.instantiate()
		else:
			platform_01 = Preload.tscn_short_platform.instantiate()
		platform_01.position = Vector2(platform_position.x, platform_position.y)
		
	if TypeString[1] != 'N':
		var platform_02 : Platform2D
		if TypeString[1] == 'L':
			platform_02 = Preload.tscn_long_platform.instantiate()
		else:
			platform_02 = Preload.tscn_short_platform.instantiate()
		platform_02.position = Vector2(platform_position.z, platform_position.w)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
