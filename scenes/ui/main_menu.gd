extends CanvasLayer


@onready var sub_viewport : SubViewport = $SubViewportContainer/SubViewport

const map_type_pool : Array[Enums.EMapType] = [
	Enums.EMapType.Halloween_Green,
	Enums.EMapType.Halloween_Red,
	Enums.EMapType.Halloween_Blue,
	Enums.EMapType.Halloween_Orange,
	Enums.EMapType.Desert_Cactus,
	Enums.EMapType.Desert_Rock,
	Enums.EMapType.Desert_Sky,
	Enums.EMapType.Desert_Dusk
]

var level : Level


func _ready() -> void:
	level = Preload.tscn_level.instantiate()
	level.init_level(map_type_pool.pick_random(), Enums.EPlayerType.None)
	level.enable_main_menu_mode = true
	sub_viewport.add_child(level)


func _process(delta: float) -> void:
	level.move_forward(20.0, delta)


func _on_play_button_button_down() -> void:
	get_tree().change_scene_to_packed(Preload.tscn_level)
