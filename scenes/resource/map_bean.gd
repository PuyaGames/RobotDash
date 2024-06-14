extends Resource
class_name MapBean

@export var background_textures : Array[Texture2D]
@export var short_platform_texture : AtlasTexture
@export var long_platform_texture : AtlasTexture
@export var terrain_texture : Texture2D
@export var y_offset : float
# Useful when the y_offset < 0.0
@export var soil_color : Color = Color.WHITE
