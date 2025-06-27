extends CharacterBody2D

var dialogo = false
var enemy_attack_range = false
var enemy_attack_cooldown = true
var health = 200
var player_alive = true
var attack_ip = false

var speed = global.player_speed
var curr_dir = "none"
var input_dir = Vector2.ZERO
var joystick = false


func _ready() -> void:
	$AnimatedSprite2D.play("front_idle")
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("sair"):
		print("Ação 'sair' detectada pelo _input!") # Adicione um print para ter certeza
		global.changeSceneMenu()
func setSpeed(velocity : int):
	speed = velocity;

func setDefaultSpeed():
	speed = global.player_speed_default;
	
func _physics_process(delta):
	player_movement()
	
	

func desabilitaMovimentoDuranteDialogo():
	velocity = Vector2.ZERO
	play_anim(0)
	move_and_slide()

func seMoveQuandoPressionaTeclas():
	var direita = Input.is_action_pressed("ui_right") || Input.is_action_pressed("direita")
	var esquerda = Input.is_action_pressed("ui_left") || Input.is_action_pressed("esquerda")
	var baixo = Input.is_action_pressed("ui_down") || Input.is_action_pressed("baixo")
	var cima = Input.is_action_pressed("ui_up") || Input.is_action_pressed("cima")
	
	input_dir = Vector2.ZERO
	if !(direita || esquerda || baixo || cima):
		return
	
	if direita:
		input_dir.x += 1
	if esquerda:
		input_dir.x -= 1
	if baixo:
		input_dir.y += 1
	if cima:
		input_dir.y -= 1
	input_dir = input_dir.normalized()
	
	direita = false
	esquerda = false
	baixo = false
	cima = false
	
func player_movement():
	if dialogo:
		desabilitaMovimentoDuranteDialogo()
		return
	if !joystick:
		seMoveQuandoPressionaTeclas()
	
	if input_dir.length() > 0:
		if input_dir.x > 0:
			curr_dir = "right"
		elif input_dir.x < 0:
			curr_dir = "left"
		elif input_dir.y > 0:
			curr_dir = "down"
		elif input_dir.y < 0:
			curr_dir = "up"

		play_anim(1)
		velocity = input_dir * speed
	else:
		play_anim(0)
		velocity = Vector2.ZERO
	
	move_and_slide()

func player_stop_dialogue(value: bool):
	dialogo = value

func play_anim(movement):
	var dir = curr_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0 and not attack_ip:
			anim.play("side_idle")
	
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0 and not attack_ip:
			anim.play("side_idle")
			
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0 and not attack_ip:
			anim.play("front_idle")
			
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0 and not attack_ip:
			anim.play("back_idle")

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_attack_range = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_attack_range = false

func enemy_attack():
	if enemy_attack_range and enemy_attack_cooldown:
		health -= 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print("player health = ", health)

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	var dir = curr_dir
	
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true
		
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
		elif dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
		elif dir == "down":
			$AnimatedSprite2D.play("front_attack")
		elif dir == "up":
			$AnimatedSprite2D.play("back_attack")

		$deal_attack_timer.start()

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false

func _on_virtual_joystick_analogic_change(move: Vector2) -> void:
	joystick = move != Vector2.ZERO
	input_dir = move
