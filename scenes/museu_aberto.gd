extends Node2D
func _ready() -> void:
	$player/Camera2D.limit_bottom = 646
	$player/Camera2D.limit_top = -800
	$player/Camera2D.limit_right = 1000
	$player/Camera2D.zoom = Vector2(1.2,1.2)


func cidade(body: Node2D) -> void:
	if body.has_method("player"):
		global. changeSceneWorldFromMuseuAberto()
