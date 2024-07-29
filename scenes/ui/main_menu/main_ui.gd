extends CanvasLayer


@onready var map_theme_bar: VBoxContainer = $PickMapTheme/VBoxContainer/ScrollContainer/VBoxContainer

var settings_showed : bool = false
var starter_showed : bool = true
var ranklist_showed : bool = false
var pick_map_theme_showed : bool = false
var selected_map_type : Enums.EMapType = Enums.EMapType.Halloween_Green

@export var click_sound : AudioStream


func _ready() -> void:
	$AnimationPlayer.play("RESET")
	$AnimPlayerForStarter.play("RESET")
	$UnderLayerButton.disabled = true
	var tscn_map_theme_item : PackedScene = load(Paths.tscn_map_theme_item)
	for map_type : Enums.EMapType in Enums.EMapType.values():
		var map_theme_item : MapThemeItem = tscn_map_theme_item.instantiate()
		map_theme_item.type = map_type
		if map_type == Enums.EMapType.Halloween_Green:
			map_theme_item.locked = false
			map_theme_item.set_selected(true)
		map_theme_item.clicked.connect(update_selected_map_type)
		map_theme_bar.add_child(map_theme_item)


func update_selected_map_type(map_type : Enums.EMapType) -> void:
	for map_theme_item : MapThemeItem in map_theme_bar.get_children():
		map_theme_item.set_selected(false)
		
	selected_map_type = map_type



func _on_play_button_button_down() -> void:
	$AnimPlayerForStarter.play_backwards("starter_enter")
	starter_showed = false
	$AnimationPlayer.play("pick_map_theme_enter")
	pick_map_theme_showed = true
	SoundManager.play_sound(click_sound)
	$UnderLayerButton.disabled = false
	
	
func _on_ranklist_button_button_down() -> void:
	$AnimPlayerForStarter.play_backwards("starter_enter")
	starter_showed = false
	$AnimationPlayer.play("ranklist_enter")
	ranklist_showed = true
	SoundManager.play_sound(click_sound)
	$UnderLayerButton.disabled = false


func _on_settings_button_button_down() -> void:
	$AnimPlayerForStarter.play_backwards("starter_enter")
	starter_showed = false
	$AnimationPlayer.play("settings_enter")
	settings_showed = true
	SoundManager.play_sound(click_sound)
	$UnderLayerButton.disabled = false


func _on_under_layer_button_down() -> void:
	if starter_showed == false:
		$AnimPlayerForStarter.play("starter_enter")
		starter_showed = true
	if ranklist_showed:
		$AnimationPlayer.play_backwards("ranklist_enter")
		ranklist_showed = false
	if settings_showed:
		$AnimationPlayer.play_backwards("settings_enter")
		settings_showed = false
	if pick_map_theme_showed:
		$AnimationPlayer.play_backwards("pick_map_theme_enter")
		pick_map_theme_showed = false
		
	SoundManager.play_sound(click_sound)
	$UnderLayerButton.disabled = true


func _on_start_button_button_down() -> void:
	$AnimationPlayer.play("RESET")
	$AnimPlayerForStarter.play("RESET")
	settings_showed = false
	starter_showed = true
	ranklist_showed = false
	pick_map_theme_showed = false
	var main : Main = get_tree().get_first_node_in_group("main")
	if main.music_enabled:
		main.fade_music(-24.0, 2.0)
	main.load_level(selected_map_type)
	SoundManager.play_sound(click_sound)
	$UnderLayerButton.disabled = true


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
