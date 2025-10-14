extends CharacterBody2D

@onready var layer: TileMapLayer = get_parent().get_parent().get_node("TileMapLayer")
@onready var agent: NavigationAgent2D = $NavigationAgent2D
var target
var SPEED = 410

func _ready() -> void:
	@warning_ignore("integer_division")
	SPEED += ((Global.level_count/5)*5)
	set_physics_process(false)
	call_deferred("wait")
	
func wait():
	await get_tree().physics_frame
	set_physics_process(true)
	
func _physics_process(_delta: float) -> void:
	#if agent.is_navigation_finished():
	#	return
	target = layer.get_child(0)
	agent.target_position = target.global_position
	velocity = global_position.direction_to(agent.get_next_path_position()) * SPEED
	move_and_slide()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_handle_game_over()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_handle_game_over()
		
func _handle_game_over():
	Global.game_over = true	
	get_tree().paused = true
	
	var game_over = preload("res://scenes/GameOver.tscn").instantiate()
	if get_tree().current_scene.has_node("UI"):
		get_tree().current_scene.get_node("UI").add_child(game_over)
	else:
		get_tree().current_scene.add_child(game_over)
