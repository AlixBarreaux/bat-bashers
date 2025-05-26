extends HBoxContainer
class_name PlayerHealthUI


@export var health_scene: Health = null

@onready var progress_bar: ProgressBar = %ProgressBar


func _ready() -> void:
	assert(self.health_scene != null)
	health_scene.increased.connect(on_health_increased)
	health_scene.decreased.connect(on_health_decreased)
	
	progress_bar.set_min(0)
	progress_bar.set_max(health_scene.max_health)
	progress_bar.set_value(health_scene.health)


func on_health_decreased(_value: int) -> void:
	progress_bar.set_value(health_scene.health)


func on_health_increased(_value: int) -> void:
	progress_bar.set_value(health_scene.health)
