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
@export var jump_peak_time : float = 0.5
@export var jump_fall_time : float = 0.5
@export var jump_height : float = 2.0
@export var jump_distance : float = 4.0

@onready var anim_tree : AnimationTree = $"AnimationTree"

var jump_gravity : float
var jump_velocity : float
var fall_gravity : float
var movement_speed : float
var player_state : EPlayerState = EPlayerState.Run
var has_double_jump : bool = false



func _ready() -> void:
	calculate_movement_parameters()


func _physics_process(delta: float) -> void:
	if velocity.y > 0.0:
		velocity.y += jump_gravity * delta
		if not is_on_floor() &&\
		(player_state == EPlayerState.Jump || player_state == EPlayerState.DoubleJump):
			set_fall_state()
	else:
		velocity.y += fall_gravity * delta
	
	if is_on_floor():
		if player_state == EPlayerState.Fall:
			reset_jump_state()

	move_and_slide()


func calculate_movement_parameters() -> void:
	var jump_height_x2 : float = jump_height * 2
	jump_gravity = jump_height_x2 / pow(jump_peak_time, 2) * 100.0
	fall_gravity = jump_height_x2 / pow(jump_fall_time, 2) * 100.0
	jump_velocity = jump_gravity * jump_peak_time * -1.0
	movement_speed = (jump_distance / (jump_peak_time + jump_fall_time)) * 100.0


func set_walk_state() -> void:
	player_state = EPlayerState.Walk

func set_run_state() -> void:
	player_state = EPlayerState.Run

func set_jump_state() -> void:
	player_state = EPlayerState.Jump

func set_fall_state() -> void:
	player_state = EPlayerState.Fall

func set_idle_state() -> void:
	player_state = EPlayerState.Idle

func set_attack_state() -> void:
	player_state = EPlayerState.Attack

func set_cheer_state() -> void:
	player_state = EPlayerState.Cheer

func set_double_jump_state() -> void:
	player_state = EPlayerState.DoubleJump
	has_double_jump = true

func set_kick_state() -> void:
	player_state = EPlayerState.Kick

func set_shove_state() -> void:
	player_state = EPlayerState.Shove

func set_ready_state() -> void:
	player_state = EPlayerState.Ready


func jump() -> void:
	if player_state == EPlayerState.Run:
		set_jump_state()
		velocity.y = jump_velocity


func double_jump() -> void:
	set_double_jump_state()
	velocity.y = jump_velocity


func is_can_double_jump() -> bool:
	if player_state == EPlayerState.Fall && has_double_jump == false:
		return true

	if player_state != EPlayerState.Jump:
		return false

	if has_double_jump:
		return false

	return true


func reset_jump_state() -> void:
	set_run_state()
	has_double_jump = false