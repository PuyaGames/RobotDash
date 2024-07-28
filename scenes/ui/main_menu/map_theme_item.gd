@tool
extends Button
class_name MapThemeItem


signal clicked(map_type : Enums.EMapType)


@export var type : Enums.EMapType = Enums.EMapType.Halloween_Green:
	set(new_value):
		type = new_value
		var map_theme_data : MapThemeData = theme_data_dict[type]
		$TextureRect.texture = load(map_theme_data.tex_path)
		$Label.text = map_theme_data.label
		
var locked : bool = true

class MapThemeData:
	var label : String
	var tex_path : String
	
	func _init(in_label : String, in_tex_path : String) -> void:
		label = in_label
		tex_path = in_tex_path

var theme_data_dict : Dictionary = {
	Enums.EMapType.Halloween_Green :
		MapThemeData.new("古堡", "res://resources/ui/map_theme/halloween_01.atlastex"),
	Enums.EMapType.Halloween_Red :
		MapThemeData.new("血色滋生", "res://resources/ui/map_theme/halloween_02.atlastex"),
	Enums.EMapType.Halloween_Blue :
		MapThemeData.new("墓地", "res://resources/ui/map_theme/halloween_03.atlastex"),
	Enums.EMapType.Halloween_Orange :
		MapThemeData.new("万圣节", "res://resources/ui/map_theme/halloween_04.atlastex"),
	Enums.EMapType.Desert_Cactus :
		MapThemeData.new("仙人掌", "res://resources/ui/map_theme/desert_02.atlastex"),
	Enums.EMapType.Desert_Rock :
		MapThemeData.new("怪石嶙峋", "res://resources/ui/map_theme/desert_03.atlastex"),
	Enums.EMapType.Desert_Sky :
		MapThemeData.new("常规沙漠", "res://resources/ui/map_theme/desert_04.atlastex"),
	Enums.EMapType.Desert_Dusk :
		MapThemeData.new("风化", "res://resources/ui/map_theme/desert_01.atlastex"),
	Enums.EMapType.Sweet_Pink :
		MapThemeData.new("超级大蛋糕", "res://resources/ui/map_theme/sweet_01.atlastex"),
	Enums.EMapType.Sweet_Blue :
		MapThemeData.new("云朵", "res://resources/ui/map_theme/sweet_02.atlastex"),
	Enums.EMapType.Sweet_Green :
		MapThemeData.new("童话中的森林", "res://resources/ui/map_theme/sweet_03.atlastex"),
	Enums.EMapType.Sweet_Cyan :
		MapThemeData.new("魔法的城堡", "res://resources/ui/map_theme/sweet_04.atlastex"),
	Enums.EMapType.Beach_Blue :
		MapThemeData.new("高饱和海滩", "res://resources/ui/map_theme/beach_01.atlastex"),
	Enums.EMapType.Beach_Green :
		MapThemeData.new("椰子树", "res://resources/ui/map_theme/beach_02.atlastex"),
	Enums.EMapType.Beach_Cyan :
		MapThemeData.new("青", "res://resources/ui/map_theme/beach_03.atlastex"),
	Enums.EMapType.Beach_Dusk :
		MapThemeData.new("黄昏与海", "res://resources/ui/map_theme/beach_04.atlastex")
}


func set_selected(selected : bool) -> void:
	if selected:
		$Selected.show()
	else:
		$Selected.hide()
		
		
func _ready() -> void:
	if locked:
		disabled = true
		$Locked.show()
		$TextureRect.modulate = Color.from_string("ffffff34", Color.WHITE)
		$Button.show()
	else:
		disabled = false
		$Locked.hide()
		$TextureRect.modulate = Color.WHITE
		$Button.hide()


func _on_button_button_down() -> void:
	print_debug("Unlocked")


func _on_button_down() -> void:
	clicked.emit(type)
	set_selected(true)
	
