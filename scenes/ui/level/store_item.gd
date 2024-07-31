@tool
extends Button
class_name StoreItem


@export var type : Enums.EItemType = Enums.EItemType.SpeedUp:
	set(new_value):
		type = new_value
		_update_store_item()
		

var data : ItemData
var count : int = 1:
	set(new_value):
		count = new_value
		$HBoxContainer/Count.text = str(count)
		if count == 0:
			self.disabled = true


func _ready() -> void:
	_update_store_item()
	
	
func _update_store_item() -> void:
	if type == Enums.EItemType.SpeedUp:
		data = load("res://resources/ui/item/speed_up.tres")
	elif type == Enums.EItemType.Better:
		data = load("res://resources/ui/item/better.tres")
	elif type == Enums.EItemType.Huge:
		data = load("res://resources/ui/item/huge.tres")
	elif type == Enums.EItemType.DoubleJump:
		data = load("res://resources/ui/item/double_jump.tres")
	elif type == Enums.EItemType.Luck:
		data = load("res://resources/ui/item/luck.tres")
	elif type == Enums.EItemType.Overtime:
		data = load("res://resources/ui/item/overtime.tres")
		
	$Icon.texture = data.icon_tex
	$Name.text = data.item_name
	$Detail.text = data.detail
	count = data.count
