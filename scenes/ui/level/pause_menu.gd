extends CanvasLayer
class_name UI_PauseMenu


signal on_continue


@onready var settings_button : Button = $Panel/VBoxContainer/HBoxContainer/SettingsButton
@onready var shop_button : Button = $Panel/VBoxContainer/HBoxContainer/ShopButton
@onready var settings_label : Label = $Panel/VBoxContainer/HBoxContainer/SettingsButton/Label
@onready var shop_label : Label = $Panel/VBoxContainer/HBoxContainer/ShopButton/Label
@onready var tab_container : TabContainer = $Panel/VBoxContainer/TabContainer


func _ready() -> void:
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


func _on_shop_button_button_down() -> void:
	shop_button.disabled = true
	shop_label.add_theme_color_override(
		"font_color", Color.from_string("65676b", Color.BLACK))
	settings_button.button_pressed = false
	settings_button.disabled = false
	settings_label.add_theme_color_override("font_color", Color.WHITE)
	tab_container.current_tab = 1


func _on_continue_button_button_down() -> void:
	queue_free()
	get_tree().paused = false
	on_continue.emit()
