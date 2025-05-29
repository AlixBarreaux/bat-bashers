extends Node
#class_name Settings


var camera_sensitivity: float = 0.07
signal camera_sensitivity_changed(value: float)
func set_camera_sensitivity(value: float) -> void:
	camera_sensitivity = value
	camera_sensitivity_changed.emit(value)

var min_camera_sensitivity: float = 0.01
var max_camera_sensitivity: float = 3.0


func _ready() -> void:
	TranslationServer.set_locale(OS.get_locale())
