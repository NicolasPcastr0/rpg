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

var game_first_loding = true

func finish_changescenes():
	if transaction_scene == true:
		if current_scene == "world":
			current_scene == "museu"
		elif current_scene == "museu":
			current_scene == "world"
		transaction_scene = false
			
func _process(delta:float): 
	change_scene()

func change_scene():
	if transaction_scene == true:
		if current_scene == "world":
			get_tree().change_scene_to_file("res://scenes/museu.tscn")
			current_scene = "museu"
		elif current_scene == "museu":
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			current_scene = "world"
			global.game_first_loding = false
			
		finish_changescenes()
