extends CharacterBody2D

var speed = 400
var rotation_speed = 10

func _physics_process(_delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	var target_angle = Vector2.UP.angle_to(velocity)
	
	if velocity.length() > 0:
		rotation = lerp_angle(rotation, target_angle, _delta*rotation_speed)
		
	move_and_slide()
