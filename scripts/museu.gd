extends Node2D


func aoSairMuseu(body: Node2D) -> void:
	if body.has_method("player"):
		global.changeSceneWorld()	
