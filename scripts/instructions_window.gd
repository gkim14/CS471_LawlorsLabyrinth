extends Control

signal closed

@onready var close_button = $CenterContainer/Panel/VBoxContainer/CloseButton

func _ready():
	close_button.grab_focus()
	close_button.pressed.connect(on_close)

func on_close():
	await TransitionManager.fade_out_ui(self, 0.1)
	emit_signal("closed")
	queue_free()
