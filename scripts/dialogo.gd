extends Node
func initDialogGuardiao():
	startDialogNpc("guardiaoXarok")

func initDialogZorvax():
	startDialogNpc("zorvax")

func initDialogVlyssara():
	startDialogNpc("vlyssara")

func initDialogThalzorn():
	startDialogNpc("thalzorn")
	
func initDialogQuixmera():
	startDialogNpc("quixmera")
	
func initDialogSemPermissaoAcessoMuseu():
	startDialog("sem_permissao_museu")

func initDialogSeuValdomiro():
	startDialogNpc("SeuValdomiro")

func startDialogNpc(dialog:String):
	startDialog("npc/" + dialog)
	
func startDialog(dialog:String):
	DialogueManager.show_example_dialogue_balloon(
		load("res://dialogue/" + dialog + ".dialogue"), "start"
	)
