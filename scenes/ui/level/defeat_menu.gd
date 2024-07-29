extends CanvasLayer


@export var click_sound : AudioStream

var level : Level


func init_defeat_menu(in_level : Level) -> void:
	level = in_level


func _ready() -> void:
	$AnimationPlayer.play("Enter")


func _on_revive_button_button_down() -> void:
	queue_free()
	level.player.revive()


func _on_main_menu_button_button_down() -> void:
	SoundManager.play_sound(click_sound)
	var main : Main = get_tree().get_first_node_in_group("main")
	main.open_main_menu()
