@tool
extends Control


signal anim_finished


@export_enum("Blue:0", "Red:1") var color : int = 0:
	set(new_value):
		color = new_value
		if new_value == 0:
			$TextureRect.texture = blue_card_back_tex
		else:
			$TextureRect.texture = red_card_back_tex

var blue_card_back_tex : AtlasTexture = \
	load("res://resources/ui/card/blue_card_back.tres")
	
var red_card_back_tex : AtlasTexture = \
	load("res://resources/ui/card/red_card_back.tres")
	
var blue_card_dict : Dictionary = {
	2 : load("res://resources/ui/card/blue_card_02.tres"),
	3 : load("res://resources/ui/card/blue_card_03.tres"),
	4 : load("res://resources/ui/card/blue_card_04.tres"),
	5 : load("res://resources/ui/card/blue_card_05.tres"),
	6 : load("res://resources/ui/card/blue_card_06.tres"),
	7 : load("res://resources/ui/card/blue_card_07.tres"),
	8 : load("res://resources/ui/card/blue_card_08.tres"),
	9 : load("res://resources/ui/card/blue_card_09.tres"),
	10 : load("res://resources/ui/card/blue_card_10.tres"),
}

var red_card_dict : Dictionary = {
	2 : load("res://resources/ui/card/red_card_02.tres"),
	3 : load("res://resources/ui/card/red_card_03.tres"),
	4 : load("res://resources/ui/card/red_card_04.tres"),
	5 : load("res://resources/ui/card/red_card_05.tres"),
	6 : load("res://resources/ui/card/red_card_06.tres"),
	7 : load("res://resources/ui/card/red_card_07.tres"),
	8 : load("res://resources/ui/card/red_card_08.tres"),
	9 : load("res://resources/ui/card/red_card_09.tres"),
	10 : load("res://resources/ui/card/red_card_10.tres"),
}
	
	
func flip_card(number : int) -> void:
	var tween_01 : Tween = get_tree().create_tween()
	tween_01.tween_property($TextureRect, "scale", Vector2(0, 1), 1.0)
	await tween_01.finished
	var card_tex : AtlasTexture
	if color == 0:
		card_tex = blue_card_dict[number]
	else:
		card_tex = red_card_dict[number]
	$TextureRect.texture = card_tex
	var tween_02 : Tween = get_tree().create_tween()
	tween_02.tween_property($TextureRect, "scale", Vector2(1, 1), 1.0)
	await tween_02.finished
	anim_finished.emit()
