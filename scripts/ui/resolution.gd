extends Node

# ======================
# == BUTTON FUNCTIONS ==
# ======================
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
