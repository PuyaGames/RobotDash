extends Node2D
class_name ItemChest


var tscn_chest_menu : PackedScene = load("res://scenes/ui/level/chest_menu.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		var chest_menu : UI_ChestMenu = tscn_chest_menu.instantiate()
		get_tree().get_first_node_in_group("main").active_level.add_child(chest_menu)
		body.set_idle_state()
		queue_free()


