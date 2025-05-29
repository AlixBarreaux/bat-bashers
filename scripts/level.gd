extends Node3D
class_name Level


func _ready() -> void:
	Events.game_started.emit()
