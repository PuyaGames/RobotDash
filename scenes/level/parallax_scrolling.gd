@tool
extends ParallaxBackground
class_name ParallaxScrolling


@onready var layer_01 : ParallaxLayer = $"ParallaxLayer1"
@onready var layer_02 : ParallaxLayer = $"ParallaxLayer2"
@onready var layer_03 : ParallaxLayer = $"ParallaxLayer3"
@onready var layer_04 : ParallaxLayer = $"ParallaxLayer4"
@onready var layer_05 : ParallaxLayer = $"ParallaxLayer5"
@onready var layer_06 : ParallaxLayer = $"ParallaxLayer6"
@onready var layer_07 : ParallaxLayer = $"ParallaxLayer7"
@onready var layer_08 : ParallaxLayer = $"ParallaxLayer8"
@onready var layer_09 : ParallaxLayer = $"ParallaxLayer9"
@onready var layer_10 : ParallaxLayer = $"ParallaxLayer10"

@onready var layer_list : Array[ParallaxLayer] = [
	layer_01, layer_02, layer_03, layer_04, layer_05,
	layer_06, layer_07, layer_08, layer_09, layer_10,
]

@onready var layer_01_sprite : Sprite2D = $"ParallaxLayer1/Sprite2D"
@onready var layer_02_sprite : Sprite2D = $"ParallaxLayer2/Sprite2D"
@onready var layer_03_sprite : Sprite2D = $"ParallaxLayer3/Sprite2D"
@onready var layer_04_sprite : Sprite2D = $"ParallaxLayer4/Sprite2D"
@onready var layer_05_sprite : Sprite2D = $"ParallaxLayer5/Sprite2D"
@onready var layer_06_sprite : Sprite2D = $"ParallaxLayer6/Sprite2D"
@onready var layer_07_sprite : Sprite2D = $"ParallaxLayer7/Sprite2D"
@onready var layer_08_sprite : Sprite2D = $"ParallaxLayer8/Sprite2D"
@onready var layer_09_sprite : Sprite2D = $"ParallaxLayer9/Sprite2D"
@onready var layer_10_sprite : Sprite2D = $"ParallaxLayer10/Sprite2D"

@export var layer_01_texture : Texture2D:
	set(new_value):
		layer_01_texture = new_value
		if Engine.is_editor_hint():
			layer_01_sprite.texture = new_value

@export var layer_02_texture : Texture2D:
	set(new_value):
		layer_02_texture = new_value
		if Engine.is_editor_hint():
			layer_02_sprite.texture = new_value
	
@export var layer_03_texture : Texture2D:
	set(new_value):
		layer_03_texture = new_value
		if Engine.is_editor_hint():
			layer_03_sprite.texture = new_value
	
@export var layer_04_texture : Texture2D:
	set(new_value):
		layer_04_texture = new_value
		if Engine.is_editor_hint():
			layer_04_sprite.texture = new_value
	
@export var layer_05_texture : Texture2D:
	set(new_value):
		layer_05_texture = new_value
		if Engine.is_editor_hint():
			layer_05_sprite.texture = new_value
	
@export var layer_06_texture : Texture2D:
	set(new_value):
		layer_06_texture = new_value
		if Engine.is_editor_hint():
			layer_06_sprite.texture = new_value
	
@export var layer_07_texture : Texture2D:
	set(new_value):
		layer_07_texture = new_value
		if Engine.is_editor_hint():
			layer_07_sprite.texture = new_value
	
@export var layer_08_texture : Texture2D:
	set(new_value):
		layer_08_texture = new_value
		if Engine.is_editor_hint():
			layer_08_sprite.texture = new_value
	
@export var layer_09_texture : Texture2D:
	set(new_value):
		layer_09_texture = new_value
		if Engine.is_editor_hint():
			layer_09_sprite.texture = new_value
	
@export var layer_10_texture : Texture2D:
	set(new_value):
		layer_10_texture = new_value
		if Engine.is_editor_hint():
			layer_10_sprite.texture = new_value


func _ready() -> void:
	layer_01_sprite.texture = layer_01_texture
	layer_02_sprite.texture = layer_02_texture
	layer_03_sprite.texture = layer_03_texture
	layer_04_sprite.texture = layer_04_texture
	layer_05_sprite.texture = layer_05_texture
	layer_06_sprite.texture = layer_06_texture
	layer_07_sprite.texture = layer_07_texture
	layer_08_sprite.texture = layer_08_texture


func move_forward(speed : float, delta : float) -> void:
	for iter in layer_list:
		iter.motion_offset.x -= speed * delta * iter.motion_scale.x


	


