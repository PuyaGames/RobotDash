extends CanvasLayer


@export var click_sound : AudioStream

const hint_text : String = "观看一个30秒的不可跳过的广告即可复活"

var level : Level
var main : Main
var player_confirm_revive : bool = false
var reward_video_ad_ready : bool = false


func init_defeat_menu(in_level : Level) -> void:
	level = in_level


func _ready() -> void:
	main = get_tree().get_first_node_in_group("main")
	var data : GodotTDS.RewardVideoAdData = GodotTDS.RewardVideoAdData.new()
	data.space_id = 1037811
	GodotTDS.load_reward_video_ad(data)
	GodotTDS.on_reward_video_ad_return.connect(_confirm_revive)
	$AnimationPlayer.play("Enter")
	


func _on_revive_button_button_down() -> void:
	var confirm_popup : ConfirmPopup = load("res://scenes/ui/common/confirm_popup.tscn").instantiate()
	confirm_popup.init_text(hint_text)
	confirm_popup.connect("confirm", _confirm_revive)
	$Popup.add_child(confirm_popup)
	
	
func _confirm_revive() -> void:
	player_confirm_revive = true
	if reward_video_ad_ready:
		GodotTDS.show_reward_video_ad()
	
	
func _on_reward_video_ad_return(code : int, msg : String) -> void:
	if code == GodotTDS.StateCode.AD_REWARD_VIDEO_CACHE_SUCCESS:
		reward_video_ad_ready = true
		if player_confirm_revive:
			GodotTDS.show_reward_video_ad()
	elif code == GodotTDS.StateCode.AD_REWARD_VIDEO_COMPLETED:
		queue_free()
		level.player.revive()
	elif code == GodotTDS.StateCode.AD_REWARD_VIDEO_CLOSED:
		player_confirm_revive = false
		reward_video_ad_ready = false
		main.close_confirm_popup()
		


func _on_main_menu_button_button_down() -> void:
	SoundManager.play_sound(click_sound)
	var main : Main = get_tree().get_first_node_in_group("main")
	main.open_main_menu()
