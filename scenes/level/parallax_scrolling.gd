@tool
extends ParallaxBackground


@export var layer_beans : Array[FScrollingLayerBean]


func _ready() -> void:
	for bean in layer_beans:
		var new_layer : ParallaxLayer = ParallaxLayer.new()
		new_layer.scale = Vector2(bean.scale_x, 1.0)
		new_layer.motion_mirroring = bean.motion_mirroring
		var new_sprite : Sprite2D = Sprite2D.new()
		new_sprite.texture = bean.sprite
		new_sprite.centered = false
		new_sprite.scale = bean.sprite_size / Vector2(1920.0, 1080.0)
		new_layer.add_child(new_sprite)
		self.add_child(new_layer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
