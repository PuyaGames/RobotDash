@tool
extends Button


@export var label : String = "主题名称"
@export var type : Enums.EMapType = Enums.EMapType.Halloween_Green

class MapThemeData:
	var label : String
	var tex_path : String
	
	func _init(in_label : String, in_tex_path : String) -> void:
		label = in_label
		tex_path = in_tex_path

var tex_dict : Dictionary = {
	Enums.EMapType.Halloween_Blue :
		MapThemeData.new("万圣节（一）", "res://resources/ui/map_theme/halloween_01.atlastex")
}


func _ready() -> void:
	pass # Replace with function body.

