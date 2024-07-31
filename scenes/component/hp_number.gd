extends Node2D
class_name HpNumber


signal hp_updated(new_hp : int)


@export var hp_type : Enums.EHpType = Enums.EHpType.Blue

var hp : int = 100:
	set(new_value):
		if owner is Player and new_value <= 0:
			new_value = 0
		hp = new_value
		$Label.text = str(new_value)
		
		if owner is Player:
			return
		if new_value != 0:
			return
		var enemy : Enemy = owner as Enemy
		if enemy.enemy_type == Enums.EEnemyType.Green:
			$Label.text = "x10"
		elif enemy.enemy_type == Enums.EEnemyType.BlackOne:
			$Label.text = "÷2"

const red : Color = Color8(255, 28, 0)
const blue : Color = Color8(20, 50, 255)

var level : Level
var new_hp_value : int


func _ready() -> void:
	var main : Main = get_tree().get_first_node_in_group("main") as Main
	level = main.active_level
	
	if hp_type == Enums.EHpType.Blue:
		$Label.add_theme_color_override("font_color", blue)
	else:
		$Label.add_theme_color_override("font_color", red)


func add_hp(enemy : Enemy) -> void:
	if enemy.enemy_type == Enums.EEnemyType.Green:
		new_hp_value = hp * 10
	elif enemy.enemy_type == Enums.EEnemyType.BlackOne:
		new_hp_value = int(hp * 0.5)
	else:
		new_hp_value = hp + enemy.get_hp()
		
	var new_hp_comp : HpNumber = enemy.hp_number.duplicate()
	enemy.hp_number.hide()
	new_hp_comp.position = enemy.hp_number.global_position
	level.add_child(new_hp_comp)
	var tween : Tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(new_hp_comp, "position", global_position, 0.12)
	#tween.tween_property(new_hp_comp, "scale", Vector2(0.8, 0.8), 0.12)
	tween.finished.connect(Callable(
		func() -> void:
			$AnimationPlayer.play("Updated")
			new_hp_comp.queue_free()
	))
	
	
func update_label() -> void:
	hp = new_hp_value
	hp_updated.emit(hp)
	
	
func update_hp(new_hp : int) -> void:
	new_hp_value = new_hp
	$AnimationPlayer.play("Updated")
