extends CanvasLayer


signal loading_finished

@export var loading_time : float = 2.0

const pick_pool : Array[SpriteFrames] = [
	Preload.sf_dazhuang_run,
	Preload.sf_robot_run,
	Preload.sf_sangbiao_run,
	Preload.sf_xiaoli_run,
	Preload.sf_xiaomei_run,
	Preload.sf_zombie_run
]

func _ready() -> void:
	$Panel/AnimatedSprite2D.sprite_frames = pick_pool.pick_random()
	$Panel/AnimatedSprite2D.play()
	$Timer.start(loading_time)
	$Timer.connect("timeout", Callable(self, "free_self"))
	
	
func free_self() -> void:
	loading_finished.emit()
	queue_free()


