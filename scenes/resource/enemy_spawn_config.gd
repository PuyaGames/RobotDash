extends Resource
class_name EnemySpawnConfig


@export var enemy_type_list : Array[Enums.EEnemyType] = []
@export var enemy_occurrence_rate_dict : Dictionary = {
	"Grey" : 1.0,
	"Green" : 1.0,
	"Red" : 1.0,
	"Blue" : 0.4,
	"BlackOne" : 0.4,
	"BlackTwo" : 0.4,
	"BlackThree" : 0.4,
	"BlackFour" : 0.4,
	"BlackFive" : 0.4
}
