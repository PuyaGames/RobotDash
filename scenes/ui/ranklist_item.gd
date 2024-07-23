@tool
extends Panel


@export var rank_number : int = 1:
	set(new_value):
		rank_number = new_value
		$RankNumberLabel.text = "第%d名" % new_value
@export var score : int = 100:
	set(new_value):
		score = new_value
		$ScoreLabel.text = "%d米" % new_value
@export var id : String = "用户名#114514":
	set(new_value):
		id = new_value
		$IdLabel.text = "{name}#{id}".format({
			"name": new_value,
			"id": randi_range(1, 114514)
		})


func _ready() -> void:
	pass
	

func _process(delta: float) -> void:
	pass
