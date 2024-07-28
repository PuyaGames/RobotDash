extends CanvasLayer


var level : Level


func init_defeat_menu(in_level : Level) -> void:
	level = in_level


func _ready() -> void:
	$AnimationPlayer.play("Enter")


func _on_revive_button_button_down() -> void:
	queue_free()
	level.player.revive()


func _on_main_menu_button_button_down() -> void:
	var main : Main = get_tree().get_first_node_in_group("main")
	for node in main.get_children():
		node.queue_free()
	var main_menu : PackedScene = load(Paths.tscn_main_menu)
	main.add_child(main_menu.instantiate())
