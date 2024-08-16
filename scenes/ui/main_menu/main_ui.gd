extends CanvasLayer


@onready var map_theme_bar: VBoxContainer = $PickMapTheme/VBoxContainer/ScrollContainer/VBoxContainer
@onready var leaderboards : VBoxContainer = $Leaderboards/VBox/List

const hint_text : String = "观看一个30秒不可跳过的广告即可在本次解锁所有主题"

var settings_showed : bool = false
var starter_showed : bool = true
var ranklist_showed : bool = false
var pick_map_theme_showed : bool = false
var selected_map_type : Enums.EMapType = Enums.EMapType.Halloween_Green
var tscn_leaderboard_item : PackedScene = load("res://scenes/ui/main_menu/leaderboards_item.tscn")
var map_theme_list : Array[MapThemeItem]

@export var click_sound : AudioStream


func _ready() -> void:
	_load_reward_video_ad()
	$AnimationPlayer.play("RESET")
	$AnimPlayerForStarter.play("RESET")
	$UnderLayerButton.hide()
	var tscn_map_theme_item : PackedScene = load(Paths.tscn_map_theme_item)
	for map_type : Enums.EMapType in Enums.EMapType.values():
		var map_theme_item : MapThemeItem = tscn_map_theme_item.instantiate()
		map_theme_item.type = map_type
		if map_type == Enums.EMapType.Halloween_Green:
			map_theme_item.locked = false
			map_theme_item.set_selected(true)
		map_theme_item.clicked.connect(_update_selected_map_type)
		map_theme_item.locked_clicked.connect(_on_locked_map_theme_clicked)
		map_theme_bar.add_child(map_theme_item)
		map_theme_list.append(map_theme_item)


func _load_reward_video_ad() -> void:
	var data : GodotTDS.RewardVideoAdData = GodotTDS.RewardVideoAdData.new()
	data.space_id = 1036744
	GodotTDS.load_reward_video_ad(data)
	if not GodotTDS.on_reward_video_ad_return.is_connected(_on_reward_video_ad_return):
		GodotTDS.on_reward_video_ad_return.connect(_on_reward_video_ad_return)


func show_leaderboard(rankings : Array) -> void:
	for node in leaderboards.get_children():
		leaderboards.remove_child(node)
		
	for ranking : Dictionary in rankings:
		var leaderboards_item : LeaderboardsItem = tscn_leaderboard_item.instantiate()
		leaderboards_item.init_data(ranking["rank"] + 1, ranking["nickname"], ranking["statisticValue"])
		leaderboards.add_child(leaderboards_item)
		
	$AnimPlayerForStarter.play_backwards("starter_enter")
	starter_showed = false
	$AnimationPlayer.play("leaderboards_enter")
	ranklist_showed = true
	SoundManager.play_sound(click_sound)
	$UnderLayerButton.show()
	
	
func update_user_rank(user_rank_arr : Array) -> void:
	if user_rank_arr.size() < 1:
		$Leaderboards/VBox/HBox/RankLabel.text = "未上榜"
		$Leaderboards/VBox/HBox/NicknameLabel.text = GodotTDS.get_user_profile()["name"]
		$Leaderboards/VBox/HBox/ScoreLabel.text = "无记录"
		return
		
	var user_rank_obj : Dictionary = user_rank_arr[0]
	$Leaderboards/VBox/HBox/RankLabel.text = "第{0}名".format([user_rank_obj["rank"] + 1])
	$Leaderboards/VBox/HBox/NicknameLabel.text = user_rank_obj["nickname"]
	$Leaderboards/VBox/HBox/ScoreLabel.text = user_rank_obj["statisticValue"]


func _on_leaderboard_return(code : int, msg : String) -> void:
	if code == GodotTDS.StateCode.LEADERBOARD_FETCH_SECTION_RANKINGS_SUCCESS:
		var rankings_obj : Dictionary = JSON.parse_string(msg)
		if rankings_obj.has("list"):
			show_leaderboard(rankings_obj["list"])
		else:
			show_leaderboard([])
	elif code == GodotTDS.StateCode.LEADERBOARD_FETCH_USER_RANKING_SUCCESS:
		var user_rank : Dictionary = JSON.parse_string(msg)
		if user_rank.has("list"):
			update_user_rank(user_rank["list"])
		else:
			update_user_rank([])


func _update_selected_map_type(map_type : Enums.EMapType) -> void:
	for map_theme_item : MapThemeItem in map_theme_bar.get_children():
		map_theme_item.set_selected(false)
		
	selected_map_type = map_type


func _on_locked_map_theme_clicked() -> void:
	var confirm_popup : ConfirmPopup = load("res://scenes/ui/common/confirm_popup.tscn").instantiate()
	confirm_popup.init_text(hint_text)
	confirm_popup.connect("confirm", _watch_reward_video)
	add_child(confirm_popup)
	

func _watch_reward_video() -> void:
	GodotTDS.show_reward_video_ad()
	
	
func _on_reward_video_ad_return(code : int, _msg : String) -> void:
	if code == GodotTDS.StateCode.AD_REWARD_VIDEO_COMPLETED ||\
	   code == GodotTDS.StateCode.AD_REWARD_VIDEO_SKIPPED:
			_unlock_all_map_theme()
			GodotTDS.on_reward_video_ad_return.disconnect(_on_reward_video_ad_return)


func _unlock_all_map_theme() -> void:
	for map_theme : MapThemeItem in map_theme_list:
		map_theme.unlock()


func _on_play_button_button_down() -> void:
	$AnimPlayerForStarter.play_backwards("starter_enter")
	starter_showed = false
	$AnimationPlayer.play("pick_map_theme_enter")
	pick_map_theme_showed = true
	SoundManager.play_sound(click_sound)
	$UnderLayerButton.show()
	if not GodotTDS.on_reward_video_ad_return.is_connected(_on_reward_video_ad_return):
		GodotTDS.on_reward_video_ad_return.connect(_on_reward_video_ad_return)
	
	
func _on_leaderboard_button_button_down() -> void:
	if GodotTDS.is_logged_in():
		GodotTDS.fetch_leaderboard_section_rankings("Score", 0, 10)
		GodotTDS.fetch_leaderboard_user_around_rankings("Score")
	else:
		GodotTDS.show_toast("未登录")


func _on_settings_button_button_down() -> void:
	$AnimPlayerForStarter.play_backwards("starter_enter")
	starter_showed = false
	$AnimationPlayer.play("settings_enter")
	settings_showed = true
	SoundManager.play_sound(click_sound)
	$UnderLayerButton.show()


func _on_under_layer_button_down() -> void:
	if starter_showed == false:
		$AnimPlayerForStarter.play("starter_enter")
		starter_showed = true
	if ranklist_showed:
		$AnimationPlayer.play_backwards("leaderboards_enter")
		ranklist_showed = false
	if settings_showed:
		$AnimationPlayer.play_backwards("settings_enter")
		settings_showed = false
	if pick_map_theme_showed:
		$AnimationPlayer.play_backwards("pick_map_theme_enter")
		pick_map_theme_showed = false
		
	SoundManager.play_sound(click_sound)
	$UnderLayerButton.hide()


func _on_start_button_button_down() -> void:
	$AnimationPlayer.play("RESET")
	$AnimPlayerForStarter.play("RESET")
	settings_showed = false
	starter_showed = true
	ranklist_showed = false
	pick_map_theme_showed = false
	var main : Main = get_tree().get_first_node_in_group("main")
	if main.music_enabled:
		main.fade_music()
	main.load_level(selected_map_type)
	SoundManager.play_sound(click_sound)
	$UnderLayerButton.hide()


func _on_music_button_button_down() -> void:
	SoundManager.play_sound(click_sound)
	var main : Main = get_tree().get_first_node_in_group("main")
	main.music_enabled = not main.music_enabled
	_update_music_button(main.music_enabled)


func _on_sound_button_button_down() -> void:
	SoundManager.play_sound(click_sound)
	var main : Main = get_tree().get_first_node_in_group("main")
	main.sound_enabled = not main.sound_enabled
	_update_sound_button(main.sound_enabled)
		
		
func _update_music_button(enabled : bool) -> void:
	if enabled:
		$Settings/VBoxContainer/MusicButton.text = "音乐：开"
	else:
		$Settings/VBoxContainer/MusicButton.text = "音乐：关"
		
		
func _update_sound_button(enabled : bool) -> void:
	if enabled:
		$Settings/VBoxContainer/SoundButton.text = "声效：开"
	else:
		$Settings/VBoxContainer/SoundButton.text = "声效：关"
		
		
func update_settings_buttons() -> void:
	var main : Main = get_tree().get_first_node_in_group("main")
	_update_music_button(main.music_enabled)
	_update_sound_button(main.sound_enabled)


func _on_achievement_button_button_down() -> void:
	SoundManager.play_sound(click_sound)
	if GodotTDS.is_logged_in():
		GodotTDS.show_achievement_page()
	else:
		GodotTDS.show_toast("未登录")


func _on_tap_moment_button_button_down() -> void:
	SoundManager.play_sound(click_sound)
	GodotTDS.tap_moment()


func _on_tap_login_button_button_down() -> void:
	GodotTDS.login()
