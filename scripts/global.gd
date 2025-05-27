extends Node

var player_current_attack = false

var current_scene = "world"
var transaction_scene = false
var player_speed_default = 100
var player_speed = player_speed_default
var player_exit_museu_posx = 406
var player_exit_museu_posy = 514
var player_start_posx = 22
var player_start_posy = 71

var permissao_museu = false

var game_first_loding = true

func _process(delta:float): 
	change_scene()

func change_scene():
	if transaction_scene:
		if current_scene == "world":
			mudar_scena("museu")
			current_scene = "museu"
		elif current_scene == "museu":
			mudar_scena("world")
			current_scene = "world"
			global.game_first_loding = false
			
		finish_changescenes()

func finish_changescenes():
	if transaction_scene == true:
		transaction_scene = false

func changeSceneMuseu():
	transaction_scene = true
	current_scene = "world"

func changeSceneWorld():
	transaction_scene = true
	current_scene = "museu"

func mudar_scena(scena:String):
	get_tree().change_scene_to_file("res://scenes/" + scena + ".tscn")
	
