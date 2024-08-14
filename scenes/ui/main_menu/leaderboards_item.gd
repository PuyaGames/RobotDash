extends Panel

@onready var clip_box: ColorRect = $ClipBox
@onready var id_label: Label = $ClipBox/IdLabel

@export var _rank : int = 1:
	set(new_value):
		_rank = new_value
		$RankLabel.text = "第%d名" % new_value
			
@export var _score : int = 100:
	set(new_value):
		_score = new_value
		$ScoreLabel.text = "%d米" % new_value
			
@export var _nickname : String = "用户名#114514":
	set(new_value):
		_nickname = new_value
		$ClipBox/NicknameLabel.text = new_value

var enable_scrolling : bool = false


func init_data(rank : int, nickname : String, score : int) -> void:
	_rank = rank
	_nickname = nickname
	_score = score


func _ready() -> void:
	if id_label.size.x > clip_box.size.x:
		enable_scrolling = true
	

func _process(_delta: float) -> void:
	if enable_scrolling:
		id_label.position.x -= 1.0
		if id_label.position.x < (id_label.size.x * -1):
			id_label.position = Vector2(0.0, 0.0)
