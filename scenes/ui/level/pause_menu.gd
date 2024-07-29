extends CanvasLayer
class_name UI_PauseMenu


signal on_continue


@export var click_sound : AudioStream

@onready var settings_button : Button = $Panel/VBoxContainer/HBoxContainer/SettingsButton
@onready var shop_button : Button = $Panel/VBoxContainer/HBoxContainer/ShopButton
@onready var settings_label : Label = $Panel/VBoxContainer/HBoxContainer/SettingsButton/Label
@onready var shop_label : Label = $Panel/VBoxContainer/HBoxContainer/ShopButton/Label
@onready var tab_container : TabContainer = $Panel/VBoxContainer/TabContainer
@onready var music_button: Button = $Panel/VBoxContainer/TabContainer/Settings/VBoxContainer/MusicButton
@onready var sound_button: Button = $Panel/VBoxContainer/TabContainer/Settings/VBoxContainer/SoundButton

var music_enabled : bool = true
var sound_enabled : bool = true


func _ready() -> void:
	var main : Main = get_tree().get_first_node_in_group("main")
	_update_music_button(main.music_enabled)
	_update_sound_button(main.sound_enabled)
	if main.music_enabled:
		main.fade_music(-24.0, 2.0)
	settings_button.button_pressed = true
	settings_button.disabled = true
	settings_label.add_theme_color_override(
		"font_color", Color.from_string("65676b", Color.BLACK))
	$AnimationPlayer.play("Enter")


func _on_settings_button_button_down() -> void:
	settings_button.disabled = true
	settings_label.add_theme_color_override(
		"font_color", Color.from_string("65676b", Color.BLACK))
	shop_button.button_pressed = false
	shop_button.disabled = false
	shop_label.add_theme_color_override("font_color", Color.WHITE)
	tab_container.current_tab = 0
	SoundManager.play_sound(click_sound)


func _on_shop_button_button_down() -> void:
	shop_button.disabled = true
	shop_label.add_theme_color_override(
		"font_color", Color.from_string("65676b", Color.BLACK))
	settings_button.button_pressed = false
	settings_button.disabled = false
	settings_label.add_theme_color_override("font_color", Color.WHITE)
	tab_container.current_tab = 1
	SoundManager.play_sound(click_sound)


func _on_continue_button_button_down() -> void:
	queue_free()
	get_tree().paused = false
	on_continue.emit()
	SoundManager.play_sound(click_sound)


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


func _on_back_button_button_down() -> void:
	SoundManager.play_sound(click_sound)
	var main : Main = get_tree().get_first_node_in_group("main")
	get_tree().paused = false
	main.open_main_menu()
	
	
func _update_music_button(enabled : bool) -> void:
	if enabled:
		music_button.text = "音乐：开"
	else:
		music_button.text = "音乐：关"
		
		
func _update_sound_button(enabled : bool) -> void:
	if enabled:
		sound_button.text = "声效：开"
	else:
		sound_button.text = "声效：关"
