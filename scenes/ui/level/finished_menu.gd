extends CanvasLayer
class_name UI_FinishedMenu


@export var click_sound : AudioStream

@onready var rank_label : Label = $Panel/VBoxContainer/Rank

var current_map_type : Enums.EMapType
var score : int


func _ready() -> void:
	GodotTDS.reach_achievement("robot_dash_02")
	if score >= 100:
		GodotTDS.reach_achievement("robot_dash_03")
	
	var main : Main = get_tree().get_first_node_in_group("main")
	if main.music_enabled:
		main.fade_music()
	$Panel/VBoxContainer/Score.text = "得分：" + str(score)
	if GodotTDS.is_logged_in():
		GodotTDS.submit_leaderboard_score("Score", score)
		GodotTDS.on_leaderboard_return.connect(_on_leaderboard_return)
		

func _on_leaderboard_return(code : int, msg : String) -> void:
	if code == GodotTDS.StateCode.LEADERBOARD_SUBMIT_SUCCESS:
		GodotTDS.fetch_leaderboard_user_around_rankings("Score")
	elif code == GodotTDS.StateCode.LEADERBOARD_SUBMIT_FAIL:
		rank_label.text = "更新排名失败"
	elif code == GodotTDS.StateCode.LEADERBOARD_FETCH_USER_RANKING_SUCCESS:
		_show_rank_from_msg(msg)
	elif code == GodotTDS.StateCode.LEADERBOARD_FETCH_USER_RANKING_FAIL:
		rank_label.text = "获取排名失败"


func _show_rank_from_msg(msg : String) -> void:
	var dict : Dictionary = JSON.parse_string(msg)
	if dict.has("list"):
		var arr : Array = dict["list"]
		if arr.size() != 0:
			var rank_obj : Dictionary = arr[0]
			var rank : int = rank_obj["rank"] + 1
			rank_label.text = "排名：{0}".format([rank])
			if rank == 1:
				GodotTDS.reach_achievement("robot_dash_05")



func _on_restart_button_button_down() -> void:
	SoundManager.play_sound(click_sound)
	var main : Main = get_tree().get_first_node_in_group("main")
	main.load_level(current_map_type)
	queue_free()


func _on_main_menu_button_button_down() -> void:
	SoundManager.play_sound(click_sound)
	var main : Main = get_tree().get_first_node_in_group("main")
	main.open_main_menu()
	queue_free()
