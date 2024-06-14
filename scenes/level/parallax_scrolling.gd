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

@onready var layer_sprite_list : Array[Sprite2D] = [
	layer_01_sprite, layer_02_sprite, layer_03_sprite, layer_04_sprite, layer_05_sprite,
	layer_06_sprite, layer_07_sprite, layer_08_sprite, layer_09_sprite, layer_10_sprite,
]

@export var layer_01_texture : Texture2D:
	set(new_value):
		layer_01_texture = new_value
		if Engine.is_editor_hint() && layer_01_sprite != null:
			layer_01_sprite.texture = new_value

@export var layer_02_texture : Texture2D:
	set(new_value):
		layer_02_texture = new_value
		if Engine.is_editor_hint() && layer_02_sprite != null:
			layer_02_sprite.texture = new_value
	
@export var layer_03_texture : Texture2D:
	set(new_value):
		layer_03_texture = new_value
		if Engine.is_editor_hint() && layer_03_sprite != null:
			layer_03_sprite.texture = new_value
	
@export var layer_04_texture : Texture2D:
	set(new_value):
		layer_04_texture = new_value
		if Engine.is_editor_hint() && layer_04_sprite != null:
			layer_04_sprite.texture = new_value
	
@export var layer_05_texture : Texture2D:
	set(new_value):
		layer_05_texture = new_value
		if Engine.is_editor_hint() && layer_05_sprite != null:
			layer_05_sprite.texture = new_value
	
@export var layer_06_texture : Texture2D:
	set(new_value):
		layer_06_texture = new_value
		if Engine.is_editor_hint() && layer_06_sprite != null:
			layer_06_sprite.texture = new_value
	
@export var layer_07_texture : Texture2D:
	set(new_value):
		layer_07_texture = new_value
		if Engine.is_editor_hint() && layer_07_sprite != null:
			layer_07_sprite.texture = new_value
	
@export var layer_08_texture : Texture2D:
	set(new_value):
		layer_08_texture = new_value
		if Engine.is_editor_hint() && layer_08_sprite != null:
			layer_08_sprite.texture = new_value
	
@export var layer_09_texture : Texture2D:
	set(new_value):
		layer_09_texture = new_value
		if Engine.is_editor_hint() && layer_09_sprite != null:
			layer_09_sprite.texture = new_value
	
@export var layer_10_texture : Texture2D:
	set(new_value):
		layer_10_texture = new_value
		if Engine.is_editor_hint() && layer_10_sprite != null:
			layer_10_sprite.texture = new_value


@onready var layer_texture_list : Array[Texture2D] = [
	layer_01_texture, layer_02_texture, layer_03_texture, layer_04_texture, layer_05_texture,
	layer_06_texture, layer_07_texture, layer_08_texture, layer_09_texture, layer_10_texture,
]


func _ready() -> void:
	if (layer_01_sprite != null):
		layer_01_sprite.texture = layer_01_texture
	if (layer_02_sprite != null):
		layer_02_sprite.texture = layer_02_texture
	if (layer_03_sprite != null):
		layer_03_sprite.texture = layer_03_texture
	if (layer_04_sprite != null):
		layer_04_sprite.texture = layer_04_texture
	if (layer_05_sprite != null):
		layer_05_sprite.texture = layer_05_texture
	if (layer_06_sprite != null):
		layer_06_sprite.texture = layer_06_texture
	if (layer_07_sprite != null):
		layer_07_sprite.texture = layer_07_texture
	if (layer_08_sprite != null):
		layer_08_sprite.texture = layer_08_texture
	if (layer_09_sprite != null):
		layer_09_sprite.texture = layer_09_texture
	if (layer_10_sprite != null):
		layer_10_sprite.texture = layer_10_texture


func init_background(map_type : Enums.EMapType) -> void:
	for layer_sprite in layer_sprite_list:
		layer_sprite.texture = null
		
	if map_type == Enums.EMapType.Halloween_Green:
		_set_background_by_bean(Preload.map_halloween_green_bean)
	elif map_type == Enums.EMapType.Halloween_Red:
		_set_background_by_bean(Preload.map_halloween_red_bean)
	elif map_type == Enums.EMapType.Halloween_Blue:
		_set_background_by_bean(Preload.map_halloween_blue_bean)
	elif map_type == Enums.EMapType.Halloween_Orange:
		_set_background_by_bean(Preload.map_halloween_orange_bean)
	elif map_type == Enums.EMapType.Sweet_Pink:
		_set_background_by_bean(Preload.map_sweet_pink_bean)
	elif map_type == Enums.EMapType.Sweet_Blue:
		_set_background_by_bean(Preload.map_sweet_blue_bean)
	elif map_type == Enums.EMapType.Sweet_Green:
		_set_background_by_bean(Preload.map_sweet_green_bean)
	elif map_type == Enums.EMapType.Sweet_Cyan:
		_set_background_by_bean(Preload.map_sweet_cyan_bean)
	elif map_type == Enums.EMapType.Desert_Cactus:
		_set_background_by_bean(Preload.map_desert_cactus_bean)
	elif map_type == Enums.EMapType.Desert_Rock:
		_set_background_by_bean(Preload.map_desert_rock_bean)
	elif map_type == Enums.EMapType.Desert_Sky:
		_set_background_by_bean(Preload.map_desert_sky_bean)
	elif map_type == Enums.EMapType.Desert_Dusk:
		_set_background_by_bean(Preload.map_desert_dusk_bean)
	elif map_type == Enums.EMapType.Beach_Blue:
		_set_background_by_bean(Preload.map_beach_blue_bean)
	elif map_type == Enums.EMapType.Beach_Green:
		_set_background_by_bean(Preload.map_beach_green_bean)
	elif map_type == Enums.EMapType.Beach_Cyan:
		_set_background_by_bean(Preload.map_beach_cyan_bean)
	elif map_type == Enums.EMapType.Beach_Dusk:
		_set_background_by_bean(Preload.map_beach_dusk_bean)
	

func _set_background_by_bean(map_bean : MapBean) -> void:
	for i in range(map_bean.background_textures.size()):
		layer_sprite_list[i].texture = map_bean.background_textures[i]
		if i != 0:
			layer_sprite_list[i].position.y = map_bean.y_offset
			if map_bean.y_offset < 0.0:
				$Soil.visible = true
				$Soil/ColorRect.color = map_bean.soil_color


func move_forward(speed : float, delta : float) -> void:
	for layer_iter in layer_list:
		layer_iter.motion_offset.x -= speed * delta * layer_iter.motion_scale.x
