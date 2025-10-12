extends Control

@onready var play_button = $CenterContainer/VBoxContainer/PlayButton
@onready var instructions_button = $CenterContainer/VBoxContainer/InstructionsButton
@onready var quit_button = $CenterContainer/VBoxContainer/QuitButton

func _ready():
	play_button.pressed.connect(_on_play_pressed)
	instructions_button.pressed.connect(_on_instructions_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
func _on_play_pressed():
	Global.game_over = false
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
	
func _on_instructions_pressed():
	var instructions = preload("res://scenes/InstructionsWindow.tscn").instantiate()
	get_tree().root.add_child(instructions)
	
func _on_quit_pressed():
	get_tree().quit()
