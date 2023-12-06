extends CharacterBody2D

@onready var anim = $AnimatedSprite2D as AnimatedSprite2D
@onready var ray = $RayCast2D as RayCast2D

@export var direction := -1
var SPEED = 4000

func _ready():
	ray.set_scale(Vector2(direction, direction))
	
func _process(delta):
	
	pass
	
func _physics_process(delta):
	velocity.x = direction * delta * SPEED
	velocity.y = 900 * delta
	
	if ray.is_colliding():
		direction *= -1
		ray.set_scale(Vector2(direction, direction))
		
	if direction > 0:
		anim.flip_h = true
	else:
		anim.flip_h = false
		
	move_and_slide()


func _on_hurt_box_body_entered(body):
	if body.is_in_group("Player"):
		body.velocity.y = -300
		$HurtBox.queue_free()
		anim.play("squish")
		$Timer.start()
		SPEED = 0

func _on_timer_timeout():
	self.queue_free()
