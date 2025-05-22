extends Node2D
#serve para a parada do dialogo
var resourse
func _ready(): 
	# Conecta o sinal de fim de diálogo à função local
	DialogueManager.connect("dialogue_ended", Callable(self, "_on_dialogue_finished"))
	

	# Define a posição inicial do jogador com base na flag de carregamento
	if global.game_first_loding:
		$player.position.y = global.player_start_posy
		$player.position.x = global.player_start_posx
	else:
		$player.position.y = global.player_exit_museu_posy
		$player.position.x = global.player_exit_museu_posx

# Área de transição de cena
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transaction_scene = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		global.transaction_scene = false

# Início do diálogo ao entrar na área
func _on_area_2d_2_body_entered_dialog(body: Node2D) -> void:
	if body.has_method("player"):
		$player.player_stop_dialogue(true)
		DialogueManager.show_example_dialogue_balloon(
			load("res://dialogue/dialogue.dialogue"), "start"
		)

# Outro NPC com outro diálogo
func on_npc2(body: Node2D) -> void:
	if body.has_method("player"):
		$player.player_stop_dialogue(true)
		DialogueManager.show_example_dialogue_balloon(
			load("res://dialogue/dialogue2.dialogue"), "start"
		)

# Quando o diálogo termina
func _on_dialogue_finished(resourse):
	$player.player_stop_dialogue(false)

# Placeholder, caso precise usar mais tarde
func _on_area_2d_2_body_exited_dialog(body: Node2D) -> void:
	pass
