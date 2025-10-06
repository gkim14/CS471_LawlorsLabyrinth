extends Control

@onready var close_button = $CenterContainer/Panel/VBoxContainer/CloseButton

func _ready():
	close_button.pressed.connect(_on_close_pressed)
	
func _on_close_pressed():
	queue_free()
