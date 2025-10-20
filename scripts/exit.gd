extends Area2D

var file_path = "res://levels/Level"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		SoundManager.stop_looping_sfx("player_move")
		SoundManager.stop_sounds()
		SoundManager.play_sfx("next_level")
		Global.curr_score = Global.level_count
		if (Global.curr_score) > Global.best_score:
			Global.best_score = Global.curr_score
		
		Global.level_count += 1
		Global.new_level = true
		get_tree().reload_current_scene.call_deferred()
