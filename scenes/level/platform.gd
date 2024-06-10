extends Node2D


enum EPlatformType
{
	Short,
	Long
}


@export var platform_type: EPlatformType = EPlatformType.Short

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	if platform_type == EPlatformType.Short:
		_set_platform_data(Preload.platform_short)
	else:
		_set_platform_data(Preload.platform_long)
	
	
func _set_platform_data(platform_data: PlatformData) -> void:
	sprite_2d.texture = platform_data.texture
	collision_shape_2d.shape = platform_data.collision
	collision_shape_2d.position = platform_data.collision_position
