extends Node2D

func _ready() -> void:
	$player/Camera2D.limit_bottom = 1200
	$player/Camera2D.limit_top = -800
	$player/Camera2D.limit_right = 1800
	$player/Camera2D.limit_left = -1800
	

func sair_da_cidade(body: Node2D) -> void:
	global.changeScenePorticoCidade()
	pass # Replace with function body.
