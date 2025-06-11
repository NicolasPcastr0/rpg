extends Node2D

func _ready() -> void:
	$player/Camera2D.limit_bottom = 646
	$player/Camera2D.limit_top = -800
	$player/Camera2D.limit_right = 1800
	$player/Camera2D.limit_left = -1800
	
func aoSairMuseu(body: Node2D) -> void:
	if body.is_in_group("player"):
		global.changeSceneWorld()
