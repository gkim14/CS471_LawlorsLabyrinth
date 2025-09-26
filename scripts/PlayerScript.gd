extends CharacterBody2D

var speed = 400

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(_delta):
	get_input()
	move_and_slide()
#var angular_speed = PI
#
#
#func _process(delta):
	#var direction = 0
	#if Input.is_action_pressed("left"):
		#direction = -1
	#if Input.is_action_pressed("right"):
		#direction = 1
#
	#rotation += angular_speed * direction * delta
#
	#var velocity = Vector2.ZERO
	#if Input.is_action_pressed("up"):
		#velocity = Vector2.UP.rotated(rotation) * speed
#
	#position += velocity * delta
