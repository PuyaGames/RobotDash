extends CanvasLayer
class_name MainMenu


@onready var sub_viewport : SubViewport = $SubViewportContainer/SubViewport

var level : Level
# Useful for ResourceLoader in Main
var background_music : OvaniSong = load("res://resources/music/background.tres")


func _ready() -> void:
	level = load(Paths.tscn_level).instantiate()
	level.init_level(Enums.EMapType.values().pick_random(), Enums.EPlayerType.None)
	level.enable_main_menu_mode = true
	var main : Main = get_tree().get_first_node_in_group("main") as Main
	main.active_level = level
	sub_viewport.add_child(level)


func _process(delta: float) -> void:
	level.move_forward(20.0, delta)
	
	
func hide_all() -> void:
	hide()
	$MainUI.hide()
	
	
func show_all() -> void:
	show()
	$MainUI.show()
	$MainUI.update_settings_buttons()
	var main : Main = get_tree().get_first_node_in_group("main") as Main
	if main.music_enabled:
		main.loud_music()
