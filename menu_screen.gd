extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_bnt_pressed() -> void:
	$music_main.stop()
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	


func _on_diff_btn_pressed() -> void:
	pass # Replace with function body.


func _on_sair_btn_pressed() -> void:
	get_tree().quit()
