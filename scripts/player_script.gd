extends CharacterBody2D

var speed = 400
var rotation_speed = 10

func _physics_process(_delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

	move_and_slide()
