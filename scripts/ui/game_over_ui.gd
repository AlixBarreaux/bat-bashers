extends PanelContainer
class_name GameOverUI


func on_game_over() -> void:
	self.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _ready() -> void:
	self.hide()
	Events.game_over.connect(on_game_over)


func _on_play_again_button_pressed() -> void:
	get_tree().reload_current_scene()
