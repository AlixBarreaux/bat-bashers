extends Panel
class_name SettingsMenu


@onready var h_slider: HSlider = %HSlider
@onready var spin_box: SpinBox = %SpinBox


func _ready() -> void:
	self.h_slider.set_step(0.01)
	self.h_slider.set_min(Settings.min_camera_sensitivity)
	self.h_slider.set_max(Settings.max_camera_sensitivity)
	self.h_slider.set_value(Settings.camera_sensitivity)
	
	self.spin_box.set_step(0.01)
	self.spin_box.set_min(Settings.min_camera_sensitivity)
	self.spin_box.set_max(Settings.max_camera_sensitivity)
	self.spin_box.set_value(Settings.camera_sensitivity)


func _on_h_slider_value_changed(value: float) -> void:
	# BUG (Engine): min_value triggers the value_changed signal but should not
	# This workaround ensures if the min_value is provided it won't be set here.
	if self.h_slider.value == Settings.min_camera_sensitivity:
		return

	Settings.set_camera_sensitivity(value)
	self.spin_box.set_value(value)


func _on_spin_box_value_changed(value: float) -> void:
	# BUG (Engine): min_value triggers the value_changed signal but should not
	# This workaround ensures if the min_value is provided it won't be set here.
	if self.spin_box.value == Settings.min_camera_sensitivity:
		return
	Settings.set_camera_sensitivity(value)
	self.h_slider.set_value(value)


func _on_back_button_pressed() -> void:
	self.hide()
