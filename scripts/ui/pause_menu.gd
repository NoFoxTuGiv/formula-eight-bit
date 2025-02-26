extends Control

@onready var pause: VBoxContainer = $MarginContainer/Pause
@onready var pause_settings: VBoxContainer = $MarginContainer/PauseSettings


func _ready() -> void:
	#self.hide()
	pause.show()
	pause_settings.hide()


# ======================
# == BUTTON FUNCTIONS ==
# ======================
func _on_resume_pressed() -> void:
	pass # Replace with function body.
func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_settings_pressed() -> void:
	pause.hide()
	pause_settings.show()

func _on_back_pressed() -> void:
	pause_settings.hide()
	pause.show()

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
