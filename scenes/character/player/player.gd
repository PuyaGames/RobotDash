extends Character
class_name Player


enum EPlayerState
{
	Walk,
	Run,
	Jump,
	DoubleJump,
	Fall,
	Idle,
	Attack,
	Cheer,
	Kick,
	Shove,
	Ready
}

@export var _player_type : Enums.EPlayerType = Enums.EPlayerType.DaZhuang

@onready var anim_tree : AnimationTree = $"AnimationTree"

var running : bool = false
var jump_peak_time : float = 0.5
var jump_fall_time : float = 0.5
var jump_height : float = 2.0
var can_double_jump : bool = false
var movement_speed : float = 300.0
var player_jump_position : Vector2
var has_double_jump : bool = false
var jump_gravity : float
var jump_velocity : float
var fall_gravity : float
var player_state : EPlayerState = EPlayerState.Walk


func _ready() -> void:
	_calculate_movement_parameters()


func _physics_process(delta: float) -> void:
	if running == false:
		return
	
	position.x = 120.0

	if velocity.y > 0.0:
		velocity.y += fall_gravity * delta
		if not is_on_floor() &&\
		(player_state == EPlayerState.Jump ||\
		 player_state == EPlayerState.Run):
			set_fall_state()
	else:
		velocity.y += jump_gravity * delta
		if player_state == EPlayerState.Jump && is_on_floor():
			if player_jump_position.y - position.y > 100.0:
				reset_jump_state()
	
	if is_on_floor():
		if player_state == EPlayerState.Fall ||\
		   player_state == EPlayerState.DoubleJump:
			reset_jump_state()
			
	move_and_slide()


func _calculate_movement_parameters() -> void:
	var jump_height_x2 : float = jump_height * 2
	jump_gravity = jump_height_x2 / pow(jump_peak_time, 2) * 100.0
	fall_gravity = jump_height_x2 / pow(jump_fall_time, 2) * 100.0
	jump_velocity = jump_gravity * jump_peak_time * -1.0
	
	
func init_player(player_type : Enums.EPlayerType) -> void:
	_player_type = player_type
	_init_player()
	
	
func _init_player() -> void:
	if _player_type == Enums.EPlayerType.XiaoLi:
		_set_player_by_bean(Preload.player_xiaoli_bean)
	elif _player_type == Enums.EPlayerType.XiaoMei:
		_set_player_by_bean(Preload.player_xiaomei_bean)
	elif _player_type == Enums.EPlayerType.DaZhuang:
		_set_player_by_bean(Preload.player_dazhuang_bean)
	elif _player_type == Enums.EPlayerType.SangBiao:
		_set_player_by_bean(Preload.player_sangbiao_bean)
	elif _player_type == Enums.EPlayerType.Robot:
		_set_player_by_bean(Preload.player_robot_bean)
	elif _player_type == Enums.EPlayerType.Zombie:
		_set_player_by_bean(Preload.player_zombie_bean)
		
		
func _set_player_by_bean(player_bean : PlayerBean) -> void:
	$"Sprite2D".texture = player_bean.texture_sheet
	jump_peak_time = player_bean.jump_peak_time
	jump_fall_time = player_bean.jump_fall_time
	jump_height = player_bean.jump_height
	can_double_jump = player_bean.can_double_jump
	movement_speed = player_bean.movement_speed
	

func set_walk_state() -> void:
	player_state = EPlayerState.Walk

func set_run_state() -> void:
	player_state = EPlayerState.Run

func set_jump_state() -> void:
	player_state = EPlayerState.Jump

func set_double_jump_state() -> void:
	player_state = EPlayerState.DoubleJump

func set_fall_state() -> void:
	player_state = EPlayerState.Fall

func set_idle_state() -> void:
	player_state = EPlayerState.Idle

func set_attack_state() -> void:
	player_state = EPlayerState.Attack

func set_cheer_state() -> void:
	player_state = EPlayerState.Cheer

func set_kick_state() -> void:
	player_state = EPlayerState.Kick

func set_shove_state() -> void:
	player_state = EPlayerState.Shove


func jump() -> void:
	if player_state == EPlayerState.Run:
		set_jump_state()
		player_jump_position = position
		velocity.y = jump_velocity


func double_jump() -> void:
	set_double_jump_state()
	velocity.y = jump_velocity
	has_double_jump = true


func is_can_double_jump() -> bool:
	if can_double_jump == false:
		return false

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

