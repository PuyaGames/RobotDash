extends CanvasLayer


signal loading_finished

@export var loading_time : float = 2.0

#const pick_pool : Array[String] = [
	#Paths.sf_dazhuang_run,
	#Paths.sf_robot_run,
	#Paths.sf_sangbiao_run,
	#Paths.sf_xiaoli_run,
	#Paths.sf_xiaomei_run,
	#Paths.sf_zombie_run
#]

func _ready() -> void:
	$Panel/AnimatedSprite2D.play()
	if loading_time > 0.0:
		$Timer.start(loading_time)
		$Timer.connect("timeout", Callable(self, "free_self"))
	
	
func free_self() -> void:
	loading_finished.emit()
	queue_free()


