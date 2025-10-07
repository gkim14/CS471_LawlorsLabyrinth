extends Control

@onready var play_button = $CenterContainer/VBoxContainer/PlayButton
@onready var tutorial_button = $CenterContainer/VBoxContainer/TutorialButton
@onready var quit_button = $CenterContainer/VBoxContainer/QuitButton

func _ready():
	play_button.pressed.connect(_on_play_pressed)
	tutorial_button.pressed.connect(_on_tutorial_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
	
func _on_tutorial_pressed():
	var tutorial = preload("res://scenes/TutorialWindow.tscn").instantiate()
	get_tree().root.add_child(tutorial)
	
func _on_quit_pressed():
	get_tree().quit()
