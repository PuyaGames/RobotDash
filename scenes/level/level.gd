extends Node2D
class_name Level

@export var enable_main_menu_mode : bool = false
@export var _map_type : Enums.EMapType = Enums.EMapType.Halloween_Green
@export var _player_type : Enums.EPlayerType = Enums.EPlayerType.DaZhuang

@onready var player : Player = $Visible/SubViewportContainer/SubViewport/Player
@onready var background : ParallaxScrolling = $Visible/SubViewportContainer/SubViewport/Background
@onready var terrain_generator : TerrainGenerator = $Visible/SubViewportContainer/SubViewport/TerrainGenerator

var timer_60s : int = 60:
	set(new_value):
		timer_60s = new_value
		$CanvasLayer/TopPanel/Timer.text = str(new_value)


func _ready() -> void:
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
	else:
		player.jump()
		
		
func _init_level_map() -> void:
	background.init_background(_map_type)
	terrain_generator.init_terrain_generator(_map_type)


func _on_pause_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		var pause_menu : UI_PauseMenu = load("res://scenes/ui/level/pause_menu.tscn").instantiate()
		pause_menu.on_continue.connect(_update_pause_button)
		add_child(pause_menu)
		get_tree().paused = true
	
	
func _update_pause_button() -> void:
	$CanvasLayer/TopPanel/PauseButton.button_pressed = false
	
	
func move_forward(speed : float, delta : float) -> void:
	background.move_forward(speed, delta)
	terrain_generator.move_forward(speed, delta)
	
	
func init_level(map_type : Enums.EMapType, player_type : Enums.EPlayerType) -> void:
	_map_type = map_type
	_player_type = player_type


func _on_hint_button_button_down() -> void:
	player.running = true
	player.set_run_state()
	$Hint.hide()
	$Timer.start()
	
	
func _on_player_dead() -> void:
	$Timer.stop()
	var tscn_defeat_menu : PackedScene = load("res://scenes/ui/level/defeat_menu.tscn")
	var defeat_menu : CanvasLayer = tscn_defeat_menu.instantiate()
	defeat_menu.init_defeat_menu(self)
	add_child(defeat_menu)
	
	
func _on_player_revive() -> void:
	$Hint.show()
	
	
func _on_timer_timeout() -> void:
	if timer_60s > 0:
		timer_60s -= 1
	else:
		pass
