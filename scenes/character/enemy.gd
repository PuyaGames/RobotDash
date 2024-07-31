extends Character
class_name Enemy


@export var enemy_type : Enums.EEnemyType = Enums.EEnemyType.Grey
@export var hp : int = 100
@export var death_sound : AudioStream

@onready var hp_number : HpNumber = $HpNumber

var _dead_texture : AtlasTexture
var up_time : float = 0.4
var down_time : float = 0.2
var up_height : float = 3.0
var up_gravity : float
var up_velocity : float
var down_gravity : float
var dead : bool = false


func _ready() -> void:
	$VisibleOnScreenNotifier2D.show()
	var main : Main = get_tree().get_first_node_in_group("main")
	if enemy_type == Enums.EEnemyType.Grey:
		$HpNumber.hp = 1
	elif enemy_type == Enums.EEnemyType.Green:
		$HpNumber.hp = 0
	elif enemy_type == Enums.EEnemyType.Red:
		$HpNumber.hp = 3
	elif enemy_type == Enums.EEnemyType.Blue:
		$HpNumber.hp = 4
	elif enemy_type == Enums.EEnemyType.BlackOne:
		$HpNumber.hp = 0
	elif enemy_type == Enums.EEnemyType.BlackTwo:
		$HpNumber.hp = -2
	elif enemy_type == Enums.EEnemyType.BlackThree:
		$HpNumber.hp = 999
	elif enemy_type == Enums.EEnemyType.BlackFour:
		$HpNumber.hp = -10
	elif enemy_type == Enums.EEnemyType.BlackFive:
		$HpNumber.hp = main.active_level.player.get_hp()
		main.active_level.player.connect("on_hp_updated", _update_hp)
	
	var rng : RandomNumberGenerator = RandomNumberGenerator.new()
	var timer : SceneTreeTimer = get_tree().create_timer(rng.randf_range(0, 2.0))
	timer.connect("timeout", Callable(
		func() -> void: $AnimationPlayer.play("Breath")
	))
	
	_calculate_movement_parameters()
	

func _physics_process(delta: float) -> void:
	if velocity.y > 0.0:
		velocity.y += down_gravity * delta
	else:
		velocity.y += up_gravity * delta

	move_and_slide()
	
	
func _calculate_movement_parameters() -> void:
	var up_height_x2 : float = up_height * 2
	up_gravity = up_height_x2 / pow(up_time, 2) * 100.0
	down_gravity = up_height_x2 / pow(down_time, 2) * 100.0
	up_velocity = up_gravity * up_time * -1.0
	
	
func init_enemy(in_enemy_type : Enums.EEnemyType) -> void:
	enemy_type = in_enemy_type
	_init_enemy()
	
	
func _init_enemy() -> void:
	if enemy_type == Enums.EEnemyType.Grey:
		_set_enemy_by_bean(load(Paths.enemy_grey_bean))
	elif enemy_type == Enums.EEnemyType.Green:
		_set_enemy_by_bean(load(Paths.enemy_green_bean))
	elif enemy_type == Enums.EEnemyType.Red:
		_set_enemy_by_bean(load(Paths.enemy_red_bean))
	elif enemy_type == Enums.EEnemyType.Blue:
		_set_enemy_by_bean(load(Paths.enemy_blue_bean))
	elif enemy_type == Enums.EEnemyType.BlackOne:
		_set_enemy_by_bean(load(Paths.enemy_black_01_bean))
	elif enemy_type == Enums.EEnemyType.BlackTwo:
		_set_enemy_by_bean(load(Paths.enemy_black_02_bean))
	elif enemy_type == Enums.EEnemyType.BlackThree:
		_set_enemy_by_bean(load(Paths.enemy_black_03_bean))
	elif enemy_type == Enums.EEnemyType.BlackFour:
		_set_enemy_by_bean(load(Paths.enemy_black_04_bean))
	elif enemy_type == Enums.EEnemyType.BlackFive:
		_set_enemy_by_bean(load(Paths.enemy_black_05_bean))
	
	
func _set_enemy_by_bean(enemy_bean : EnemyBean) -> void:
	$Sprite2D.texture = enemy_bean.idle_texture
	_dead_texture = enemy_bean.dead_texture
	
	
func die() -> void:
	dead = true
	$CollisionShape2D.queue_free()
	$AnimationPlayer.play("Rotate")
	$Sprite2D.texture = _dead_texture
	var rng : RandomNumberGenerator = RandomNumberGenerator.new()
	up_height = rng.randf_range(0.1, 3.0)
	up_time = rng.randf_range(0.1, 0.4)
	_calculate_movement_parameters()
	velocity.x = rng.randf_range(600.0, 1000.0)
	velocity.y = up_velocity
	z_index = 100
	SoundManager.play_sound(death_sound)
	
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
	
func _update_hp(new_hp : int) -> void:
	$HpNumber.update_hp(new_hp)
