extends Character


@export var enemy_bean : EnemyBean

@export var dead_texture : AtlasTexture

var up_time : float = 0.4
var down_time : float = 0.2
var up_height : float = 3.0
var up_gravity : float
var up_velocity : float
var down_gravity : float

func _ready() -> void:
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
	
	
func dead() -> void:
	$CollisionShape2D.disabled = true
	$AnimationPlayer.play("Rotate")
	$Sprite2D.texture = dead_texture
	var rng : RandomNumberGenerator = RandomNumberGenerator.new()
	velocity.x = rng.randf_range(300.0, 600.0)
	velocity.y = up_velocity
	z_index = 100
	
	
	

