extends Control

signal resume_game
signal open_instructions
signal restart_game
signal exit_to_start

@onready var resume_button = $CenterContainer/VBoxContainer/ResumeButton
@onready var instructions_button = $CenterContainer/VBoxContainer/InstructionsButton
@onready var restart_button = $CenterContainer/VBoxContainer/RestartButton
@onready var exit_button = $CenterContainer/VBoxContainer/ExitButton

func _ready():
	resume_button.pressed.connect(func(): emit_signal("resume_game"))
	instructions_button.pressed.connect(func(): emit_signal("open_instructions"))
	restart_button.pressed.connect(func(): emit_signal("restart_game"))
	exit_button.pressed.connect(func(): emit_signal("exit_to_start"))
