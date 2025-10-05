extends Area2D

var file_path = "res://levels/Level"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level_num = current_scene_file.to_int() + 1
		
		var next_level_path = file_path + str(next_level_num) + ".tscn"
		get_tree().change_scene_to_file.call_deferred(next_level_path)
