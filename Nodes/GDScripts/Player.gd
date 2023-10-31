extends CharacterBody2D

@onready var camera = $Camera2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var score = await $UI/Score
@export var joystick_left : VirtualJoystick

var speed = 400

func _ready():
	if not is_multiplayer_authority():
		camera.enabled = false
		
func _process(delta):
	if is_multiplayer_authority():
		score.text = "Score: " + str(GameManager.Players[self.name.to_int()].score)
		velocity.x = Input.get_axis("ui_left", "ui_right")
		velocity.y = Input.get_axis("ui_up", "ui_down")
#		print(velocity)

func _physics_process(_delta):
	if is_multiplayer_authority():
		velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * speed
		move_and_slide()

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
#			print(GameManager.Players[self.name.to_int()].score)
