extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const AIR_FRICTION := 0.5

@export var jump_height := 64
@export var max_time_to_peak := 0.5

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var gravity2
var jump_velocity
var fall_gravity

func _ready():
	jump_velocity = (jump_height * 2) / max_time_to_peak
	gravity = (jump_height *2) / pow(max_time_to_peak, 2)
	fall_gravity = gravity * 2

func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = 0
	
	velocity.x = lerp( velocity.x, direction * SPEED, AIR_FRICTION)
	
	if not is_on_floor():
		if Input.is_action_just_released("ui_up") and velocity.y < 0:
			velocity.y = 0
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = -jump_velocity
		print(velocity.y)
	
	if velocity.y > 0 or not Input.is_action_just_pressed("ui_up"):
		velocity.y += fall_gravity * delta
	else:
		velocity.y += gravity * delta

	move_and_slide()

func _on_hurt_box_body_entered(body):
	if body.is_in_group("Enemy"):
		print("Entrou")
	pass # Replace with function body.
