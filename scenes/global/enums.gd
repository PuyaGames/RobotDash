extends Node


enum EMapType
{
	Halloween_Green,
	Halloween_Red,
	Halloween_Blue,
	Halloween_Orange,
	Sweet_Pink,
	Sweet_Blue,
	Sweet_Green,
	Sweet_Cyan,
	Desert_Cactus,
	Desert_Rock,
	Desert_Sky,
	Desert_Dusk,
	Beach_Blue,
	Beach_Green,
	Beach_Cyan,
	Beach_Dusk
}

enum EPlayerType
{
	None,
	XiaoLi,
	XiaoMei,
	DaZhuang,
	SangBiao,
	Robot,
	Zombie
}

enum EEnemyType
{
	None,
	Grey,
	Green,
	Red,
	Blue,
	BlackOne,
	BlackTwo,
	BlackThree,
	BlackFour,
	BlackFive
}

enum EHpType
{
	Blue,
	Red
}

enum EPlatformAssemblyType
{
	# Long Long None None
	L_L_N_N,
	# Short Long Left None
	S_L_L_N,
	# Short Long Right None
	S_L_R_N,
	# Long Short None Left
	L_S_N_L,
	L_S_N_R,
	S_S_L_L,
	S_S_R_R,
	S_S_L_R,
	S_S_R_L,
	S_N_L_N,
	S_N_R_N,
	N_S_N_L,
	N_S_N_R,
	L_N_N_N,
	N_L_N_N,
	N_N_N_N
}
