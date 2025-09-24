extends Sprite2D

var speed = 400
var angular_speed = PI


func _process(delta):
	var direction = 0
	if Input.is_action_pressed("left"):
		direction = -1
	if Input.is_action_pressed("right"):
		direction = 1

	rotation += angular_speed * direction * delta

	var velocity = Vector2.ZERO
	if Input.is_action_pressed("up"):
		velocity = Vector2.UP.rotated(rotation) * speed

	position += velocity * delta
