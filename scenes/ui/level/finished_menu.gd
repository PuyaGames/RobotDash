extends CanvasLayer
class_name UI_FinishedMenu


@export var click_sound : AudioStream

var current_map_type : Enums.EMapType


func _ready() -> void:
	$AnimationPlayer.play("Enter")
	var main : Main = get_tree().get_first_node_in_group("main")
	if main.music_enabled:
		main.fade_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_button_button_down() -> void:
	var main : Main = get_tree().get_first_node_in_group("main")
	main.load_level(current_map_type)
	queue_free()


func _on_main_menu_button_button_down() -> void:
	SoundManager.play_sound(click_sound)
	var main : Main = get_tree().get_first_node_in_group("main")
	main.open_main_menu()
	queue_free()
