extends Node2D
class_name Level

@export var enable_main_menu_mode : bool = false
@export var _map_type : Enums.EMapType = Enums.EMapType.Halloween_Green
@export var _player_type : Enums.EPlayerType = Enums.EPlayerType.DaZhuang
# Sounds
@export var click_sound : AudioStream
@export var jump_sound : AudioStream
@export var double_jump_sound : AudioStream
@export var player_death_sound : AudioStream
@export var player_revive_sound : AudioStream
@export var timer_sound : AudioStream
@export var finished_sound : AudioStream

@onready var player : Player = $Visible/SubViewportContainer/SubViewport/Player
@onready var background : ParallaxScrolling = $Visible/SubViewportContainer/SubViewport/Background
@onready var terrain_generator : TerrainGenerator = $Visible/SubViewportContainer/SubViewport/TerrainGenerator

var time_60s : int = 60:
	set(new_value):
		time_60s = new_value
		$CanvasLayer/TopPanel/Time.text = str(new_value)


func _ready() -> void:
	clear_all_reward_video_ad_signal()
	_init_level_map()
	$CanvasLayer/JumpButton.hide()
	if enable_main_menu_mode:
		$CanvasLayer.hide()
	else:
		$CanvasLayer.show()
		player.init_player(_player_type)
		player.connect("on_dead", _on_player_dead)
		player.connect("on_revive", _on_player_revive)
		$AnimationPlayer.play("Opening")
		GodotTDS.load_banner_ad(1038038)
		GodotTDS.on_banner_ad_return.connect(_on_banner_ad_return)
	
	
func clear_all_reward_video_ad_signal() -> void:
	for dict : Dictionary in GodotTDS.on_reward_video_ad_return.get_connections():
		GodotTDS.disconnect(dict["signal"].get_name(), dict["callable"])
	
	
func _on_banner_ad_return(code : int, msg : String) -> void:
	GodotTDS.show_banner_ad()
	GodotTDS.on_banner_ad_return.disconnect(_on_banner_ad_return)
	

func _process(delta: float) -> void:
	if player.running == false:
		return
	
	if player.player_state == player.EPlayerState.Idle ||\
	   player.player_state == player.EPlayerState.Dead:
		pass
	else:
		move_forward(player.movement_speed, delta)

func _on_jump_button_button_down() -> void:
	if player.is_can_double_jump():
		player.double_jump()
		SoundManager.play_sound(double_jump_sound)
	else:
		player.jump()
		SoundManager.play_sound(jump_sound)
		
		
func _init_level_map() -> void:
	background.init_background(_map_type)
	terrain_generator.init_terrain_generator(_map_type)


var store_button_clicked : bool = false

func _on_pause_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		var pause_menu : UI_PauseMenu = load("res://scenes/ui/level/pause_menu.tscn").instantiate()
		pause_menu.on_continue.connect(_on_game_continue)
		if store_button_clicked:
			pause_menu.store_opened = true
		add_child(pause_menu)
		get_tree().paused = true
		SoundManager.play_sound(click_sound)
	
	
func _on_game_continue() -> void:
	$CanvasLayer/TopPanel/PauseButton.button_pressed = false
	store_button_clicked = false
	var main : Main = get_tree().get_first_node_in_group("main")
	if main.music_enabled:
		main.loud_music()
	
	
func move_forward(speed : float, delta : float) -> void:
	background.move_forward(speed, delta)
	terrain_generator.move_forward(speed, delta)
	
	
func init_level(map_type : Enums.EMapType, player_type : Enums.EPlayerType) -> void:
	_map_type = map_type
	_player_type = player_type


func _on_hint_button_button_down() -> void:
	var main : Main = get_tree().get_first_node_in_group("main")
	if main.music_enabled:
		main.loud_music()
	player.running = true
	player.set_run_state()
	$Hint.hide()
	$Timer.start()
	$CanvasLayer/JumpButton.show()
	SoundManager.play_sound(click_sound)
	
	
func _on_player_dead() -> void:
	var main : Main = get_tree().get_first_node_in_group("main")
	if main.music_enabled:
		main.fade_music()
	$Timer.stop()
	var tscn_defeat_menu : PackedScene = load("res://scenes/ui/level/defeat_menu.tscn")
	var defeat_menu : CanvasLayer = tscn_defeat_menu.instantiate()
	defeat_menu.init_defeat_menu(self)
	add_child(defeat_menu)
	SoundManager.play_sound(player_death_sound)
	
	
func _on_player_revive() -> void:
	$Hint.show()
	SoundManager.play_sound(player_revive_sound)
	
	
func _on_timer_timeout() -> void:
	if time_60s > 0:
		time_60s -= 1
		if time_60s < 10:
			$CanvasLayer/TopPanel/Time.modulate = Color.RED
			SoundManager.play_sound(timer_sound)
	else:
		$Timer.stop()
		var tscn_finished_menu : PackedScene = load("res://scenes/ui/level/finished_menu.tscn")
		var ui_finished_menu : UI_FinishedMenu = tscn_finished_menu.instantiate()
		ui_finished_menu.score = player.get_hp()
		ui_finished_menu.current_map_type = _map_type
		add_child(ui_finished_menu)
		player.stop_running()
		SoundManager.play_sound(finished_sound)


func _on_store_button_button_down() -> void:
	store_button_clicked = true
	$CanvasLayer/TopPanel/PauseButton.button_pressed = true
	SoundManager.play_sound(click_sound)
