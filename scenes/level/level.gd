extends Node2D
class_name Level

@export var enable_main_menu_mode : bool = false
@export var _map_type : Enums.EMapType = Enums.EMapType.Halloween_Green
@export var _player_type : Enums.EPlayerType = Enums.EPlayerType.DaZhuang
@export var click_sound : AudioStream
@export var jump_sound : AudioStream
@export var double_jump_sound : AudioStream
@export var player_death_sound : AudioStream
@export var player_revive_sound : AudioStream

@onready var player : Player = $Visible/SubViewportContainer/SubViewport/Player
@onready var background : ParallaxScrolling = $Visible/SubViewportContainer/SubViewport/Background
@onready var terrain_generator : TerrainGenerator = $Visible/SubViewportContainer/SubViewport/TerrainGenerator

var timer_60s : int = 60:
	set(new_value):
		timer_60s = new_value
		$CanvasLayer/TopPanel/Timer.text = str(new_value)


func _ready() -> void:
	$CanvasLayer/JumpButton.hide()
	if enable_main_menu_mode:
		$CanvasLayer.hide()
	else:
		$CanvasLayer.show()
		player.init_player(_player_type)
		player.connect("on_dead", _on_player_dead)
		player.connect("on_revive", _on_player_revive)
		$AnimationPlayer.play("Opening")
		
	_init_level_map()

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


func _on_pause_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		var pause_menu : UI_PauseMenu = load("res://scenes/ui/level/pause_menu.tscn").instantiate()
		pause_menu.on_continue.connect(_on_game_continue)
		add_child(pause_menu)
		get_tree().paused = true
		SoundManager.play_sound(click_sound)
	
	
func _on_game_continue() -> void:
	$CanvasLayer/TopPanel/PauseButton.button_pressed = false
	var main : Main = get_tree().get_first_node_in_group("main")
	if main.music_enabled:
		main.fade_music(-12.0, 2.0)
	
	
func move_forward(speed : float, delta : float) -> void:
	background.move_forward(speed, delta)
	terrain_generator.move_forward(speed, delta)
	
	
func init_level(map_type : Enums.EMapType, player_type : Enums.EPlayerType) -> void:
	_map_type = map_type
	_player_type = player_type


func _on_hint_button_button_down() -> void:
	var main : Main = get_tree().get_first_node_in_group("main")
	if main.music_enabled:
		main.fade_music(-12.0, 2.0)
	player.running = true
	player.set_run_state()
	$Hint.hide()
	$Timer.start()
	$CanvasLayer/JumpButton.show()
	SoundManager.play_sound(click_sound)
	
	
func _on_player_dead() -> void:
	var main : Main = get_tree().get_first_node_in_group("main")
	if main.music_enabled:
		main.fade_music(-24.0, 2.0)
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
	if timer_60s > 0:
		timer_60s -= 1
	else:
		pass
