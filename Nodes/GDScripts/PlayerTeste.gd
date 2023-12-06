extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	
	velocity.x = direction * SPEED
	
	if not is_on_floor():
		velocity.y += gravity * delta
		if Input.is_action_just_released("ui_up") and velocity.y < 0:
			velocity.y = 0
	
	if Input.get_action_strength("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	move_and_slide()

func _on_hurt_box_body_entered(body):
	if body.is_in_group("Enemy"):
		print("Entrou")
	pass # Replace with function body.
