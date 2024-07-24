extends CanvasLayer


@onready var sub_viewport : SubViewport = $SubViewportContainer/SubViewport

var level : Level


func _ready() -> void:
	level = load(Paths.tscn_level).instantiate()
	level.init_level(Enums.EMapType.values().pick_random(), Enums.EPlayerType.None)
	level.enable_main_menu_mode = true
	sub_viewport.add_child(level)


func _process(delta: float) -> void:
	level.move_forward(20.0, delta)
