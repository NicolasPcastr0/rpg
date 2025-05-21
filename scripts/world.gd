extends Node2D

func _ready(): 
	if global.game_first_loding == true:
		$player.position.y = global.player_start_posy
		$player.position.x = global.player_start_posx
	else:
		$player.position.y = global.player_exit_museu_posy
		$player.position.x = global.player_exit_museu_posx
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transaction_scene = true	

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		global.transaction_scene = false	



func _on_area_2d_2_body_entered_dialog(body: Node2D) -> void:
	if body.has_method("player"):
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dialogue.dialogue"), "start")


func _on_area_2d_2_body_exited_dialog(body: Node2D) -> void:
	pass
