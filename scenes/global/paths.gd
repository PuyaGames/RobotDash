extends Node


const tscn_short_platform : String = "res://scenes/level/platform/short_platform.tscn"
const tscn_long_platform : String = "res://scenes/level/platform/long_platform.tscn"
# Character
const player_dazhuang_bean : String = "res://resources/player/dazhuang_bean.tres"
const player_robot_bean : String = "res://resources/player/robot_bean.tres"
const player_sangbiao_bean : String = "res://resources/player/sangbiao_bean.tres"
const player_xiaoli_bean : String = "res://resources/player/xiaoli_bean.tres"
const player_xiaomei_bean : String = "res://resources/player/xiaomei_bean.tres"
const player_zombie_bean : String = "res://resources/player/zombie_bean.tres"
const enemy_grey_bean : String = "res://resources/enemy/grey_bean.tres"
const enemy_red_bean : String = "res://resources/enemy/red_bean.tres"
const enemy_green_bean : String = "res://resources/enemy/green_bean.tres"
const enemy_blue_bean : String = "res://resources/enemy/blue_bean.tres"
const enemy_black_01_bean : String = "res://resources/enemy/black_01_bean.tres"
const enemy_black_02_bean : String = "res://resources/enemy/black_02_bean.tres"
const enemy_black_03_bean : String = "res://resources/enemy/black_03_bean.tres"
const enemy_black_04_bean : String = "res://resources/enemy/black_04_bean.tres"
const enemy_black_05_bean : String = "res://resources/enemy/black_05_bean.tres"
const enemy_path_table : Dictionary = {
	Enums.EEnemyType.Grey : enemy_grey_bean,
	Enums.EEnemyType.Green : enemy_green_bean,
	Enums.EEnemyType.Red : enemy_red_bean,
	Enums.EEnemyType.Blue : enemy_blue_bean,
	Enums.EEnemyType.BlackOne : enemy_black_01_bean,
	Enums.EEnemyType.BlackTwo : enemy_black_02_bean,
	Enums.EEnemyType.BlackThree : enemy_black_03_bean,
	Enums.EEnemyType.BlackFour : enemy_black_04_bean,
	Enums.EEnemyType.BlackFive : enemy_black_05_bean
}
# Map
const map_halloween_green_bean : String = "res://resources/map/halloween_green_bean.tres"
const map_halloween_red_bean : String = "res://resources/map/halloween_red_bean.tres"
const map_halloween_blue_bean : String = "res://resources/map/halloween_blue_bean.tres"
const map_halloween_orange_bean : String = "res://resources/map/halloween_orange_bean.tres"
const map_sweet_pink_bean : String = "res://resources/map/sweet_pink_bean.tres"
const map_sweet_blue_bean : String = "res://resources/map/sweet_blue_bean.tres"
const map_sweet_green_bean : String = "res://resources/map/sweet_green_bean.tres"
const map_sweet_cyan_bean : String = "res://resources/map/sweet_cyan_bean.tres"
const map_desert_cactus_bean : String = "res://resources/map/desert_cactus_bean.tres"
const map_desert_rock_bean : String = "res://resources/map/desert_rock_bean.tres"
const map_desert_sky_bean : String = "res://resources/map/desert_sky_bean.tres"
const map_desert_dusk_bean : String = "res://resources/map/desert_dusk_bean.tres"
const map_beach_blue_bean : String = "res://resources/map/beach_blue_bean.tres"
const map_beach_green_bean : String = "res://resources/map/beach_green_bean.tres"
const map_beach_cyan_bean : String = "res://resources/map/beach_cyan_bean.tres"
const map_beach_dusk_bean : String = "res://resources/map/beach_dusk_bean.tres"
# UI
const sf_dazhuang_run : String = "res://resources/ui/sf_dazhuang_run.tres"
const sf_xiaomei_run : String = "res://resources/ui/sf_xiaomei_run.tres"
const sf_xiaoli_run : String = "res://resources/ui/sf_xiaoli_run.tres"
const sf_sangbiao_run : String = "res://resources/ui/sf_sangbiao_run.tres"
const sf_robot_run : String = "res://resources/ui/sf_robot_run.tres"
const sf_zombie_run : String = "res://resources/ui/sf_zombie_run.tres"
# PackedScene
const tscn_level : String = "res://scenes/level/level.tscn"
const tscn_main_menu : String = "res://scenes/ui/main_menu.tscn"
const tscn_player : String = "res://scenes/character/player/player.tscn"
