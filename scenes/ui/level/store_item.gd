@tool
extends Button
class_name StoreItem


signal clicked(store_item : StoreItem)


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
			$HBoxContainer/Count.modulate = Color.RED
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
	elif type == Enums.EItemType.OneAttack:
		data = load("res://resources/ui/item/one_attack.tres")
	elif type == Enums.EItemType.Retreat:
		data = load("res://resources/ui/item/retreat.tres")
		
	$Icon.texture = data.icon_tex
	$Name.text = data.item_name
	$Detail.text = data.detail
	count = data.count


func _on_button_up() -> void:
	clicked.emit(self)
