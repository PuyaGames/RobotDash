extends Node
class_name Main


var active_level : Level


func _ready() -> void:
	pass # Replace with function body.

	
func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		pass
