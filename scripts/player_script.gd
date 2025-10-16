extends CharacterBody2D

var speed = 405
var rotation_speed = 10

@onready var _animated_sprite = $Sprite2D

func _process(_delta: float) -> void:
	if (Input.is_action_pressed("right") or 
			Input.is_action_pressed("left")):
		_animated_sprite.flip_v = false
		_animated_sprite.play("LeftRight")
		if Input.is_action_pressed("left"): 
			_animated_sprite.flip_h = true
		else:
			_animated_sprite.flip_h = false
	elif (Input.is_action_pressed("up") or 
			Input.is_action_pressed("down")):
		_animated_sprite.play("UpDown")
		if Input.is_action_pressed("up"): 
			_animated_sprite.flip_v = true
		else:
			_animated_sprite.flip_v = false

func _physics_process(_delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

	move_and_slide()
