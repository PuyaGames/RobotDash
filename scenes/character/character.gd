extends CharacterBody2D
class_name Character


enum ECharacterState
{
    Walk,
    Run,
    Jump,
    Fall,
    Idle,
    Attack,
    Cheer,
    DoubleJump,
    Kick,
    Shove,
    Ready
}


@export var movement_speed : float = 200.0
@export var character_mass : float = 40.0
@export var jump_force : float = -600.0

var gravity : Variant = ProjectSettings.get_setting("physics/2d/default_gravity")
var character_state : ECharacterState = ECharacterState.Walk

@onready var character_body : Node2D = get_node("Body")

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

		#velocity.y = jump_force

	if Input.is_action_pressed("test_left"):
		print("YES")
		character_state = ECharacterState.Ready
	if Input.is_action_pressed("test_right"):
		print("YES")
		character_state = ECharacterState.Run
	if Input.is_action_pressed("test_up"):
		print("YES")
		character_state = ECharacterState.Cheer
	if Input.is_action_pressed("test_down"):
		print("YES")
		character_state = ECharacterState.Kick

	move_and_slide()


func jump() -> void:
	pass
