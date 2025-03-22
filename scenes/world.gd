extends Node2D

func _ready(): 
	pass
	
func _process(delta:float): 
	change_scene()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transaction_scene = true	

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		global.transaction_scene = false	

func change_scene():
	if global.transaction_scene == true:
		if global.current_scene == "world":
			global.player_speed = 300
			get_tree().change_scene_to_file("res://scenes/museu.tscn")
		if global.current_scene == "museu":
			global.player_speed = global.player_speed_default
			get_tree().change_scene_to_file("res://scenes/world.tscn")
		global.finish_changescenes()
