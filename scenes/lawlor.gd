extends CharacterBody2D

@onready var layer: TileMapLayer = get_parent().get_parent().get_node("TileMapLayer")
@onready var agent: NavigationAgent2D = $NavigationAgent2D
var target
const SPEED = 200.0

func _ready() -> void:
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
		Global.game_over = true
		print("game over")
		get_tree().reload_current_scene.call_deferred()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.game_over = true
		print("gameover")
		get_tree().reload_current_scene.call_deferred()
