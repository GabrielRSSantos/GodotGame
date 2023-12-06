extends CharacterBody2D

func _physics_process(delta):
	var look = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * 90
#
	print(look)
	rotation_degrees = look.x
	
	move_and_slide()
