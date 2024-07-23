@tool
extends Panel

@onready var clip_box: ColorRect = $ClipBox
@onready var id_label: Label = $ClipBox/IdLabel

@export var rank_number : int = 1:
	set(new_value):
		rank_number = new_value
		$RankNumberLabel.text = "第%d名" % new_value
			
@export var hp : int = 100:
	set(new_value):
		hp = new_value
		$HpLabel.text = "%d米" % new_value
			
@export var id : String = "用户名#114514":
	set(new_value):
		id = new_value
		$ClipBox/IdLabel.text = "{name}#{id}".format({
			"name": new_value,
			"id": randi_range(1, 114514)
		})

var enable_scrolling : bool = false


func _ready() -> void:
	if id_label.size.x > clip_box.size.x:
		enable_scrolling = true
	

func _process(delta: float) -> void:
	if enable_scrolling:
		id_label.position.x -= 1.0
		if id_label.position.x < (id_label.size.x * -1):
			id_label.position = Vector2(0.0, 0.0)
