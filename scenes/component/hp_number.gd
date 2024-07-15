extends Node2D
class_name HpNumber


@export var hp_type : Enums.EHpType = Enums.EHpType.Blue

var hp : int = 100:
	set(new_value):
		hp = new_value
		$Label.text = str(new_value)

const red : Color = Color8(255, 28, 0)
const blue : Color = Color8(20, 50, 255)

var new_hp_value : int


func _ready() -> void:
	if hp_type == Enums.EHpType.Blue:
		$Label.add_theme_color_override("font_color", blue)
	else:
		$Label.add_theme_color_override("font_color", red)


func add_hp(target_hp_number : HpNumber) -> void:
	new_hp_value = hp + target_hp_number.hp
	var new_hp_comp : HpNumber = target_hp_number.duplicate()
	target_hp_number.hide()
	new_hp_comp.position = target_hp_number.global_position
	var level : Level = get_tree().get_first_node_in_group("level")
	level.add_child(new_hp_comp)
	var tween : Tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(new_hp_comp, "position", global_position, 0.12)
	#tween.tween_property(new_hp_comp, "scale", Vector2(0.8, 0.8), 0.12)
	tween.finished.connect(Callable(
		func() -> void:
			$AnimationPlayer.play("Updated")
			new_hp_comp.queue_free()
	))
	
	
func reduce_hp(_value : int) -> void:
	$AnimationPlayer.play("Updated")
	
	
func update_label() -> void:
	hp = new_hp_value
