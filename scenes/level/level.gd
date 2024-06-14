extends Node2D
class_name Level

@export var map_type : Enums.EMapType = Enums.EMapType.Halloween_Green

@onready var player : Player = $"Visible/SubViewportContainer/SubViewport/Player"
@onready var background : ParallaxScrolling = $"Visible/SubViewportContainer/SubViewport/Background"
@onready var terrain_generator : TerrainGenerator = $"Visible/SubViewportContainer/SubViewport/TerrainGenerator"

var odometer : int = 0


func _ready() -> void:
	_init_level_map()
	odometer = player.position.x as int
	

func _process(delta: float) -> void:
	background.move_forward(player.movement_speed, delta)
	terrain_generator.move_forward(player.movement_speed, delta)
	odometer += player.movement_speed * delta as int


func _on_jump_button_button_down() -> void:
	if player.is_can_double_jump():
		player.double_jump()
	else:
		player.jump()
		
		
func _init_level_map() -> void:
	pass
	background.init_background(map_type)
	terrain_generator.init_terrain_generator(map_type)


func _on_pause_button_toggled(toggled_on: bool) -> void:
	get_tree().paused = true
