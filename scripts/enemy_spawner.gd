extends Node3D
class_name EnemySpawner


@export var enemy_scene: PackedScene = null

@onready var spawn_timer: Timer = %SpawnTimer
@onready var marker_3d: Marker3D = $Marker3D


func disable_entity_spawning() -> void:
	spawn_timer.stop()


func on_game_over() -> void:
	self.disable_entity_spawning()


func _ready() -> void:
	assert(self.enemy_scene != null)
	Events.game_over.connect(on_game_over)


func _on_spawn_timer_timeout() -> void:
	var enemy_instance: Enemy = enemy_scene.instantiate()
	get_tree().get_current_scene().add_child(enemy_instance)
	enemy_instance.set_global_position(marker_3d.get_global_position())
