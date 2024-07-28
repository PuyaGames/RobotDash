extends CanvasLayer
class_name UI_Guess


signal guess_finished(win : bool)
signal closed


var player_number : int = 10


func _ready() -> void:
	var number_pool : Array[int] = []
	for number in range(2, 11):
		if number == player_number:
			continue
		else:
			number_pool.append(number)
	
	var enemy_number : int = number_pool.pick_random()
	$PlayerCard.flip_card(player_number)
	await $PlayerCard.anim_finished
	$EnemyCard.flip_card(enemy_number)
	$EnemyCard.connect("anim_finished", Callable(
		func() -> void:
			if player_number > enemy_number:
				$Result.text = "你赢了！"
				$Result.show()
				guess_finished.emit(true)
			else:
				$Result.text = "你输了！"
				$Result.show()
				guess_finished.emit(false)
	))
	
	
	
func generate_player_number(number : int = -1) -> void:
	if number == -1:
		player_number = randi_range(2, 10)
	else:
		player_number = number
