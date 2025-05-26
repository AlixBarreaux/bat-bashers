extends Area3D
class_name HurtBox


@export var health_scene: Health = null


func enable() -> void:
	for collision_shape: CollisionShape3D in self.get_children():
		collision_shape.set_deferred("disabled", false)


func disable() -> void:
	for collision_shape: CollisionShape3D in self.get_children():
		collision_shape.set_deferred("disabled", true)


func _ready() -> void:
	assert(health_scene != null)


func receive_hitbox_info(damage_value: int) -> void:
	health_scene.take_damage(damage_value)
