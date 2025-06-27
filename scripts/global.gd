extends Node

var player_current_attack = false

var next_scene = "world"
var transaction_scene = false
var player_speed_default = 100
var player_speed = player_speed_default
var player_position_default_x = 22.0
var player_position_default_y = 71.0
var player_position_x = player_position_default_x
var player_position_y = player_position_default_y

var player_exit_museu_posx = 410
var player_exit_museu_posy = 540
var player_enter_portico_posx = 467.0
var player_enter_portico_posy = 83.0
var player_enter_cidade_posx = 565
var player_enter_cidade_posy = 1135
var player_exit_portico_posx = 313.0
var player_exit_portico_posy = 619.0
var player_exit_cidade_posx = 983.0
var player_exit_cidade_posy = 229.0
var player_exit_gremio_posx = 420.0
var player_exit_gremio_posy = 860.0
var player_exit_museuaberto_posx = 700.0

var player_start_posx = 22
var player_start_posy = 71

var permissao_museu = false

func _process(delta:float):
	change_scene()

func change_scene():
	if transaction_scene:
		match next_scene:
			"world":
				mudar_scena("world")
			"museu":
				mudar_scena("museu")
			"portico":
				mudar_scena("portico")
			"cidade":
				mudar_scena("world_2")
			"gremio":
				mudar_scena("gremio_pb")
			"museu aberto":
				mudar_scena("museu_aberto")
			"menu":
				mudar_scena("menu_screen")
		finish_changescenes()

func finish_changescenes():
	if transaction_scene == true:
		transaction_scene = false

func mudar_scena(scena:String):
	get_tree().change_scene_to_file("res://scenes/" + scena + ".tscn")

func changeSceneMuseu():
	transaction_scene = true
	next_scene = "museu"

func changeSceneWorld():
	next_scene = "world"
	player_position_x = player_exit_museu_posx
	player_position_y = player_exit_museu_posy
	transaction_scene = true

func changeSceneWorldPortico():
	next_scene = "world"
	player_position_x = player_exit_portico_posx
	player_position_y = player_exit_portico_posy
	transaction_scene = true

func changeScenePortico():
	next_scene = "portico"
	player_position_x = player_enter_portico_posx
	player_position_y = player_enter_portico_posy
	transaction_scene = true

func changeSceneCidade():
	player_position_x =player_enter_cidade_posx
	player_position_y = player_enter_cidade_posy
	next_scene = "cidade"
	transaction_scene = true

func changeScenePorticoCidade():
	next_scene = "portico"
	player_position_x = player_exit_cidade_posx
	player_position_y = player_exit_cidade_posy
	transaction_scene = true

func changeSceneGremio():
	next_scene = "gremio"
	transaction_scene = true

func changeSceneWorldFromGremio():
	next_scene = "cidade"
	player_position_x = player_exit_gremio_posx
	player_position_y = player_exit_gremio_posy
	transaction_scene = true

func changeSceneMuseuAberto():
	next_scene = "museu aberto"
	transaction_scene = true

func changeSceneWorldFromMuseuAberto():
	next_scene = "cidade"
	player_position_x = player_exit_museuaberto_posx
	player_position_y = player_exit_gremio_posy
	transaction_scene = true
	
func changeSceneMenu():
	get_tree().change_scene_to_file("res://menu_screen.tscn")
	
