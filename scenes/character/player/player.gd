extends Character
class_name Player


enum EPlayerState
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


@export_category("Movement Parameters")
@export var movement_speed : float = 400.0
@export var jump_peak_time : float = 0.5
@export var jump_fall_time : float = 0.5
@export var jump_height : float = 2.0
@export var jump_distance : float = 4.0

var jump_gravity : float
var jump_velocity : float
var fall_gravity : float
var player_state : EPlayerState = EPlayerState.Walk



func _ready() -> void:
	calculate_movement_parameters()


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if velocity.y > 0:
			velocity.y += jump_gravity * delta
		else:
			velocity.y += fall_gravity * delta

	if player_state == EPlayerState.Jump:
		velocity.y = jump_velocity

	if Input.is_action_just_pressed("test_up"):
		player_state = EPlayerState.Jump
	elif Input.is_action_just_pressed("test_down"):
		player_state = EPlayerState.Fall
	elif Input.is_action_just_pressed("test_left"):
		player_state = EPlayerState.Ready
	elif Input.is_action_just_pressed("test_right"):
		player_state = EPlayerState.Run
	elif Input.is_action_just_pressed("space"):
		player_state = EPlayerState.DoubleJump

	move_and_slide()


func calculate_movement_parameters() -> void:
	var jump_height_x2 : float = jump_height * 2
	jump_gravity = jump_height_x2 / pow(jump_peak_time, 2) * 100
	fall_gravity = jump_height_x2 / pow(jump_fall_time, 2) * 100
	jump_velocity = jump_gravity * jump_peak_time * 100
	movement_speed = (jump_distance / (jump_peak_time + jump_fall_time)) * 100