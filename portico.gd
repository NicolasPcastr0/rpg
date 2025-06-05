extends Node2D

func _ready() -> void:
	$player.position.y = global.player_position_y
	$player.position.x = global.player_position_x

func sair_portico(body: Node2D) -> void:
	if(body.has_method("player")):
		global.changeSceneWorldPortico()
	pass
