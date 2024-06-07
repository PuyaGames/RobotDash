extends CharacterBody2D
class_name Character


@export var movement_speed : float = 200.0
@export var character_mass : float = 40.0
@export var jump_force : float = -600.0

var gravity : Variant = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var character_sprite : AnimatedSprite2D = get_node("AnimatedSprite2D")

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

		#velocity.y = jump_force

	move_and_slide()


func jump() -> void:
	pass
