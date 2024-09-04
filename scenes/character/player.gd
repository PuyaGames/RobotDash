extends Character
class_name Player


signal on_dead
signal on_revive
signal on_hp_updated(new_hp : int)


enum EPlayerState
{
	Walk,
	Run,
	Jump,
	DoubleJump,
	Fall,
	Idle,
	Cheer,
	Kick,
	Shove,
	Ready,
	Dead
}

@export var _player_type : Enums.EPlayerType = Enums.EPlayerType.Robot
@export var start_hp : int = 3

@onready var anim_tree : AnimationTree = $"AnimationTree"
@onready var hp_number : Node2D = $HpNumber

var jump_height_bak : float
var jump_peak_time_bak : float
var jump_fall_time_bak : float
const death_jump_height : float = 1.0
const death_jump_peak_time : float = 0.3
const death_jump_fall_time : float = 0.2

const attack_state_pool : Array[EPlayerState] = [
	EPlayerState.Kick,
	EPlayerState.Shove
]

var running : bool = false
var jump_peak_time : float = 0.5
var jump_fall_time : float = 0.5
var jump_height : float = 2.0
# For store item
var can_jump : bool = true
var can_double_jump : bool = false
var offset : float = 160.0
var better : bool = false
var one_attack : bool = false
var movement_speed : float = 300.0
var player_jump_position : Vector2
var has_double_jump : bool = false
var jump_gravity : float
var jump_velocity : float
var fall_gravity : float
var player_state : EPlayerState = EPlayerState.Walk
var level : Level
var next_speed_level : int = 2


func _ready() -> void:
	$Area2D.show()
	$CollisionShape2D.show()
	$VisibleOnScreenNotifier2D.show()
	$HpNumber.hp = start_hp
	$HpNumber.connect("hp_updated", _on_hp_updated)
	level = get_tree().get_first_node_in_group("main").active_level
	_calculate_movement_parameters()


func _physics_process(delta: float) -> void:
	if running == false:
		return
	
	position.x = offset

	if velocity.y > 0.0:
		velocity.y += fall_gravity * delta
		if not is_on_floor() &&\
		(player_state == EPlayerState.Jump ||\
			player_state == EPlayerState.DoubleJump ||\
			player_state == EPlayerState.Run||\
			player_state == EPlayerState.Kick||\
			player_state == EPlayerState.Shove):
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
		_set_player_by_bean(load(Paths.player_xiaoli_bean))
	elif _player_type == Enums.EPlayerType.XiaoMei:
		_set_player_by_bean(load(Paths.player_xiaomei_bean))
	elif _player_type == Enums.EPlayerType.DaZhuang:
		_set_player_by_bean(load(Paths.player_dazhuang_bean))
	elif _player_type == Enums.EPlayerType.SangBiao:
		_set_player_by_bean(load(Paths.player_sangbiao_bean))
	elif _player_type == Enums.EPlayerType.Robot:
		_set_player_by_bean(load(Paths.player_robot_bean))
	elif _player_type == Enums.EPlayerType.Zombie:
		_set_player_by_bean(load(Paths.player_zombie_bean))
		
	_calculate_movement_parameters()
		
		
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

func set_cheer_state() -> void:
	player_state = EPlayerState.Cheer

func set_kick_state() -> void:
	player_state = EPlayerState.Kick

func set_shove_state() -> void:
	player_state = EPlayerState.Shove


func jump() -> void:
	if can_jump == false:
		return
	
	if player_state == EPlayerState.Run:
		set_jump_state()
		player_jump_position = position
		velocity.y = jump_velocity


func double_jump() -> void:
	if can_jump == false:
		return
	
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
	
	
func attack(enemy : Enemy) -> void:
	if enemy == null:
		return
	
	if one_attack:
		player_state = attack_state_pool.pick_random()
		hp_number.add_hp(enemy)
		enemy.die()
		one_attack = false
		level.one_attack_state.text = "0 x 致命一击"
		return
	
	if get_hp() > enemy.get_hp():
		player_state = attack_state_pool.pick_random()
		hp_number.add_hp(enemy)
		enemy.die()
		GodotTDS.grow_achievement_steps("robot_dash_04")
	elif get_hp() < enemy.get_hp():
		die()
	else:
		judge(enemy)
		
	
func reset_attack_state() -> void:
	player_state = EPlayerState.Run
	
	
func die() -> void:
	call_deferred("_disable_collision")
	$HpNumber.hide()
	jump_height_bak = jump_height
	jump_peak_time_bak = jump_peak_time
	jump_fall_time_bak = jump_fall_time
	jump_height = death_jump_height
	jump_peak_time = death_jump_peak_time
	jump_fall_time = death_jump_fall_time
	_calculate_movement_parameters()
	velocity.y = jump_velocity
	player_state = EPlayerState.Dead
	on_dead.emit()
	
	
func _disable_collision() -> void:
	$CollisionShape2D.disabled = true
	
	
func revive() -> void:
	$CollisionShape2D.disabled = false
	$HpNumber.show()
	jump_height = jump_height_bak
	jump_peak_time = jump_peak_time_bak
	jump_fall_time = jump_fall_time_bak
	_calculate_movement_parameters()
	player_state = EPlayerState.Idle
	position = Vector2(160.0, 800.0)
	on_revive.emit()
	if get_hp() == 0:
		$HpNumber.hp = 10
	
	
func judge(faced_enemy : Enemy) -> void:
	if better:
		player_state = attack_state_pool.pick_random()
		hp_number.add_hp(faced_enemy)
		faced_enemy.die()
	else:
		player_state = EPlayerState.Dead
		die()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if position.y < 0.0:
		GodotTDS.reach_achievement("robot_dash_01")
	
	if player_state == EPlayerState.Dead:
		player_state = EPlayerState.Idle
		
		
func stop_running() -> void:
	position = Vector2(160.0, 800.0)
	player_state = EPlayerState.Idle
	
	
func _on_hp_updated(new_hp : int) -> void:
	if new_hp >= next_speed_level * 10.0:
		movement_speed += 20.0
		next_speed_level += 1
		
	on_hp_updated.emit(new_hp)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body is Enemy:
		return
	if player_state == EPlayerState.Dead:
		return
	var enemy : Enemy = body as Enemy
	if enemy.dead:
		return
		
	attack(enemy)
	
	
func become_normal() -> void:
	scale = Vector2(1.0, 1.0)
	can_jump = true
	set_collision_mask_value(4, true)
	
	
func apply_item_effect(store_item : StoreItem) -> void:
	print_debug(store_item, store_item.type, store_item.data.item_name)
	if store_item.type == Enums.EItemType.DoubleJump:
		store_item.count -= 1
		level.double_jump_count -= 1
		can_double_jump = true
		level.double_jump_state.text = "1 x 双重跳跃"
	elif store_item.type == Enums.EItemType.SpeedUp:
		store_item.count -= 1
		level.speed_up_count -= 1
		movement_speed += 20.0
		if level.speed_up_count == 0:
			level.speed_up_state.text = "2 x 速度提升"
		else:
			level.speed_up_state.text = "1 x 速度提升"
	elif store_item.type == Enums.EItemType.Better:
		store_item.count -= 1
		level.better_count -= 1
		better = true
		level.better_state.text = "1 x 略胜一筹"
	elif store_item.type == Enums.EItemType.Luck:
		store_item.count -= 1
		level.luck_count -= 1
		var main : Main = get_tree().get_first_node_in_group("main")
		main.add_enemy_to_pool(Enums.EEnemyType.Green, 100)
		level.luck_state.text = "1 x 幸运碎片"
	elif store_item.type == Enums.EItemType.Overtime:
		store_item.count -= 1
		level.overtime_count -= 1
		level.time_60s += 2
		level.overtime_state.text = "1 x 时间宝石"
	elif store_item.type == Enums.EItemType.OneAttack:
		store_item.count -= 1
		level.one_attack_count -= 1
		one_attack = true
		level.one_attack_state.text = "1 x 致命一击"
	elif store_item.type == Enums.EItemType.Retreat:
		store_item.count -= 1
		level.restreat_count -= 1
		offset = 100.0
		level.one_attack_state.text = "1 x 冷静思考"
