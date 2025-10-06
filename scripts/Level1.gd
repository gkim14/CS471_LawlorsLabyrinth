extends Node2D

@onready var pause_menu = $UI/PauseMenu

func _ready():
	pause_menu.visible = false
	
	pause_menu.resume_game.connect(_on_resume)
	pause_menu.open_tutorial.connect(_on_open_tutorial)
	pause_menu.restart_game.connect(_on_restart)
	pause_menu.exit_to_start.connect(_on_exit_to_start)
	
func _show_tutorial():
	var tutorial = preload("res://scenes/TutorialWindow.tscn").instantiate()
	if get_tree().current_scene.has_node("UI"):
		get_tree().current_scene.get_node("UI").add_child(tutorial)
	else:
		get_tree().current_scene.add_child(tutorial)
	
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
	
func _on_open_tutorial():
	_show_tutorial()
	
func _on_restart():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_exit_to_start():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/StartScreen.tscn")
