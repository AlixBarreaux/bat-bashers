extends Control
class_name PauseMenuUI


func disable() -> void:
	self.set_process_unhandled_key_input(false)
	self.hide()


func on_game_over() -> void:
	self.disable()


func _ready() -> void:
	self.hide_menu()
	Events.game_over.connect(on_game_over)


func show_menu() -> void:
	self.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().set_pause(true)


func hide_menu() -> void:
	self.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().set_pause(false)


func toggle_menu_visible() -> void:
	if self.is_visible():
		self.hide_menu()
	else:
		self.show_menu()


func _unhandled_key_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		self.toggle_menu_visible()


func _on_resume_button_pressed() -> void:
	self.hide_menu()
