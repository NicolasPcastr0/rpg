extends CharacterBody2D

var enemy_attack_range = false
var enemy_attack_cooldown = true
var health = 200
var player_alive = true

var attack_ip = false

var speed = global.player_speed
var curr_dir = "none"
var input_dir = Vector2.ZERO;

func _ready() -> void:
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	#input_dir = Input.get_vector("ui_right", "ui_left", "ui_down", "ui_up")
	player_movement()
	enemy_attack()
	attack()
	
	if health <= 0:
		player_alive = false #volta para o menu
		health = 0
		print("jogador foi morto")
		self.queue_free()
	
func player_movement():
	if input_dir.length() > 0:  # Apenas move se houver entrada
		if input_dir.x > 0:
			curr_dir = "right"
		elif input_dir.x < 0:
			curr_dir = "left"
		elif input_dir.y > 0:
			curr_dir = "down"
		elif input_dir.y < 0:
			curr_dir = "up"

		play_anim(1)  # Toca animação de movimento
		velocity = input_dir * speed  # Move na direção desejada com a velocidade definida
	else:
		play_anim(0)  # Animação de idle
		velocity = Vector2.ZERO  # Para o movimento
	
	move_and_slide()

func play_anim(movement):
	var dir = curr_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_idle")
	
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_idle")
			
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("front_idle")
			
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			if attack_ip == false:
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
	if enemy_attack_range and enemy_attack_cooldown == true:
		health = health - 20
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
			$deal_attack_timer.start()
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		if dir == "down":
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()
		if dir == "up":
			$AnimatedSprite2D.play("back_attack")
			$deal_attack_timer.start()
	


func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false


func _on_virtual_joystick_analogic_change(move: Vector2) -> void:
	input_dir = move
	print(move)
