extends Control

@onready var best_score = $CenterContainer/VBoxContainer/Score
@onready var play_button = $CenterContainer/VBoxContainer/PlayButton
@onready var instructions_button = $CenterContainer/VBoxContainer/InstructionsButton
@onready var quit_button = $CenterContainer/VBoxContainer/QuitButton

func _ready():
	if Global.best_score == 1:
		best_score.text = "Best Score: " + str(Global.best_score) + " level\n"
	else:
		best_score.text = "Best Score: " + str(Global.best_score) + " levels\n"
	get_window().content_scale_size = Vector2i((Global.maze_size)*64,(Global.maze_size+1)*64)
	play_button.pressed.connect(_on_play)
	instructions_button.pressed.connect(_on_instructions)
	quit_button.pressed.connect(_on_quit)
	
func _on_play():
	Global.game_over = false
	Global.new_level = true
	Global.level_count = 1
	Global.curr_score = 0
	Global.maze_size = 15
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
	
func _on_instructions():
	var instructions = preload("res://scenes/InstructionsWindow.tscn").instantiate()
	get_tree().root.add_child(instructions)
	
func _on_quit():
	get_tree().quit()
