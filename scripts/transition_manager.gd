extends Node

@onready var transition_scene = preload("res://scenes/TransitionLayer.tscn")
var transition_layer: Node = null

func _ready():
	transition_layer = transition_scene.instantiate()
	get_tree().root.call_deferred("add_child", transition_layer)
	await wait_until_tree_layer()
	transition_layer.layer = 9999
	transition_layer.process_mode = Node.PROCESS_MODE_ALWAYS

func wait_until_tree_layer():
	while not transition_layer or not transition_layer.is_inside_tree():
		await get_tree().process_frame

func ensure_layer_initialized():
	await wait_until_tree_layer()
	while not transition_layer or not transition_layer.is_inside_tree():
		await get_tree().process_frame

# Scene fade functions
func change_scene_fade(scene_path: String, fade_time = 0.5):
	await transition_layer.fade_in(fade_time)
	get_tree().change_scene_to_file(scene_path)
	await get_tree().process_frame
	await transition_layer.fade_out(fade_time)

func reload_scene_fade(fade_time = 0.5):
	var current = get_tree().current_scene.scene_file_path
	await change_scene_fade(current, fade_time)

func fade_in(duration: float = 0.5):
	await ensure_layer_initialized()
	await transition_layer.fade_in(duration)

func fade_out(duration: float = 0.5):
	await ensure_layer_initialized()
	await transition_layer.fade_out(duration)

# UI fade functions
func fade_in_ui(ui_node: Control, duration := 0.25):
	if not is_instance_valid(ui_node):
		push_warning ("fade_in_ui() called on invalid node")
		return
	
	ui_node.visible = true
	ui_node.modulate.a = 0.0
	
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.set_parallel(true)
	tween.tween_property(ui_node, "modulate:a", 1.0, duration)
	await tween.finished

func fade_out_ui(ui_node: Control, duration := 0.25):
	if not is_instance_valid(ui_node):
		push_warning ("fade_out_ui() called on invalid node")
		return
	
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.set_parallel(true)
	tween.tween_property(ui_node, "modulate:a", 0.0, duration)
	await tween.finished
	ui_node.visible = false
