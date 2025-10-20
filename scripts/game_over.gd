extends Control

@onready var score_label = $CenterContainer/VBoxContainer/Score
@onready var reset_button = $CenterContainer/VBoxContainer/ResetButton
@onready var exit_button = $CenterContainer/VBoxContainer/ExitButton

func _ready():
	SoundManager.play_sfx("ui_game_over")
	SoundManager.stop_looping_sfx("player_move")
	SoundManager.stop_sounds()
	SoundManager.stop_music(true)
	
	if (Global.curr_score) == 1:
		score_label.text = "Score: " + str(Global.curr_score) + " level\n"
	else:
		score_label.text = "Score: " + str(Global.curr_score) + " levels\n"
	get_window().content_scale_size = Vector2i(10*64,11*64)
	reset_button.grab_focus()
	
	reset_button.pressed.connect(on_reset)
	exit_button.pressed.connect(on_exit_to_start)
	
	for button in $CenterContainer/VBoxContainer.get_children():
		if button is Button:
			button.focus_entered.connect(func(): SoundManager.play_sfx("ui_hover"))
			button.mouse_entered.connect(func(): SoundManager.play_sfx("ui_hover"))
			button.pressed.connect(func(): SoundManager.play_sfx("ui_press"))

func on_reset():
	SoundManager.play_sfx("ui_start")
	SoundManager.stop_looping_sfx("player_move")
	SoundManager.stop_sounds()
	await get_tree().create_timer(0.15).timeout
	
	get_tree().paused = false
	Global.game_over = false
	Global.new_level = true
	Global.level_count = 1
	Global.curr_score = 0
	Global.maze_size = 10
	
	await TransitionManager.reload_scene_fade()

func on_exit_to_start():
	SoundManager.play_sfx("ui_start")
	SoundManager.stop_sounds()
	SoundManager.stop_music(true)
	await get_tree().create_timer(0.15).timeout
	
	get_tree().paused = false
	Global.game_over = false
	
	await TransitionManager.change_scene_fade("res://scenes/StartScreen.tscn")
