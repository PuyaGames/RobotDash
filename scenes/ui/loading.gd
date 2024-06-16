extends CanvasLayer


signal loading_finished


func _ready() -> void:
	var pick_pool : Array[SpriteFrames] = [
		Preload.sf_dazhuang_run,
		Preload.sf_robot_run,
		Preload.sf_sangbiao_run,
		Preload.sf_xiaoli_run,
		Preload.sf_xiaomei_run,
		Preload.sf_zombie_run
	]
	
	$Panel/AnimatedSprite2D.sprite_frames = pick_pool.pick_random()
	$Panel/AnimatedSprite2D.play()
	
	
func queue_self() -> void:
	loading_finished.emit()
	queue_free()


