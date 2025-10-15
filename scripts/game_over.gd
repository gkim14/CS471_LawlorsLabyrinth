extends Control

@onready var score_label = $CenterContainer/VBoxContainer/Score
@onready var reset_button = $CenterContainer/VBoxContainer/ResetButton
@onready var exit_button = $CenterContainer/VBoxContainer/ExitButton

func _ready():
	if (Global.curr_score) == 1:
		score_label.text = "Score: " + str(Global.curr_score) + " level\n"
	else:
		score_label.text = "Score: " + str(Global.curr_score) + " levels\n"
		
	reset_button.pressed.connect(on_reset)
	exit_button.pressed.connect(on_exit_to_start)
	
func on_reset():
	get_tree().paused = false
	Global.game_over = false
	Global.new_level = true
	Global.level_count = 1
	Global.curr_score = 0
	Global.maze_size = 15
	get_tree().reload_current_scene()
	
func on_exit_to_start():
	get_tree().paused = false
	Global.game_over = false
	get_tree().change_scene_to_file("res://scenes/StartScreen.tscn")
