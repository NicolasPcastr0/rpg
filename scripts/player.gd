extends CharacterBody2D

# Variáveis de estado do jogador
var dialogo = false                      # Indica se o jogador está em diálogo
var enemy_attack_range = false          # Indica se o inimigo está perto o suficiente para atacar
var enemy_attack_cooldown = true        # Controla o tempo entre ataques inimigos
var health = 200                        # Vida do jogador
var player_alive = true                 # Estado de vida do jogador
var attack_ip = false                   # Se um ataque do jogador está em progresso

# Variáveis de movimentação
var speed = global.player_speed         # Velocidade do jogador (definida globalmente)
var curr_dir = "none"                   # Direção atual do jogador
var input_dir = Vector2.ZERO            # Vetor de entrada do movimento
var joystick = false



func _ready() -> void:
	$AnimatedSprite2D.play("front_idle")  # Animação inicial
	
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
	
	# Se houver entrada de direção, define a direção atual
	if input_dir.length() > 0:
		if input_dir.x > 0:
			curr_dir = "right"
		elif input_dir.x < 0:
			curr_dir = "left"
		elif input_dir.y > 0:
			curr_dir = "down"
		elif input_dir.y < 0:
			curr_dir = "up"

		play_anim(1)                         # Animação de caminhada
		velocity = input_dir * speed         # Define velocidade com base na direção
	else:
		play_anim(0)                         # Animação de idle
		velocity = Vector2.ZERO              # Para o movimento
	
	move_and_slide()                        # Aplica o movimento

# Função para ativar/desativar o modo de diálogo
func player_stop_dialogue(value: bool):
	dialogo = value

# Função para trocar animações com base no movimento e direção
func play_anim(movement):
	var dir = curr_dir
	var anim = $AnimatedSprite2D
	
	# Lógica para animações dependendo da direção
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

# Placeholder vazio
func player():
	pass

# Quando um corpo entra na hitbox do jogador
func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_attack_range = true     # Ativa a possibilidade de ataque inimigo

# Quando um corpo sai da hitbox do jogador
func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_attack_range = false    # Desativa a possibilidade de ataque inimigo

# Função para aplicar dano ao jogador se estiver em alcance de ataque inimigo
func enemy_attack():
	if enemy_attack_range and enemy_attack_cooldown:
		health -= 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()  # Inicia temporizador de cooldown de ataque inimigo
		print("player health = ", health)

# Reseta o cooldown do ataque inimigo
func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

# Lógica de ataque do jogador
func attack():
	var dir = curr_dir
	
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true
		
		# Seleciona a animação de ataque conforme a direção
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

		$deal_attack_timer.start()   # Inicia temporizador para fim do ataque

# Função chamada quando o ataque do jogador termina
func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false

# Recebe o movimento do joystick virtual
func _on_virtual_joystick_analogic_change(move: Vector2) -> void:
	joystick = move != Vector2.ZERO
	input_dir = move
