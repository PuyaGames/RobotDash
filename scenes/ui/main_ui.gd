extends CanvasLayer


@onready var map_theme_bar: VBoxContainer = $PickMapTheme/VBoxContainer/ScrollContainer/VBoxContainer

var settings_showed : bool = false
var starter_showed : bool = true
var ranklist_showed : bool = false
var pick_map_theme_showed : bool = false
var selected_map_type : Enums.EMapType = Enums.EMapType.Halloween_Green


func _ready() -> void:
	var tscn_map_theme_item : PackedScene = load("res://scenes/ui/map_theme_item.tscn")
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
	
	
func _on_ranklist_button_button_down() -> void:
	$AnimPlayerForStarter.play_backwards("starter_enter")
	starter_showed = false
	$AnimationPlayer.play("ranklist_enter")
	ranklist_showed = true


func _on_settings_button_button_down() -> void:
	$AnimPlayerForStarter.play_backwards("starter_enter")
	starter_showed = false
	$AnimationPlayer.play("settings_enter")
	settings_showed = true


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


func _on_start_button_button_down() -> void:
	var tscn_level : PackedScene = load(Paths.tscn_level)
	var level : Level = tscn_level.instantiate()
	level.init_level(selected_map_type, Enums.EPlayerType.Robot)
	var main : Main = get_tree().get_first_node_in_group("main")
	for node in main.get_children():
		node.queue_free()
	main.add_child(level)
