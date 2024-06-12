extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_init_button_button_down() -> void:
	GodotTapTap.initAd(Config.media_id, Config.media_name, Config.media_key)


func _on_load_button_button_down() -> void:
	if GodotTapTap.isLogin():
		var user_info_str : String = GodotTapTap.getCurrentProfile()
		print_debug(user_info_str)
		GodotTapTap.initRewardVideoAd(Config.media_id, "测试", "", OS.get_unique_id())
	else:
		GodotTapTap.initRewardVideoAd(Config.media_id, "测试", "", OS.get_unique_id())

func _on_show_button_button_down() -> void:
	GodotTapTap.showRewardVideoAd()


func _on_login_button_button_down() -> void:
	GodotTapTap.tap_login()


func _on_check_button_button_down() -> void:
	GodotTapTap.momentOpen()


func _on_moment_button_button_down() -> void:
	GodotTapTap.momentOpen()
