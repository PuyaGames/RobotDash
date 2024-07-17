extends Node2D
class_name PlatformAssembly


@export var platform_assembly_type : Enums.EPlatformAssemblyType = Enums.EPlatformAssemblyType.N_N_N_N

const long_platform_length : float = 640.0
const short_platform_length : float = 320.0
const offset_x : float = long_platform_length - short_platform_length

var platform_01 : Platform2D = null
var platform_02 : Platform2D = null
var _map_type : Enums.EMapType
var enable_spawn_enemies : bool = true

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
	regenerate(platform_assembly_type)
	var level : Level = get_tree().get_first_node_in_group("level") as Level
	if level.enable_main_menu_mode:
		$EnterScreenNotifier2D.hide()
		$ExitScreenNotifier2D.hide()
	else:
		$EnterScreenNotifier2D.show()
		$ExitScreenNotifier2D.show()
	

func regenerate(new_platform_assembly_type : Enums.EPlatformAssemblyType) -> void:
	if platform_01 != null:
		platform_01.queue_free()
		platform_01 = null
	if platform_02 != null:
		platform_02.queue_free()
		platform_02 = null
	
	var TypeString : String = Enums.EPlatformAssemblyType.keys()[new_platform_assembly_type]
	var platform_position : Vector4 = platform_position_dict[new_platform_assembly_type]
	
	if TypeString[0] != 'N':
		if TypeString[0] == 'L':
			platform_01 = load(Paths.tscn_long_platform).instantiate()
		else:
			platform_01 = load(Paths.tscn_short_platform).instantiate()
		platform_01.init_platform(_map_type)
		platform_01.position = Vector2(platform_position.x, platform_position.y)
		add_child(platform_01)
		
	if TypeString[2] != 'N':
		if TypeString[2] == 'L':
			platform_02 = load(Paths.tscn_long_platform).instantiate()
		else:
			platform_02 = load(Paths.tscn_short_platform).instantiate()
		platform_02.init_platform(_map_type)
		platform_02.position = Vector2(platform_position.z, platform_position.w)
		add_child(platform_02)
		
		
func init_platform_assembly(map_type : Enums.EMapType) -> void:
	_map_type = map_type
	if platform_01 != null:
		platform_01.init_platform(map_type)
	if platform_02 != null:
		platform_02.init_platform(map_type)
		
		
func spawn_enemies() -> void:
	if platform_01 != null:
		platform_01.spawn_enemies()
	if platform_02 != null:
		platform_02.spawn_enemies()
		
		
func clear_enemies() -> void:
	if platform_01 != null:
		platform_01.clear_enemies()
	if platform_02 != null:
		platform_02.clear_enemies()


func _on_enter_screen_notifier_2d_screen_entered() -> void:
	if enable_spawn_enemies:
		spawn_enemies()
	else:
		enable_spawn_enemies = true


func _on_exit_screen_notifier_2d_screen_exited() -> void:
	clear_enemies()
