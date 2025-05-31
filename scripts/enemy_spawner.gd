extends Node3D
class_name EnemySpawner


@export var enemy_scene: PackedScene = null

@onready var spawn_timer: Timer = %SpawnTimer
@onready var marker_3d: Marker3D = $Marker3D


func disable_entity_spawning() -> void:
	spawn_timer.stop()


func on_game_over() -> void:
	self.disable_entity_spawning()


var spawn_timer_min_wait_time: float = 1.0
var spawn_timer_wait_time_substractor: float = 3.0


func reduce_spawn_timer_wait_time() -> void:
	spawn_timer.set_wait_time(spawn_timer.get_wait_time() - self.spawn_timer_wait_time_substractor)


func get_spawn_speed_rate_maxed_out() -> bool:
	if spawn_timer.get_wait_time() <= self.spawn_timer_min_wait_time:
		return true
	return false


func _ready() -> void:
	assert(self.enemy_scene != null)
	Events.game_over.connect(on_game_over)


func spawn_enemy() -> void:
	var enemy_instance: Enemy = enemy_scene.instantiate()
	get_tree().get_current_scene().add_child(enemy_instance)
	enemy_instance.set_global_position(marker_3d.get_global_position())


func _on_spawn_timer_timeout() -> void:
	self.spawn_enemy()
