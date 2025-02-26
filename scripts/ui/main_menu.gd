extends Node

# ======================
# == BUTTON FUNCTIONS ==
# ======================
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tracks/test_track.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/settings.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
