extends Node2D

signal updated

@onready var pause_menu = $UI/PauseMenu
@onready var level = $UI/LevelName
@onready var score = $UI/Score
@onready var addon = $MazeAddon

func _ready():
	TransitionManager.fade_out(0.5)
	pause_menu.visible = false
	level.text = "Level " + str(Global.level_count)
	if Global.level_count%5 == 0:
		Global.maze_size += 1
	
	emit_signal("updated")
	get_window().content_scale_size = Vector2i((Global.maze_size)*64,(Global.maze_size+1)*64)
	if Global.best_score == 1:
		score.text = "Best score: " + str(Global.best_score) + " level"
	else:
		score.text = "Best score: " + str(Global.best_score) + " levels"
	
	pause_menu.resume_game.connect(on_resume)
	pause_menu.open_instructions.connect(on_instructions)
	pause_menu.restart_game.connect(on_restart)
	pause_menu.exit_to_start.connect(on_exit_to_start)
	
	for button in $UI/PauseMenu/CenterContainer/VBoxContainer.get_children():
		if button is Button:
			button.focus_entered.connect(func(): SoundManager.play_sfx("ui_hover"))
			button.mouse_entered.connect(func(): SoundManager.play_sfx("ui_hover"))
			button.pressed.connect(func(): SoundManager.play_sfx("ui_press"))
	
	if not SoundManager.music_player.playing:
		SoundManager.play_music("background_music", true, true)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	var paused := not get_tree().paused
	get_tree().paused = paused
	
	if paused:
		SoundManager.play_sfx("ui_pause_open")
		SoundManager.stop_looping_sfx("player_move")
		SoundManager.stop_sounds()
		SoundManager.lower_music_volume()
		await TransitionManager.fade_in_ui(pause_menu, 0.1)
		pause_menu.resume_button.grab_focus()

func on_resume():
	SoundManager.play_sfx("ui_pause_close")
	SoundManager.restore_music_volume()
	await TransitionManager.fade_out_ui(pause_menu, 0.1)
	get_tree().paused = false

func on_instructions():
	# Disable menu input while window is active
	for button in $UI/PauseMenu/CenterContainer/VBoxContainer.get_children():
		if button is Button:
			button.disabled = true
	
	var instructions = preload("res://scenes/InstructionsWindow.tscn").instantiate()
	instructions.closed.connect(func(): close_instructions())
	if get_tree().current_scene.has_node("UI"):
		get_tree().current_scene.get_node("UI").add_child(instructions)
	else:
		get_tree().current_scene.add_child(instructions)
	
	await TransitionManager.fade_in_ui(instructions, 0.1)

func close_instructions():
	SoundManager.play_sfx("ui_press")
	
	# Enable menu input when window closes
	for button in $UI/PauseMenu/CenterContainer/VBoxContainer.get_children():
		if button is Button:
			button.disabled = false
	
	pause_menu.instructions_button.grab_focus()

func on_restart():
	SoundManager.play_sfx("ui_pause_close")
	SoundManager.stop_looping_sfx("player_move")
	SoundManager.stop_sounds()
	get_tree().paused = false
	Global.new_level = false
	pause_menu.visible = false
	
	var current_node = get_tree().current_scene.get_node("MazeAddon")
	var new_node = preload("res://scenes/MazeAddon.tscn").instantiate()
	get_tree().current_scene.remove_child(current_node)
	get_tree().current_scene.add_child(new_node)
	
	SoundManager.restore_music_volume()
	emit_signal("updated")

func on_exit_to_start():
	SoundManager.play_sfx("ui_start")
	SoundManager.stop_sounds()
	SoundManager.stop_music(true)
	await get_tree().create_timer(0.15).timeout
	
	get_tree().paused = false
	
	await TransitionManager.change_scene_fade("res://scenes/StartScreen.tscn")
