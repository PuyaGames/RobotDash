extends CanvasLayer
class_name UI_ChestMenu


@export var click_sound : AudioStream

@onready var store_item_2: StoreItem = $Panel/VBoxContainer/StoreItem2

var main : Main
var level : Level
var player : Player
var item_type_tool : Array[Enums.EItemType] = []
var random_item_type : Enums.EItemType = Enums.EItemType.None


func _ready() -> void:
	main = get_tree().get_first_node_in_group("main")
	level = main.active_level
	player = level.player
	
	if level.speed_up_count > 0:
		item_type_tool.append(Enums.EItemType.SpeedUp)
	if level.better_count > 0:
		item_type_tool.append(Enums.EItemType.Better)
	if level.luck_count > 0:
		item_type_tool.append(Enums.EItemType.Luck)
	if level.overtime_count > 0:
		item_type_tool.append(Enums.EItemType.Overtime)
	if level.one_attack_count > 0:
		item_type_tool.append(Enums.EItemType.OneAttack)
	if level.restreat_count > 0:
		item_type_tool.append(Enums.EItemType.Retreat)
	
	get_tree().paused = true
	
	random_item_type = item_type_tool.pick_random()
	store_item_2.type = random_item_type
	var data : GodotTDS.RewardVideoAdData = GodotTDS.RewardVideoAdData.new()
	data.space_id = 1037810
	GodotTDS.load_reward_video_ad(data)
	GodotTDS.on_reward_video_ad_return.connect(_on_reward_video_ad_return)
	
	
func _exit_tree() -> void:
	get_tree().paused = false
	GodotTDS.on_reward_video_ad_return.disconnect(_on_reward_video_ad_return)
	
	
func _on_reward_video_ad_return(code : int, _msg : String) -> void:
	if code == GodotTDS.StateCode.AD_REWARD_VIDEO_COMPLETED ||\
	   code == GodotTDS.StateCode.AD_REWARD_VIDEO_SKIPPED:
		player.set_run_state()
		player.can_double_jump = true
		player.apply_item_effect(store_item_2)
		queue_free()
	elif code == GodotTDS.StateCode.AD_REWARD_VIDEO_LOAD_FAIL:
		player.set_run_state()


func _on_confirm_button_button_down() -> void:
	SoundManager.play_sound(click_sound)
	GodotTDS.show_reward_video_ad()


func _on_cancel_button_button_down() -> void:
	SoundManager.play_sound(click_sound)
	player.set_run_state()
	queue_free()
