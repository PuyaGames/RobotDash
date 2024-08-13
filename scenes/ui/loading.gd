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
	
	
func show_and_queue(timer_enabled : bool = false) -> void:
	show()
	$Panel/AnimatedSprite2D.play()
	if timer_enabled:
		$Timer.start(loading_time)
		$Timer.connect("timeout", Callable(self, "free_self"))
	
	
func show_and_hide(timer_enabled : bool = false) -> void:
	show()
	$Panel/AnimatedSprite2D.play()
	if timer_enabled:
		$Timer.start(loading_time)
		$Timer.connect("timeout", Callable(self, "hide_self"))
	
	
	
func free_self() -> void:
	loading_finished.emit()
	queue_free()


func hide_self() -> void:
	loading_finished.emit()
	hide()
