extends Node
class_name Main


@export var enemies_spawn_config : EnemySpawnConfig

var enemy_type_pool : Array[Enums.EEnemyType]
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
	GodotTDS.load_interstitial_ad(1038040)
	GodotTDS.on_interstitial_ad_return.connect(_on_interstitial_ad_return)
	GodotTDS.on_reward_video_ad_return.connect(_on_update_reward_video_ad_count)
	ResourceLoader.load_threaded_request(Paths.tscn_main_menu)
	SoundManager.set_default_music_bus("Music")
	SoundManager.set_default_ui_sound_bus("UI")
	SoundManager.set_default_sound_bus("Sounds")
	$Loading.show_and_queue(true)
	
	for enemy_type in enemies_spawn_config.enemy_type_list:
		var key : String = Enums.EEnemyType.keys()[enemy_type]
		var value : float = enemies_spawn_config.enemy_occurrence_rate_dict[key]
		for i in range(value * 100):
			enemy_type_pool.append(enemy_type)
	enemy_type_pool.shuffle()


func _on_update_reward_video_ad_count(code : int, _msg : String) -> void:
	if code == GodotTDS.StateCode.AD_REWARD_VIDEO_SHOWN:
		GodotTDS.reach_achievement("robot_dash_06")


func _on_interstitial_ad_return(code : int, _msg : String) -> void:
	if code == GodotTDS.StateCode.AD_INTERSTITIAL_CLOSED:
		$OvaniPlayer.PlaySongNow(background_music, 4.0)
	elif code == GodotTDS.StateCode.AD_INTERSTITIAL_LOAD_FAIL:
		$OvaniPlayer.PlaySongNow(background_music, 4.0)
	elif code == GodotTDS.StateCode.AD_INTERSTITIAL_ERROR:
		$OvaniPlayer.PlaySongNow(background_music, 4.0)
		

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
	GodotTDS.dispose_banner_ad()
	
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		pass
		
	
func fade_music() -> void:
	$OvaniPlayer.FadeVolume(-8.0, 1.0)
	
	
func loud_music() -> void:
	$OvaniPlayer.FadeVolume(0.0, 1.0)
	
	
func mute_music() -> void:
	$OvaniPlayer.FadeVolume(-80.0, 1.0)


func _on_loading_loading_finished() -> void:
	GodotTDS.show_interstitial_ad()
	
	
func add_enemy_to_pool(enemy_type : Enums.EEnemyType, number : int) -> void:
	for i in range(number):
		enemy_type_pool.append(enemy_type)
