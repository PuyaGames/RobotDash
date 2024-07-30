extends Node
class_name Main


var active_level : Level
var main_menu : MainMenu
var background_music : OvaniSong

var music_enabled : bool = true:
	set(new_value):
		music_enabled = new_value
		if music_enabled:
			loud_music()
		else:
			mute_music()

var sound_enabled : bool = true:
	set(new_value):
		sound_enabled = new_value
		if sound_enabled:
			AudioServer.set_bus_mute(1, false)
		else:
			AudioServer.set_bus_mute(1, true)


func _ready() -> void:
	ResourceLoader.load_threaded_request(Paths.tscn_main_menu)
	SoundManager.set_default_music_bus("Music")
	SoundManager.set_default_ui_sound_bus("UI")
	SoundManager.set_default_sound_bus("Sounds")


func _process(_delta: float) -> void:
	var progress : Array = []
	ResourceLoader.load_threaded_get_status(Paths.tscn_main_menu, progress)
	if progress[0] == 1.0:
		var tscn_main_menu : PackedScene = ResourceLoader.load_threaded_get(Paths.tscn_main_menu)
		main_menu = tscn_main_menu.instantiate()
		background_music = main_menu.background_music
		$UI.add_child(main_menu)


func load_level(map_type : Enums.EMapType) -> void:
	main_menu.hide_all()
	var tscn_level : PackedScene = load(Paths.tscn_level)
	active_level = tscn_level.instantiate()
	active_level.init_level(map_type, Enums.EPlayerType.Robot)
	for node in $Level.get_children():
		node.queue_free()
	$Level.add_child(active_level)
	
	
func open_main_menu() -> void:
	if active_level != null:
		active_level.queue_free()
	main_menu.show_all()
	
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		pass
		
	
func fade_music() -> void:
	$OvaniPlayer.FadeVolume(-16.0, 1.0)
	
	
func loud_music() -> void:
	$OvaniPlayer.FadeVolume(-8.0, 1.0)
	
	
func mute_music() -> void:
	$OvaniPlayer.FadeVolume(-80.0, 1.0)


func _on_loading_loading_finished() -> void:
	$OvaniPlayer.PlaySongNow(background_music, 4.0)
