extends Node
class_name Main


var active_level : Level
var main_menu : MainMenu
var background_music : OvaniSong = load("res://resources/music/background.tres")


func _ready() -> void:
	ResourceLoader.load_threaded_request(Paths.tscn_main_menu)


func _process(_delta: float) -> void:
	var progress : Array = []
	ResourceLoader.load_threaded_get_status(Paths.tscn_main_menu, progress)
	if progress[0] == 1.0:
		var tscn_main_menu : PackedScene = ResourceLoader.load_threaded_get(Paths.tscn_main_menu)
		main_menu = tscn_main_menu.instantiate()
		$UI.add_child(main_menu)


func load_level(map_type : Enums.EMapType) -> void:
	main_menu.hide_all()
	var tscn_level : PackedScene = load(Paths.tscn_level)
	active_level = tscn_level.instantiate()
	active_level.init_level(map_type, Enums.EPlayerType.Robot)
	$Level.add_child(active_level)
	
	
func open_main_menu() -> void:
	active_level.queue_free()
	main_menu.show_all()
	
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		pass
		
		
func play_music() -> void:
	$OvaniPlayer.PlaySongNow()


func _on_loading_loading_finished() -> void:
	$OvaniPlayer.PlaySongNow(background_music)
