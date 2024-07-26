extends CanvasLayer


var player : Player


func init_defeat_menu(in_player : Player) -> void:
	player = in_player


func _ready() -> void:
	$AnimationPlayer.play("Enter")


func _on_revive_button_button_down() -> void:
	queue_free()
	player.revive()


func _on_main_menu_button_button_down() -> void:
	var main : Main = get_tree().get_first_node_in_group("main")
	for node in main.get_children():
		node.queue_free()
	var main_menu : PackedScene = load("res://scenes/ui/main_menu.tscn")
	main.add_child(main_menu.instantiate())
