extends Node2D


@export var hp_type : Enums.EHpType = Enums.EHpType.Blue
@export var hp : int = 100

const red : Color = Color8(255, 28, 0)
const blue : Color = Color8(20, 50, 255)


func _ready() -> void:
	if hp_type == Enums.EHpType.Blue:
		$Label.add_theme_color_override("font_color", blue)
	else:
		$Label.add_theme_color_override("font_color", red)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
