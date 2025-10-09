extends Area2D

var file_path = "res://levels/Level"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.level_count +=1
		get_tree().reload_current_scene.call_deferred()
