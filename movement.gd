extends CharacterBody2D

@export var speed = 200  # Ajusté la velocidad a un valor más estándar
var is_jumping = false  # Variable para saber si está saltando

@onready var anim_player = $AnimationPlayer
@onready var sprite = $Sprite2D

func _process(delta: float):
	var vector = Vector2.ZERO

	# Configurar velocidad de animación base
	

	# Movimiento horizontal
	if Input.is_action_pressed("right"):
		vector.x += 1
	if Input.is_action_pressed("left"):
		vector.x -= 1

	# Movimiento vertical
	if Input.is_action_pressed("up"):
		vector.y -= 1
	if Input.is_action_pressed("down"):
		vector.y += 1

	# Si se presiona "jump" y no está ya en salto
	if Input.is_action_just_pressed("jump") and not is_jumping:
		is_jumping = true
		anim_player.speed_scale = 1
		anim_player.play("jump")
		await anim_player.animation_finished  # Espera a que termine la animación
		is_jumping = false

	# Cambiar a la animación de caminar si no está saltando
	if vector != Vector2.ZERO and not is_jumping:
		anim_player.speed_scale = 3
		anim_player.play("walk")

	# Si no hay input y no está saltando, detener animación
	if vector == Vector2.ZERO and not is_jumping:
		anim_player.stop()

	# Voltear sprite según la dirección
	if vector.x != 0:
		sprite.scale.x = -1 if vector.x < 0 else 1

	# Normalizar vector y aplicar velocidad
	if vector != Vector2.ZERO:
		vector = vector.normalized()
	velocity = vector * speed
	move_and_slide()
