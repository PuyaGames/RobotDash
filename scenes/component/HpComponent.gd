extends Node2D
class_name HpComponent


@export var hp_type : Enums.EHpType = Enums.EHpType.Blue
@export var hp : int = 100

const red : Color = Color8(255, 28, 0)
const blue : Color = Color8(20, 50, 255)

var new_value : int


func _ready() -> void:
	if hp_type == Enums.EHpType.Blue:
		$Label.add_theme_color_override("font_color", blue)
	else:
		$Label.add_theme_color_override("font_color", red)


func add_hp(hp_comp : HpComponent) -> void:
	
	$AnimationPlayer.play("Updated")
	
	
func reduce_hp(value : int) -> void:
	
	$AnimationPlayer.play("Updated")
	
	
func update_label() -> void:
	$Label.text = str(new_value)
