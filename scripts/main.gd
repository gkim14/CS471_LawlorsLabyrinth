extends Node2D

@onready var pause_menu = $UI/PauseMenu
@onready var level = $UI/LevelName
@onready var addon = $MazeAddon

func _ready():
	if Global.game_over:
		_on_exit_to_start()
	pause_menu.visible = false
	level.text = "Level " + str(Global.level_count)
	pause_menu.resume_game.connect(_on_resume)
	pause_menu.open_instructions.connect(_on_open_instructions)
	pause_menu.restart_game.connect(_on_restart)
	pause_menu.exit_to_start.connect(_on_exit_to_start)
	
func _show_instructions():
	var instructions = preload("res://scenes/InstructionsWindow.tscn").instantiate()
	if get_tree().current_scene.has_node("UI"):
		get_tree().current_scene.get_node("UI").add_child(instructions)
	else:
		get_tree().current_scene.add_child(instructions)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_toggle_pause()
		
func _toggle_pause():
	var paused := not get_tree().paused
	get_tree().paused = paused
	pause_menu.visible = paused
	
func _on_resume():
	get_tree().paused = false
	pause_menu.visible = false
	
func _on_open_instructions():
	_show_instructions()
	
func _on_restart():
	get_tree().paused = false
	Global.new_level = false
	pause_menu.visible = false
	var current_node = get_tree().current_scene.get_node("MazeAddon")
	var new_node = preload("res://scenes/MazeAddon.tscn").instantiate()
	get_tree().current_scene.remove_child(current_node)
	get_tree().current_scene.add_child(new_node)
	
func _on_exit_to_start():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/StartScreen.tscn")
