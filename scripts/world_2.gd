extends Node2D

func _ready() -> void:
	$player/Camera2D.limit_bottom = 1200
	$player/Camera2D.limit_top = -800
	$player/Camera2D.limit_right = 1800
	$player/Camera2D.limit_left = -1800
	$player.position.y = global.player_position_y
	$player.position.x = global.player_position_x

func sair_da_cidade(body: Node2D) -> void:
	if body.has_method("player"):
		global.changeScenePorticoCidade()
			
func entrar_gremio(body: Node2D) -> void:
	if body.has_method("player"):
		global.changeSceneGremio()
			
func entrar_museu_aberto(body: Node2D) -> void:
	if body.has_method("player"):
		global.changeSceneMuseuAberto()			
