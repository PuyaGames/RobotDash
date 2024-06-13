extends StaticBody2D
class_name Platform2D


@export_enum("Long:0", "Short:1") var type : int = 0


func init_platform(map_type : Enums.EMapType) -> void:
	if type == 0:
		if map_type == Enums.EMapType.Halloween:
			pass
		elif map_type == Enums.EMapType.Sweet:
			pass
		elif map_type == Enums.EMapType.Desert:
			pass
	elif type == 1:
		if map_type == Enums.EMapType.Halloween:
			pass
		elif map_type == Enums.EMapType.Sweet:
			pass
		elif map_type == Enums.EMapType.Desert:
			pass
