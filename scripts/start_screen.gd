extends Control

@onready var best_score = $CenterContainer/VBoxContainer/Score
@onready var play_button = $CenterContainer/VBoxContainer/PlayButton
@onready var instructions_button = $CenterContainer/VBoxContainer/InstructionsButton
@onready var quit_button = $CenterContainer/VBoxContainer/QuitButton

func _ready():
	call_deferred("on_ready_deferred")
	
	if Global.best_score == 1:
		best_score.text = "Best Score: " + str(Global.best_score) + " level\n"
	else:
		best_score.text = "Best Score: " + str(Global.best_score) + " levels\n"
	get_window().content_scale_size = Vector2i(10*64,11*64)
	play_button.grab_focus()
	
	play_button.pressed.connect(on_play)
	instructions_button.pressed.connect(on_instructions)
	quit_button.pressed.connect(on_quit)
	
	for button in $CenterContainer/VBoxContainer.get_children():
		if button is Button:
			button.focus_entered.connect(func(): SoundManager.play_sfx("ui_hover"))
			button.mouse_entered.connect(func(): SoundManager.play_sfx("ui_hover"))
			button.pressed.connect(func(): SoundManager.play_sfx("ui_press"))
			
	SoundManager.play_music("title_music", true, true)

func on_ready_deferred():
	await TransitionManager.fade_out(0.5)

func on_play():
	SoundManager.play_sfx("ui_start")
	SoundManager.stop_music(true)
	await get_tree().create_timer(0.15).timeout
	
	Global.game_over = false
	Global.new_level = true
	Global.level_count = 1
	Global.curr_score = 0
	Global.maze_size = 10
	
	await TransitionManager.change_scene_fade("res://scenes/Main.tscn")

func on_instructions():
	# Disable menu input while window is active
	for button in $CenterContainer/VBoxContainer.get_children():
		if button is Button:
			button.disabled = true
	
	var instructions = preload("res://scenes/InstructionsWindow.tscn").instantiate()
	instructions.closed.connect(func(): close_instructions())
	get_tree().root.add_child(instructions)
	
	await TransitionManager.fade_in_ui(instructions, 0.1)

func close_instructions():
	SoundManager.play_sfx("ui_press")
	
	# Enable menu input when window closes
	for button in $CenterContainer/VBoxContainer.get_children():
		if button is Button:
			button.disabled = false
	
	instructions_button.grab_focus()

func on_quit():
	SoundManager.stop_music(true)
	await get_tree().create_timer(0.25).timeout
	get_tree().quit()
