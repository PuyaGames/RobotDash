extends CanvasLayer
class_name UI_ChestMenu


const item_type_tool : Array[Enums.EItemType] = [
	Enums.EItemType.SpeedUp,
	Enums.EItemType.Better,
	Enums.EItemType.Luck,
	Enums.EItemType.Overtime,
	Enums.EItemType.OneAttack,
	Enums.EItemType.Retreat
]

var level : Level
var player : Player
var random_item_type : Enums.EItemType = Enums.EItemType.None


func _ready() -> void:
	level = get_tree().get_first_node_in_group("main").active_level
	player = level.player
	random_item_type = item_type_tool.pick_random()
	$Panel/VBoxContainer/StoreItem2.type = random_item_type
	var data : GodotTDS.RewardVideoAdData = GodotTDS.RewardVideoAdData.new()
	data.space_id = 1037810
	GodotTDS.load_reward_video_ad(data)
	GodotTDS.on_reward_video_ad_return.connect(_on_reward_video_ad_return)
	
	
func _exit_tree() -> void:
	GodotTDS.on_reward_video_ad_return.disconnect(_on_reward_video_ad_return)
	
	
func _on_reward_video_ad_return(code : int, msg : String) -> void:
	if code == GodotTDS.StateCode.AD_REWARD_VIDEO_COMPLETED ||\
	GodotTDS.StateCode.AD_REWARD_VIDEO_SKIPPED:
		player.set_run_state()
		player.can_double_jump = true
		level.double_jump_count -= 1
		if random_item_type == Enums.EItemType.SpeedUp:
			level.speed_up_count -= 1
			player.movement_speed += 20.0
		elif random_item_type == Enums.EItemType.Better:
			level.better_count -= 1
			player.better = true
		elif random_item_type == Enums.EItemType.Huge:
			level.huge_count -= 1
			player.become_huge()
		elif random_item_type == Enums.EItemType.Luck:
			level.luck_count -= 1
		elif random_item_type == Enums.EItemType.Overtime:
			level.overtime_count -= 1
			level.time_60s += 2
		elif random_item_type == Enums.EItemType.OneAttack:
			level.one_attack_count -= 1
		elif random_item_type == Enums.EItemType.Retreat:
			level.restreat_count -= 1
	elif code == GodotTDS.StateCode.AD_REWARD_VIDEO_LOAD_FAIL:
		player.set_run_state()
		
	queue_free()


func _on_confirm_button_button_down() -> void:
	GodotTDS.show_reward_video_ad()


func _on_cancel_button_button_down() -> void:
	player.set_run_state()
	queue_free()
