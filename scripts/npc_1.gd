extends CharacterBody2D

func _ready() -> void:
	$AnimatedSprite2D.play("front_idle")

func npc_colision(body: Node2D) -> void:
	if body.has_method("player"):
		dialogo.initDialogSeuValdomiro()

func portico_colision(body: Node2D) -> void:
	if body.has_method("player"):
		global.changeSceneCidade()
	pass
