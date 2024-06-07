extends Node2D
class_name Level


@onready var player : Character = $"SubViewportContainer/SubViewport/Player"
@onready var background : ParallaxScrolling = $"SubViewportContainer/SubViewport/Background"
@onready var foreground : ParallaxScrolling = $"SubViewportContainer/SubViewport/Foreground"
@onready var terrain_generator : TerrainGenerator = $"SubViewportContainer/SubViewport/TerrainGenerator"

var odometer : int = 0


func _ready() -> void:
	odometer = player.position.x as int
	

func _process(delta: float) -> void:
	background.move_forward(player.movement_speed, delta)
	terrain_generator.move_forward(player.movement_speed, delta)
	odometer += player.movement_speed * delta as int
