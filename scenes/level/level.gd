extends Node2D
class_name Level


@onready var player : Player = $"Visible/SubViewportContainer/SubViewport/Player"
@onready var background : ParallaxScrolling = $"Visible/SubViewportContainer/SubViewport/Background"
@onready var foreground : ParallaxScrolling = $"Visible/SubViewportContainer/SubViewport/Foreground"
@onready var terrain_generator : TerrainGenerator = $"Visible/SubViewportContainer/SubViewport/TerrainGenerator"

var odometer : int = 0


func _ready() -> void:
	odometer = player.position.x as int
	pass
	

func _process(delta: float) -> void:
	background.move_forward(player.movement_speed, delta)
	terrain_generator.move_forward(player.movement_speed, delta)
	odometer += player.movement_speed * delta as int


func _on_jump_button_button_down() -> void:
	if player.is_can_double_jump():
		player.double_jump()
	else:
		player.jump()
