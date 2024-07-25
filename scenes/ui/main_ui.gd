extends CanvasLayer


@onready var map_theme_bar: VBoxContainer = $PickMapTheme/VBoxContainer/ScrollContainer/VBoxContainer

var settings_showed : bool = false
var starter_showed : bool = true
var ranklist_showed : bool = false
var pick_map_theme_showed : bool = false


func _ready() -> void:
	var tscn_map_theme_item : PackedScene = load("res://scenes/ui/map_theme_item.tscn")
	for map_type : Enums.EMapType in Enums.EMapType.values():
		var map_theme_item : MapThemeItem = tscn_map_theme_item.instantiate()
		map_theme_item.type = map_type
		map_theme_bar.add_child(map_theme_item)


