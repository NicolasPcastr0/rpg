extends Node2D
var resourse
var dialogoGD = load("res://scripts/dialogo.gd")
var dialogo = dialogoGD.new();
func _ready(): 
	addFuncaoQuandoFecharODialogo()
	definePosicaoJogadorAoSairDoMuseu()
	$dialogue

func addFuncaoQuandoFecharODialogo():
	DialogueManager.connect("dialogue_ended", Callable(self, "_on_dialogue_finished"))

func definePosicaoJogadorAoSairDoMuseu():
	if global.game_first_loding:
		$player.position.y = global.player_start_posy
		$player.position.x = global.player_start_posx
	else:
		$player.position.y = global.player_exit_museu_posy
		$player.position.x = global.player_exit_museu_posx
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	if isPlayer(body):
		global.transaction_scene = false

func _on_dialogue_finished(resourse):
	$player.player_stop_dialogue(false)

func _dialogue_quixmera(body: Node2D) -> void:
	if isPlayer(body):
		$player.player_stop_dialogue(true)
		dialogo.initDialogQuixmera()

func _dialogue_thalzorn(body: Node2D) -> void:
	if isPlayer(body):
		$player.player_stop_dialogue(true)
		dialogo.initDialogThalzorn()

func _dialogue_vlyssara(body: Node2D) -> void:
	if isPlayer(body):
		$player.player_stop_dialogue(true)
		dialogo.initDialogVlyssara()

func _dialogue_zorvax(body: Node2D) -> void:
	if isPlayer(body):
		$player.player_stop_dialogue(true)
		dialogo.initDialogZorvax()

func _dialogue_guardiao(body: Node2D) -> void:
	if isPlayer(body):
		$player.player_stop_dialogue(true)
		dialogo.initDialogGuardiao()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if isPlayer(body):
		if (!global.permissao_museu):
			$player.player_stop_dialogue(true)
			dialogo.initDialogSemPermissaoAcessoMuseu()
		elif global.permissao_museu:
			global.changeSceneMuseu()

func isPlayer(body: Node2D):
	return body.has_method("player")
