extends Control

signal resume_game
signal open_tutorial
signal restart_game
signal exit_to_start

@onready var resume_button = $CenterContainer/VBoxContainer/ResumeButton
@onready var tutorial_button = $CenterContainer/VBoxContainer/TutorialButton
@onready var restart_button = $CenterContainer/VBoxContainer/RestartButton
@onready var exit_button = $CenterContainer/VBoxContainer/ExitButton

func _ready():
	resume_button.pressed.connect(func(): emit_signal("resume_game"))
	tutorial_button.pressed.connect(func(): emit_signal("open_tutorial"))
	restart_button.pressed.connect(func(): emit_signal("restart_game"))
	exit_button.pressed.connect(func(): emit_signal("exit_to_start"))
	
