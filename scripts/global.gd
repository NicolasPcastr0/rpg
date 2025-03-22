extends Node

var player_current_attack = false

var current_scene = "world"
var transaction_scene = false
var player_speed_default = 100
var player_speed = player_speed_default
var player_exit_museu_posx = 0
var player_exit_museu_posy = 0
var player_start_posx = 0
var player_start_posy = 0

func finish_changescenes():
	if transaction_scene == true:
		transaction_scene = false
		if current_scene == "world":
			current_scene == "museu"
		else:
			current_scene == "world"
