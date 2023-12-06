extends CharacterBody2D

@onready var camera = $Camera2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var score = $UI/Score

@export var joystick_left : VirtualJoystick
@onready var analogico = $Analogico/Analogico_left
@onready var rotacao = $Mira

@export var numeroRotation = 0
var gravity = 980
var JUMP_VELOCITY = -400
var speed = 100

func _ready():
	match GameManager.Players[self.name.to_int()].control:
		GameManager.Controller.ANALOGICO:
			$Analogico.set_visible(true)
			analogico.use_input_actions = true
		GameManager.Controller.DIRECIONAL:
			$Direcional.set_visible(true)

	if not is_multiplayer_authority():
		camera.enabled = false

func _process(_delta):
	if is_multiplayer_authority():
		score.text = "Score: " + str(GameManager.Players[self.name.to_int()].score)
		pass
	pass

func _physics_process(_delta):
	if is_multiplayer_authority():
		match GameManager.Players[self.name.to_int()].control:
			GameManager.Controller.ANALOGICO:
				movimentoAnalogico()
			GameManager.Controller.DIRECIONAL:
				movimentoDirecional(_delta)
	move_and_slide()
	
func movimentoDirecional(delta):
	var direction = Input.get_axis("ui_left", "ui_right")

	velocity.x = direction * speed
	
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if Input.is_action_just_released("ui_up") and velocity.y < 0:
			velocity.y = 0
	
	if velocity.y != 0:
		if !check_int(velocity.y):
			print("Velocity 1")
			animated_sprite_2d.play("jump")
		else:
			print("Velocity 2")
			animated_sprite_2d.play("falling")

	if direction:
		animated_sprite_2d.flip_h = !check_int(velocity.x)

	if direction and is_on_floor():
		animated_sprite_2d.play("run")
		velocity.x = direction * speed

	if !direction and is_on_floor():
		animated_sprite_2d.play("idle")
	
func movimentoAnalogico():
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * speed
	var look = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * 90
	
	rotacaoMira(look)
	if velocity.x < 0:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false

	if velocity.x or velocity.y != 0:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")

func _on_collector_area_entered(area):
	for i in area.get_groups():
		if i == "Coin":
			GameManager.Players[self.name.to_int()].score += 1

func teste():
	print(str(get_global_mouse_position()))
	
func rotacaoMira(look):
	print("look y" + str(look.y))
	print("look x" + str(look.x))
	
	if look.y > 0:
		rotacao.rotation_degrees = 90
	if look.y < 0:
		rotacao.rotation_degrees = -90
	if look.x > 0:
		rotacao.rotation_degrees = 0
	if look.x < 0:
		rotacao.rotation_degrees = 180
		
	if look.x > 0 and look.y > 0:
		rotacao.rotation_degrees = 45
	if look.x > 0 and look.y < 0:
		rotacao.rotation_degrees = -45
	if look.x < 0 and look.y > 0:
		rotacao.rotation_degrees = 135
	if look.x < 0 and look.y < 0:
		rotacao.rotation_degrees = 225
	
func check_int(i):
	if i > 0:
		return true
	else:
		return false
