extends Node3D
class_name EnemySpawner


@export var enemy_scene: PackedScene = null

@onready var marker_3d: Marker3D = $Marker3D


func _ready() -> void:
	assert(self.enemy_scene != null)


func _on_spawn_timer_timeout() -> void:
	var enemy_instance: Enemy = enemy_scene.instantiate()
	get_tree().get_root().add_child(enemy_instance)
	enemy_instance.set_global_position(marker_3d.get_global_position())
