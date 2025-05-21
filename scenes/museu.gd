extends Node2D


func aoSairMuseu(body: Node2D) -> void:
	if body.has_method("player"):
		global.transaction_scene = true	


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		global.transaction_scene = false	
