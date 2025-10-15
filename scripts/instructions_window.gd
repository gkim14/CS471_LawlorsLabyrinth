extends Control

@onready var close_button = $CenterContainer/Panel/VBoxContainer/CloseButton

func _ready():
	close_button.pressed.connect(on_close)
	
func on_close():
	queue_free()
