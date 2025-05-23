extends Node3D
class_name MobSpawner


@export var mob_scene: PackedScene = null

@onready var marker_3d: Marker3D = $Marker3D


func _ready() -> void:
	assert(self.mob_scene != null)


func _on_spawn_timer_timeout() -> void:
	var mob_instance: Mob = mob_scene.instantiate()
	get_tree().get_root().add_child(mob_instance)
	mob_instance.set_global_position(marker_3d.get_global_position())
