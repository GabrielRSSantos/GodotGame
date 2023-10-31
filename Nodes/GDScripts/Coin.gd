extends Area2D

@onready var coin_anim = $AnimatedSprite2D

func _on_body_entered(body):
	coin_anim.play("Collected")
	$AudioStreamPlayer2D.play()
	$CoinCollision.queue_free()

func _on_animated_sprite_2d_animation_finished():
	queue_free()
