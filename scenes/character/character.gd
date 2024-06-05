extends CharacterBody2D


var gravity : Variant = ProjectSettings.get_setting("physics/2d/default_gravity")
var movement_speed : float = 600.0
var character_mass : float = 40

@onready var character_sprite : AnimatedSprite2D = get_node("AnimatedSprite2D")

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO

	if not is_on_floor():
		velocity.y += gravity * character_mass * delta

	if Input.is_action_pressed("test_right") and is_on_floor():
		velocity.x += movement_speed
		character_sprite.flip_h = false
	elif Input.is_action_pressed("test_left") and is_on_floor():
		velocity.x -= movement_speed
		character_sprite.flip_h = true

	move_and_slide()
