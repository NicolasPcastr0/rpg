extends Node2D
var resourse
func _ready(): 
	addFuncaoQuandoFecharODialogo()
	definePosicaoJogadorAoSairDoMuseu()

func addFuncaoQuandoFecharODialogo():
	DialogueManager.connect("dialogue_ended", Callable(self, "_on_dialogue_finished"))

func definePosicaoJogadorAoSairDoMuseu():
	$player.position.y = global.player_position_y
	$player.position.x = global.player_position_x
	
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

func entrar_cena_portico(body: Node2D) -> void:
	if isPlayer(body):
		global.changeScenePortico()
	pass
